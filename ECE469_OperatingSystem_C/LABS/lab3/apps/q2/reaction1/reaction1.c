#include "usertraps.h"
#include "misc.h"

#include "spawn.h"

void main (int argc, char *argv[])
{
  SharedMemPage *smp;             // Used to get address of shared memory page
  int h_mem;                   // Used to hold handle to shared memory page
  sem_t semProcs; // Semaphore used to wait until all spawned processes have completed
  mbox_t mboxS2;    // Mailbox for S2
  mbox_t mboxS;     // Mailbox for S
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
  mboxS2 = smp->mboxS2;
  mboxS = smp->mboxS;

  // Open the mailbox
  if (mbox_open(mboxS2) == MBOX_FAIL) {
    Printf("reaction1 (%d): Could not open the mailbox!\n", getpid());
    Exit();
  }
  // Open the mailbox
  if (mbox_open(mboxS) == MBOX_FAIL) {
    Printf("reaction1 (%d): Could not open the mailbox!\n", getpid());
    Exit();
  }

  if (mbox_recv(mboxS2, sizeof(char), t) == MBOX_FAIL) {
    Printf("Could not recv message to mailbox %d in %s (%d)\n", mboxS2, argv[0], getpid());
    Exit();
  }

  if (mbox_send(mboxS, sizeof(char), (void *)'0') == MBOX_FAIL) {
    Printf("Could not send message to mailbox %d in %s (%d)\n", mboxS, argv[0], getpid());
    Exit();
  }

  // Print a message to show that a char is consumed
  Printf("S created\n");

  if (mbox_send(mboxS, sizeof(char), (void *)'0') == MBOX_FAIL) {
    Printf("Could not send message to mailbox %d in %s (%d)\n", mboxS, argv[0], getpid());
    Exit();
  }

  // Print a message to show that a char is consumed
  Printf("S created\n");

  // Close mailbox 
  if (mbox_close(mboxS2) == MBOX_FAIL) {
    Printf("reaction1 (%d): Could not close mailbox %d!\n", getpid(), mboxS2);
    Exit();
  }

  // Close mailbox 
  if (mbox_close(mboxS) == MBOX_FAIL) {
    Printf("reaction1 (%d): Could not close mailbox %d!\n", getpid(), mboxS);
    Exit();
  }

  // Signal the mboxaphore to tell the original process that we're done
  if(sem_signal(semProcs) != SYNC_SUCCESS) {
    Printf("Bad mboxaphore s_procs_completed (%d) in ", semProcs); Printf(argv[0]); Printf(", exiting...\n");
    Exit();
  }
}
