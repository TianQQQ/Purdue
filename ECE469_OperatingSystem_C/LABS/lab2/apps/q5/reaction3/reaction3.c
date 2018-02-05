#include "lab2-api.h"
#include "usertraps.h"
#include "misc.h"

#include "spawn.h"

void main (int argc, char *argv[])
{
  SharedMemPage *smp;             // Used to get address of shared memory page
  uint32 h_mem;                   // Used to hold handle to shared memory page
  sem_t semProcs; // Semaphore used to wait until all spawned processes have completed
  sem_t semS;     // Semaphore for S
  sem_t semO2;    // Semaphore for O2
  sem_t semSO4;   // Semaphore for SO4
  int countS2; 
  int countCO;
  int reactionCount;
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
  semS = smp->semS;
  semO2 = smp->semO2;
  semSO4 = smp->semSO4;
  countCO = smp->countCO;
  countS2 = smp->countS2;

  //calculate reaction count by find min particle
  if(countS2*2 < countCO/4)
    reactionCount = countS2*2;
  else
    reactionCount = countCO/4;

  for(i = 0;i < reactionCount;++i){

    if(sem_wait(semS) != SYNC_SUCCESS){
      Printf("S sem wait failure!!! pid: %d\n", getpid());
    }
    if(sem_wait(semO2) != SYNC_SUCCESS){
      Printf("O2 sem wait failure!!! pid: %d\n", getpid());
    }
    if(sem_wait(semO2) != SYNC_SUCCESS){
      Printf("O2 sem wait failure!!! pid: %d\n", getpid());
    }

    if(sem_signal(semSO4) != SYNC_SUCCESS){
      Printf("SO4 sem signal failure!!! pid: %d\n", getpid());
    }
    Printf("SO4 created\n");
  }


  // Signal the semaphore to tell the original process that we're done
  Printf("Reaction3 completed!!!\n");
  if(sem_signal(semProcs) != SYNC_SUCCESS) {
    Printf("Bad semaphore s_procs_completed (%d) in ", semProcs); Printf(argv[0]); Printf(", exiting...\n");
    Exit();
  }
}
