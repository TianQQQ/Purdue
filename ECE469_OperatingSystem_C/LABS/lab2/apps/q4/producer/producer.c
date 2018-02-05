#include "lab2-api.h"
#include "usertraps.h"
#include "misc.h"

#include "spawn.h"

void main (int argc, char *argv[])
{
  SharedMemPage *smp;        // Used to access missile codes in shared memory page
  uint32 h_mem;            // Handle to the shared memory page
  sem_t semHandle;         // Semaphore to signal the original process that we're done
  lock_t lockHandle;       // Lock handle to prevent race conditions and deadlocks
  cond_t condNEmpty;              // Condition var used to wait for buffer empty
  cond_t condNFull;               // Condition var used to wait for buffer full
  char * outputStr = "Hello world";
  
  int i;

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
  semHandle = smp->semHandle;
  lockHandle = smp->lockHandle;
  condNEmpty = smp->condNEmpty;
  condNFull = smp->condNFull;

  for(i = 0;i < 11;++i){

    if (lock_acquire(lockHandle) != SYNC_SUCCESS){
      Printf("Lock acquire failure!!!\n");
      Exit();
    }
    //Wait until buffer is not full
    while ((smp->head + 1) % BUFFERSIZE == smp->tail){
      if(cond_wait(condNFull) != SYNC_SUCCESS){
	Printf("Cond not full wait failure!!!\n");
	Exit();
      }
    }

    //Boardcast NotEmpty if it was empty
    if(smp->head == smp->tail){
      if(cond_broadcast(condNEmpty) != SYNC_SUCCESS){
	Printf("Cond Not Empty Broadcast failure!!!\n");
	Exit();
	}
    }
    smp->cirBuffer[smp->head] = outputStr[i];
    smp->head = smp->head+1 == BUFFERSIZE ? 0 : smp->head + 1;
    // Print a message to show that a char is consumed
    Printf("Producer %d inserted: %c\n", getpid(), outputStr[i]);
    //Printf("Head %d Tail %d \n", smp->head, smp->tail);
    //      Printf("Producer %d holds the lock %d, head = %d, tail = %d \n", getpid(), smp->lockHandle,smp->head, smp->tail );

    if (lock_release(lockHandle) != SYNC_SUCCESS){
      Printf("Lock release failure!!!\n");
      Exit();
    }

  }


  // Signal the semaphore to tell the original process that we're done
  Printf("Producer: PID %d is complete.\n", getpid());
  if(sem_signal(semHandle) != SYNC_SUCCESS) {
    Printf("Bad semaphore s_procs_completed (%d) in ", semHandle); Printf(argv[0]); Printf(", exiting...\n");
    Exit();
  }
}
