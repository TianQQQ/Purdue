#include "lab2-api.h"
#include "usertraps.h"
#include "misc.h"

#include "spawn.h"

void main (int argc, char *argv[])
{
  SharedMemPage *smp;             // Used to get address of shared memory page
  uint32 h_mem;                   // Used to hold handle to shared memory page
  sem_t semProcs; // Semaphore used to wait until all spawned processes have completed
  sem_t semS2;    // Semaphore for S2
  int countS2; 
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
  semProcs = smp->semProcs;
  semS2 = smp->semS2;
  countS2 = smp->countS2;

  for(i = 0;i < countS2;++i){
    
    if(sem_signal(semS2) != SYNC_SUCCESS){
      Printf("S2 sem signal failure!!! pid: %d\n", getpid());
    }
    // Print a message to show that a char is consumed
    Printf("S2 created\n");

  }


  // Signal the semaphore to tell the original process that we're done
  if(sem_signal(semProcs) != SYNC_SUCCESS) {
    Printf("Bad semaphore s_procs_completed (%d) in ", semProcs); Printf(argv[0]); Printf(", exiting...\n");
    Exit();
  }
  Printf("All S2 have been created!!!\n");
}
