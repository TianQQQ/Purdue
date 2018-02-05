#include "lab2-api.h"
#include "usertraps.h"
#include "misc.h"

#include "spawn.h"

void main (int argc, char *argv[])
{
  int i;                          // Loop index variable
  SharedMemPage *smp;             // Used to get address of shared memory page
  uint32 h_mem;                   // Used to hold handle to shared memory page
  char h_mem_str[10];
  sem_t semProcs; // Semaphore used to wait until all spawned processes have completed
  sem_t semS2;    // Semaphore for S2
  sem_t semS;     // Semaphore for S
  sem_t semCO;    // Semaphore for CO
  sem_t semO2;    // Semaphore for O2
  sem_t semC2;    // Semaphore for C2
  sem_t semSO4;   // Semaphore for SO4
  int countS2; 
  int countCO;

  if (argc != 3) {
    Printf("Usage: "); Printf(argv[0]); Printf("<number of S2> <number of CO> \n");
    Exit();
  }

  // Convert string from ascii command line argument to integer number
  countS2 = dstrtol(argv[1], NULL, 10); // the "10" means base 10
  countCO = dstrtol(argv[2], NULL, 10); // the "10" means base 10
  Printf("Creating %d S2, %d CO\n", countS2, countCO);

  // Allocate space for a shared memory page, which is exactly 64KB
  // Note that it doesn't matter how much memory we actually need: we 
  // always get 64KB
  if ((h_mem = shmget()) == 0) {
    Printf("ERROR: could not allocate shared memory page in "); Printf(argv[0]); Printf(", exiting...\n");
    Exit();
  }

  // Map shared memory page into this process's memory space
  if ((smp = (SharedMemPage *)shmat(h_mem)) == NULL) {
    Printf("Could not map the shared page to virtual address in "); Printf(argv[0]); Printf(", exiting..\n");
    Exit();
  }


  // Create semaphore to not exit this process until all other processes 
  // have signalled that they are complete.  To do this, we will initialize
  // the semaphore to (-1) * (number of signals), where "number of signals"
  // should be equal to the number of processes we're spawning - 1.  Once 
  // each of the processes has signaled, the semaphore should be back to
  // zero and the final sem_wait below will return.
  if ((semProcs = sem_create(-4)) == SYNC_FAIL) {
    Printf("Bad sem_create in "); Printf(argv[0]); Printf("\n");
    Exit();
  }

  //Create sem for each particle and put into smp
  if ((semS2 = sem_create(0)) == SYNC_FAIL){
    Printf("Bad sem_create in semS2\n");
    Exit();
  }

  if ((semS = sem_create(0)) == SYNC_FAIL){
    Printf("Bad sem_create  in semS\n");
    Exit();
  }

  if ((semCO = sem_create(0)) == SYNC_FAIL){
    Printf("Bad sem_create in semCO\n");
    Exit();
  }

  if ((semO2 = sem_create(0)) == SYNC_FAIL){
    Printf("Bad sem_create in semO2\n");
    Exit();
  }

  if ((semC2 = sem_create(0)) == SYNC_FAIL){
    Printf("Bad sem_create in semC2\n");
    Exit();
  }

  if ((semSO4 = sem_create(0)) == SYNC_FAIL){
    Printf("Bad sem_create in semSO4\n");
    Exit();
  }

  // Put some values in the shared memory, to be read by other processes
  smp->semProcs = semProcs;
  smp->semS2 = semS2;
  smp->semS = semS;
  smp->semCO = semCO;
  smp->semO2 = semO2;
  smp->semC2 = semC2;
  smp->semSO4 = semSO4;
  smp->countS2 = countS2;
  smp->countCO = countCO;

  // Setup the command-line arguments for the new process.  We're going to
  // pass the handles to the shared memory page and the semaphore as strings
  // on the command line, so we must first convert them from ints to strings.
  ditoa(h_mem, h_mem_str);

  // Now we can create the processes.  Note that you MUST end your call to
  // process_create with a NULL argument so that the operating system
  // knows how many arguments you are sending.
  process_create(INJECTIONS2_TO_RUN, h_mem_str, NULL);
  Printf("InjectionS2 process created\n");
  process_create(INJECTIONCO_TO_RUN, h_mem_str, NULL);
  Printf("InjectionCO process created\n");
  process_create(REACTION1_TO_RUN, h_mem_str, NULL);
  Printf("Reaction1 process created\n");
  process_create(REACTION2_TO_RUN, h_mem_str, NULL);
  Printf("Reaction2 process created\n");
  process_create(REACTION3_TO_RUN, h_mem_str, NULL);
  Printf("Reaction3 process created\n");


  // And finally, wait until all spawned processes have finished.
  if (sem_wait(semProcs) != SYNC_SUCCESS) {
    Printf("Bad semaphore semProcs (%d) in ", semProcs); Printf(argv[0]); Printf("\n");
    Exit();
  }
  Printf("All other processes completed, exiting main process.\n");
}
