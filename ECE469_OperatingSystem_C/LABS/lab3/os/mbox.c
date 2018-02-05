#include "ostraps.h"
#include "dlxos.h"
#include "process.h"
#include "synch.h"
#include "queue.h"
#include "mbox.h"


static mbox mboxes[MBOX_NUM_MBOXES];
static mbox_message mboxMsgs[MBOX_NUM_BUFFERS];

char*
dmemcpy (char *to, const char *from, int n)
{
  char	*tokeep = to;
  char	last;

  do {
    // Stop if we're exceeded the maximum string length
    if (n-- <= 0) {
      break;
    }
    last = *(to++) = *(from++);
  } while (1);
  return (tokeep);
}



//-------------------------------------------------------
//
// void MboxModuleInit();
//
// Initialize all mailboxes.  This process does not need
// to worry about synchronization as it is called at boot
// time.  Only initialize necessary items here: you can
// initialize others in MboxCreate.  In other words, 
// don't waste system resources like locks and semaphores
// on unused mailboxes.
//
//-------------------------------------------------------

void MboxModuleInit() {
  int i;
  dbprintf('p', "MboxModuleInit: Starting...\n");
  for(i = 0;i < MBOX_NUM_MBOXES;++i)
    mboxes[i].inuse = 0;
  for(i = 0;i < MBOX_NUM_BUFFERS;++i)
    mboxMsgs[i].inuse = 0;
  dbprintf('p', "MboxModuleInit: Finished.\n");
}

//-------------------------------------------------------
//
// mbox_t MboxCreate();
//
// Allocate an available mailbox structure for use. 
//
// Returns the mailbox handle on success
// Returns MBOX_FAIL on error.
//
//-------------------------------------------------------
mbox_t MboxCreate() {
  mbox_t mboxHandle;
  uint32 intrs;
  //Disable intrs when grabbing a mbox
  intrs = DisableIntrs();
  for(mboxHandle = 0;mboxHandle < MBOX_NUM_MBOXES;mboxHandle++){
    if (mboxes[mboxHandle].inuse == 0){
      mboxes[mboxHandle].inuse = 1;
      break;
    }
  }
  RestoreIntrs(intrs);

  if(mboxHandle == MBOX_NUM_MBOXES){
    printf("Fatal error: All MBOX are used");
    return MBOX_FAIL;
  }
  
  //lock handle init
  if ((mboxes[mboxHandle].lockHandle = LockCreate()) == SYNC_FAIL){
    printf("Fatal error: Fail to create mbox lock");
    exitsim();
  }

  if ((mboxes[mboxHandle].semMsgNFull = SemCreate(MBOX_MAX_BUFFERS_PER_MBOX)) == SYNC_FAIL){
    printf("Fatal error: Fail to create mbox semMsgNFull");
    exitsim();
  }

  if ((mboxes[mboxHandle].semMsgNEmpty = SemCreate(0)) == SYNC_FAIL){
    printf("Fatal error: Fail to create mbox semMsgNEmpty");
    exitsim();
  }

  if(AQueueInit(&mboxes[mboxHandle].msgQueue) != QUEUE_SUCCESS){
    printf("Fatal error: Fail to create mbox msgQueue");
    exitsim();
  }

  if(AQueueInit(&mboxes[mboxHandle].pidQueue) != QUEUE_SUCCESS){
    printf("Fatal error: Fail to create mbox pidQueue");
    exitsim();
  }

  return mboxHandle;
}

//-------------------------------------------------------
// 
// void MboxOpen(mbox_t);
//
// Open the mailbox for use by the current process.  Note
// that it is assumed that the internal lock/mutex handle 
// of the mailbox and the inuse flag will not be changed 
// during execution.  This allows us to get the a valid 
// lock handle without a need for synchronization.
//
// Returns MBOX_FAIL on failure.
// Returns MBOX_SUCCESS on success.
//
//-------------------------------------------------------
int MboxOpen(mbox_t handle) {
  Link *l;
  
  if(handle < 0 || handle >= MBOX_NUM_MBOXES || mboxes[handle].inuse != 1)
    return MBOX_FAIL;

  if((l = AQueueAllocLink((void *)GetCurrentPid())) == NULL){
    printf("Fatal error: Fail to get mbox opener pid");
    exitsim();
  }
  
  if(AQueueInsertLast(&mboxes[handle].pidQueue, l) != QUEUE_SUCCESS){
    printf("Fatal error: Fail to put pid into pidQueue");
    exitsim();
  }
  
  return MBOX_SUCCESS;
}

//-------------------------------------------------------
//
// int MboxClose(mbox_t);
//
// Close the mailbox for use to the current process.
// If the number of processes using the given mailbox
// is zero, then disable the mailbox structure and
// return it to the set of available mboxes.
//
// Returns MBOX_FAIL on failure.
// Returns MBOX_SUCCESS on success.
//
//-------------------------------------------------------
int MboxClose(mbox_t handle) {
  int currentPid;
  Link *l;
  //check valid on handle
  if(handle < 0 || handle >= MBOX_NUM_MBOXES || mboxes[handle].inuse != 1)
    return MBOX_FAIL;
  
  currentPid = GetCurrentPid();

  if(AQueueEmpty(&mboxes[handle].pidQueue) == true){
    l = AQueueFirst(&mboxes[handle].pidQueue);
    
    do{
      if((int)AQueueObject(l) == currentPid){
	AQueueRemove(&l);
	break;
      }
      l = AQueueNext(l);
    }while(l != NULL);
  }

  if(AQueueEmpty(&mboxes[handle].pidQueue) == true){
    if(LockHandleAcquire(mboxes[handle].lockHandle) != SYNC_SUCCESS){
      printf("Fatal Error: Lock aquire failed in MboxClose");
      exitsim();
    }
    while(!AQueueEmpty(&mboxes[handle].msgQueue)){
      l = AQueueFirst(&mboxes[handle].msgQueue);
      ((mbox_message *)AQueueObject(l))->inuse = 0;
      AQueueRemove(&l);
    }
    mboxes[handle].inuse = 0;
    if(LockHandleRelease(mboxes[handle].lockHandle) != SYNC_SUCCESS){
      printf("Fatal Error: Lock release failed in MboxClose");
      exitsim();
    }
  }
  return MBOX_SUCCESS;
}

//Function that checks the existence of pid in the pid Queue
int PidExists(int pid, Queue pidQueue){
  Link *l;
  if(AQueueEmpty(&pidQueue))
    return false;
  l = AQueueFirst(&pidQueue);
  do{
    if((int)AQueueObject(l) == pid)
      return true;
    l = AQueueNext(l);
  }while(l != NULL);
  return false;
}


//-------------------------------------------------------
//
// int MboxSend(mbox_t handle,int length, void* message);
//
// Send a message (pointed to by "message") of length
// "length" bytes to the specified mailbox.  Messages of
// length 0 are allowed.  The call 
// blocks when there is not enough space in the mailbox.
// Messages cannot be longer than MBOX_MAX_MESSAGE_LENGTH.
// Note that the calling process must have opened the 
// mailbox via MboxOpen.
//
// Returns MBOX_FAIL on failure.
// Returns MBOX_SUCCESS on success.
//
//-------------------------------------------------------
int MboxSend(mbox_t handle, int length, void* message) {
  int currentPid;
  int i;
  Link *l;

  
  //check valid on handle
  if(handle < 0 || handle >= MBOX_NUM_MBOXES || mboxes[handle].inuse != 1)
    return MBOX_FAIL;
  
  currentPid = GetCurrentPid();
  if(!PidExists(currentPid, mboxes[handle].pidQueue))
    return MBOX_FAIL;
  
  if(length > MBOX_MAX_MESSAGE_LENGTH)
    return MBOX_FAIL;

  if(SemHandleWait(mboxes[handle].semMsgNFull) != SYNC_SUCCESS){
    printf("Fatal Error: SemWait failed for semMsgNFull");
    exitsim();
  }
  
  if(LockHandleAcquire(mboxes[handle].lockHandle) != SYNC_SUCCESS){
    printf("Fatal Error: Lock aquire failed in MboxSend");
    exitsim();
  }

  //find next empty message struct
  for(i = 0;i < MBOX_NUM_BUFFERS;++i){
    if(mboxMsgs[i].inuse == 0){
      mboxMsgs[i].inuse = 1;
      break;
    }
  }
  //Not enough msg buffers 
  if(i == MBOX_NUM_BUFFERS)
    return MBOX_FAIL;
  
  if(LockHandleRelease(mboxes[handle].lockHandle) != SYNC_SUCCESS){
    printf("Fatal Error: Lock release failed in MboxSend");
    exitsim();
  }

  dmemcpy(mboxMsgs[i].msg, (char *)message, length);
  mboxMsgs[i].length = length;

  if((l = AQueueAllocLink(&mboxMsgs[i])) == NULL){
    printf("Fatal Error: Unable to create mbox msgs in mboxSend");
    exitsim();
  }
  
  AQueueInsertLast(&mboxes[handle].msgQueue, l);

  if(SemHandleSignal(mboxes[handle].semMsgNEmpty) != SYNC_SUCCESS){
    printf("Fatal Error: SemSignal failed for semMsgNEmpty");
    exitsim();
  }
  
  return MBOX_SUCCESS;
}




//-------------------------------------------------------
//
// int MboxRecv(mbox_t handle, int maxlength, void* message);
//
// Receive a message from the specified mailbox.  The call 
// blocks when there is no message in the buffer.  Maxlength
// should indicate the maximum number of bytes that can be
// copied from the buffer into the address of "message".  
// An error occurs if the message is larger than maxlength.
// Note that the calling process must have opened the mailbox 
// via MboxOpen.
//   
// Returns MBOX_FAIL on failure.
// Returns number of bytes written into message on success.
//
//-------------------------------------------------------
int MboxRecv(mbox_t handle, int maxlength, void* message) {
  int currentPid;
  Link *l;
  mbox_message *msg;  

  //check valid on handle
  if(handle < 0 || handle >= MBOX_NUM_MBOXES || mboxes[handle].inuse != 1)
    return MBOX_FAIL;
  
  currentPid = GetCurrentPid();
  if(!PidExists(currentPid, mboxes[handle].pidQueue))
    return MBOX_FAIL;
  

  if(SemHandleWait(mboxes[handle].semMsgNEmpty) != SYNC_SUCCESS){
    printf("Fatal Error: SemWait failed for semMsgNEmpty");
    exitsim();
  }

  if(LockHandleAcquire(mboxes[handle].lockHandle) != SYNC_SUCCESS){
    printf("Fatal Error: Lock aquire failed in MboxSend");
    exitsim();
  }

  l = AQueueFirst(&mboxes[handle].msgQueue);
  msg = (mbox_message *)AQueueObject(l);
  if(msg->length > maxlength)
    return MBOX_FAIL;
  msg->inuse = 0;
  AQueueRemove(&l);
  if(LockHandleRelease(mboxes[handle].lockHandle) != SYNC_SUCCESS){
    printf("Fatal Error: Lock release failed in MboxSend");
    exitsim();
  }
  dmemcpy(message, (void *)msg->msg, msg->length);
  

  if(SemHandleSignal(mboxes[handle].semMsgNFull) != SYNC_SUCCESS){
    printf("Fatal Error: SemSignal failed for semMsgNFull");
    exitsim();
  }
  return msg->length;
}

//--------------------------------------------------------------------------------
// 
// int MboxCloseAllByPid(int pid);
//
// Scans through all mailboxes and removes this pid from their "open procs" list.
// If this was the only open process, then it makes the mailbox available.  Call
// this function in ProcessFreeResources in process.c.
//
// Returns MBOX_FAIL on failure.
// Returns MBOX_SUCCESS on success.
//
//--------------------------------------------------------------------------------
int MboxCloseAllByPid(int pid) {
  int i;
  for(i = 0; i < MBOX_NUM_MBOXES; ++i)
    MboxClose(i);
  return MBOX_SUCCESS;
}
