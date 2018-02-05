#include "usertraps.h"
#include "misc.h"

#include "spawn.h"

void main (int argc, char *argv[])
{
  SharedMemPage *smp;             // Used to get address of shared memory page
  int h_mem;                   // Used to hold handle to shared memory page
  sem_t semProcs; // Semaphore used to wait until all spawned processes have completed
  mbox_t mboxS;     // Semaphore for S
  mbox_t mboxO2;    // Semaphore for O2
  mbox_t mboxSO4;   // Semaphore for SO4
  char t[1];

  if (argc != 2) { 
    Printf("Usage: "); Printf(argv[0]); Printf(" <handle_to_shared_memory_page>\n"); 
    Exit();
  } 
  
    
  // Convert the command-line strings into integers for use as handles
  h_mem = dstrtol(argv[1], NULL, 10); // The "10" means base 10

  // Map shared memory page into this process's memory space
  if ((smp = (SharedMemPage *)shmat(h_mem)) == NULL) {
    Printf("Could not map the virtual address to the memory in "); Printf(argv[0]); Printf(", exiting...\n");
    Exit();
  }
  // Extract smp data
  semProcs = smp->semProcs;
  mboxS = smp->mboxS;
  mboxO2 = smp->mboxO2;
  mboxSO4 = smp->mboxSO4;


  // Open the mailbox
  if (mbox_open(mboxS) == MBOX_FAIL) {
    Printf("reaction3 (%d): Could not open the mailbox!\n", getpid());
    Exit();
  }
  // Open the mailbox
  if (mbox_open(mboxO2) == MBOX_FAIL) {
    Printf("reaction3 (%d): Could not open the mailbox!\n", getpid());
    Exit();
  }
  // Open the mailbox
  if (mbox_open(mboxSO4) == MBOX_FAIL) {
    Printf("reaction3 (%d): Could not open the mailbox!\n", getpid());
    Exit();
  }

  if (mbox_recv(mboxS, sizeof(char), t) == MBOX_FAIL) {
    Printf("Could not recv message to mailbox %d in %s (%d)\n", mboxS, argv[0], getpid());
    Exit();
  }
  if (mbox_recv(mboxO2, sizeof(char), t) == MBOX_FAIL) {
    Printf("Could not recv message to mailbox %d in %s (%d)\n", mboxO2, argv[0], getpid());
    Exit();
  }
  if (mbox_recv(mboxO2, sizeof(char), t) == MBOX_FAIL) {
    Printf("Could not recv message to mailbox %d in %s (%d)\n", mboxO2, argv[0], getpid());
    Exit();
  }


  if (mbox_send(mboxSO4, sizeof(char), (void *)'0') == MBOX_FAIL) {
    Printf("Could not send message to mailbox %d in %s (%d)\n", mboxSO4, argv[0], getpid());
    Exit();
  }
  // Print a message to show that a char is consumed
  Printf("SO4 created\n");

  // Close mailbox 
  if (mbox_close(mboxS) == MBOX_FAIL) {
    Printf("reaction3 (%d): Could not close mailbox %d!\n", getpid(), mboxS);
    Exit();
  }

  // Close mailbox 
  if (mbox_close(mboxO2) == MBOX_FAIL) {
    Printf("reaction3 (%d): Could not close mailbox %d!\n", getpid(), mboxO2);
    Exit();
  }

  // Close mailbox 
  if (mbox_close(mboxSO4) == MBOX_FAIL) {
    Printf("reaction3 (%d): Could not close mailbox %d!\n", getpid(), mboxSO4);
    Exit();
  }



  // Signal the semaphore to tell the original process that we're done
  if(sem_signal(semProcs) != SYNC_SUCCESS) {
    Printf("Bad semaphore s_procs_completed (%d) in ", semProcs); Printf(argv[0]); Printf(", exiting...\n");
    Exit();
  }
}
