#include "usertraps.h"
#include "misc.h"
#include "spawn.h"

void main (int argc, char *argv[])
{
  int i;                          // Loop index variable
  SharedMemPage *smp;             // Used to get address of shared memory page
  int h_mem;                   // Used to hold handle to shared memory page
  char h_mem_str[10];
  sem_t semProcs;   // Semaphore used to wait until all spawned processes have completed
  mbox_t mboxS2;    // Mailbox for S2
  mbox_t mboxS;     // Mailbox for S
  mbox_t mboxCO;    // Mailbox for CO
  mbox_t mboxO2;    // Mailbox for O2
  mbox_t mboxC2;    // Mailbox for C2
  mbox_t mboxSO4;   // Mailbox for SO4
  int countS2;
  int countCO;
  int countR3;
  int procsCount;



  if (argc != 3) {
    Printf("Usage: "); Printf(argv[0]); Printf("<number of S2> <number of CO> \n");
    Exit();
  }

  // Convert string from ascii command line argument to integer number
  countS2 = dstrtol(argv[1], NULL, 10); // the "10" means base 10
  countCO = dstrtol(argv[2], NULL, 10); // the "10" means base 10
  Printf("Creating %d S2, %d CO\n", countS2, countCO);
  if (countS2 * 2 < countCO/4)
    countR3 = countS2*2;
  else
    countR3 = countCO/4;
  procsCount = countS2 + countCO + countS2 + countCO/4 + countR3;

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


  // Create Mailbox to not exit this process until all other processes 
  // have signalled that they are complete.  To do this, we will initialize
  // the Mailbox to (-1) * (number of signals), where "number of signals"
  // should be equal to the number of processes we're spawning - 1.  Once 
  // each of the processes has signaled, the Mailbox should be back to
  // zero and the final mbox_wait below will return.
  if ((semProcs = sem_create(-procsCount+1)) == SYNC_FAIL) {
    Printf("Bad mbox_create in "); Printf(argv[0]); Printf("\n");
    Exit();
  }

  //Create mbox for each particle and put into smp
  if ((mboxS2 = mbox_create()) == SYNC_FAIL){
    Printf("Bad mbox_create in mboxS2\n");
    Exit();
  }

  // Open mailbox to prevent deallocation
  if (mbox_open(mboxS2) == MBOX_FAIL) {
    Printf("makeprocs (%d): Could not open mailbox %d!\n", getpid(), mboxS2);
    Exit();
  }

  if ((mboxS = mbox_create()) == SYNC_FAIL){
    Printf("Bad mbox_create  in mboxS\n");
    Exit();
  }

  // Open mailbox to prevent deallocation
  if (mbox_open(mboxS) == MBOX_FAIL) {
    Printf("makeprocs (%d): Could not open mailbox %d!\n", getpid(), mboxS);
    Exit();
  }

  if ((mboxCO = mbox_create()) == SYNC_FAIL){
    Printf("Bad mbox_create in mboxCO\n");
    Exit();
  }

  // Open mailbox to prevent deallocation
  if (mbox_open(mboxCO) == MBOX_FAIL) {
    Printf("makeprocs (%d): Could not open mailbox %d!\n", getpid(), mboxCO);
    Exit();
  }

  if ((mboxO2 = mbox_create()) == SYNC_FAIL){
    Printf("Bad mbox_create in mboxO2\n");
    Exit();
  }

  // Open mailbox to prevent deallocation
  if (mbox_open(mboxO2) == MBOX_FAIL) {
    Printf("makeprocs (%d): Could not open mailbox %d!\n", getpid(), mboxO2);
    Exit();
  }

  if ((mboxC2 = mbox_create()) == SYNC_FAIL){
    Printf("Bad mbox_create in mboxC2\n");
    Exit();
  }

  // Open mailbox to prevent deallocation
  if (mbox_open(mboxC2) == MBOX_FAIL) {
    Printf("makeprocs (%d): Could not open mailbox %d!\n", getpid(), mboxC2);
    Exit();
  }

  if ((mboxSO4 = mbox_create()) == SYNC_FAIL){
    Printf("Bad mbox_create in mboxSO4\n");
    Exit();
  }

  // Open mailbox to prevent deallocation
  if (mbox_open(mboxSO4) == MBOX_FAIL) {
    Printf("makeprocs (%d): Could not open mailbox %d!\n", getpid(), mboxSO4);
    Exit();
  }


  // Put some values in the shared memory, to be read by other processes
  smp->semProcs = semProcs;
  smp->mboxS2 = mboxS2;
  smp->mboxS = mboxS;
  smp->mboxCO = mboxCO;
  smp->mboxO2 = mboxO2;
  smp->mboxC2 = mboxC2;
  smp->mboxSO4 = mboxSO4;


  // Setup the command-line arguments for the new process.  We're going to
  // pass the handles to the shared memory page and the Mailbox as strings
  // on the command line, so we must first convert them from ints to strings.
  ditoa(h_mem, h_mem_str);

  // Now we can create the processes.  Note that you MUST end your call to
  // process_create with a NULL argument so that the operating system
  // knows how many arguments you are sending.
  for (i = 0;i < countS2;++i){
    process_create(INJECTIONS2_TO_RUN, 0, 0, h_mem_str, NULL);
  }
  for (i = 0;i < countCO;++i){
    process_create(INJECTIONCO_TO_RUN, 0, 0, h_mem_str, NULL);
  }
  for (i = 0;i < countS2;++i){
    process_create(REACTION1_TO_RUN, 0, 0, h_mem_str, NULL);
  }
  for (i = 0;i < countCO/4;++i){
    process_create(REACTION2_TO_RUN, 0, 0, h_mem_str, NULL);
  }
  for (i = 0;i < countR3;++i){
    process_create(REACTION3_TO_RUN, 0, 0, h_mem_str, NULL);
  }

  // And finally, wait until all spawned processes have finished.
  if (sem_wait(semProcs) != SYNC_SUCCESS) {
    Printf("Bad semaphore semProcs (%d) in ", semProcs); Printf(argv[0]); Printf("\n");
    Exit();
  }

  // Close mailbox 
  if (mbox_close(mboxS2) == MBOX_FAIL) {
    Printf("makeprocs (%d): Could not close mailbox %d!\n", getpid(), mboxS2);
    Exit();
  }

  // Close mailbox
  if (mbox_close(mboxS) == MBOX_FAIL) {
    Printf("makeprocs (%d): Could not close mailbox %d!\n", getpid(), mboxS);
    Exit();
  }


  // Close mailbox
  if (mbox_close(mboxCO) == MBOX_FAIL) {
    Printf("makeprocs (%d): Could not close mailbox %d!\n", getpid(), mboxCO);
    Exit();
  }

  // Close mailbox 
  if (mbox_close(mboxO2) == MBOX_FAIL) {
    Printf("makeprocs (%d): Could not close mailbox %d!\n", getpid(), mboxO2);
    Exit();
  }

  // Close mailbox 
  if (mbox_close(mboxC2) == MBOX_FAIL) {
    Printf("makeprocs (%d): Could not close mailbox %d!\n", getpid(), mboxC2);
    Exit();
  }

  // Close mailbox 
  if (mbox_close(mboxSO4) == MBOX_FAIL) {
    Printf("makeprocs (%d): Could not close mailbox %d!\n", getpid(), mboxSO4);
    Exit();
  }

  Printf("All other processes completed, exiting main process.\n");


}
