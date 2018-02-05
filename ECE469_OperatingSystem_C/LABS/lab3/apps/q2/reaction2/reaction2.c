#include "usertraps.h"
#include "misc.h"

#include "spawn.h"

void main (int argc, char *argv[])
{
  SharedMemPage *smp;             // Used to get address of shared memory page
  int h_mem;                   // Used to hold handle to shared memory page
  sem_t semProcs;    // Semaphore used to wait until all spawned processes have completed
  mbox_t mboxCO;     // Mailbox for CO
  mbox_t mboxC2;     // Mailbox for C2
  mbox_t mboxO2;     // Mailbox for O2
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
  mboxCO = smp->mboxCO;
  mboxC2 = smp->mboxC2;
  mboxO2 = smp->mboxO2;

  // Open the mailbox
  if (mbox_open(mboxCO) == MBOX_FAIL) {
    Printf("reaction2 (%d): Could not open the mailbox!\n", getpid());
    Exit();
  }
  // Open the mailbox
  if (mbox_open(mboxC2) == MBOX_FAIL) {
    Printf("reaction2 (%d): Could not open the mailbox!\n", getpid());
    Exit();
  }
  // Open the mailbox
  if (mbox_open(mboxO2) == MBOX_FAIL) {
    Printf("reaction2 (%d): Could not open the mailbox!\n", getpid());
    Exit();
  }

  if (mbox_recv(mboxCO, sizeof(char), t) == MBOX_FAIL) {
    Printf("Could not recv message to mailbox %d in %s (%d)\n", mboxCO, argv[0], getpid());
    Exit();
  }
  if (mbox_recv(mboxCO, sizeof(char), t) == MBOX_FAIL) {
    Printf("Could not recv message to mailbox %d in %s (%d)\n", mboxCO, argv[0], getpid());
    Exit();
  }
  if (mbox_recv(mboxCO, sizeof(char), t) == MBOX_FAIL) {
    Printf("Could not recv message to mailbox %d in %s (%d)\n", mboxCO, argv[0], getpid());
    Exit();
  }
  if (mbox_recv(mboxCO, sizeof(char), t) == MBOX_FAIL) {
    Printf("Could not recv message to mailbox %d in %s (%d)\n", mboxCO, argv[0], getpid());
    Exit();
  }


  if (mbox_send(mboxO2, sizeof(char), (void *)'0') == MBOX_FAIL) {
    Printf("Could not send message to mailbox %d in %s (%d)\n", mboxO2, argv[0], getpid());
    Exit();
  }
  // Print a message to show that a char is consumed
  Printf("O2 created\n");
  if (mbox_send(mboxO2, sizeof(char), (void *)'0') == MBOX_FAIL) {
    Printf("Could not send message to mailbox %d in %s (%d)\n", mboxO2, argv[0], getpid());
    Exit();
  }
  // Print a message to show that a char is consumed
  Printf("O2 created\n");

  if (mbox_send(mboxC2, sizeof(char), (void *)'0') == MBOX_FAIL) {
    Printf("Could not send message to mailbox %d in %s (%d)\n", mboxC2, argv[0], getpid());
    Exit();
  }
  // Print a message to show that a char is consumed
  Printf("C2 created\n");

  if (mbox_send(mboxC2, sizeof(char), (void *)'0') == MBOX_FAIL) {
    Printf("Could not send message to mailbox %d in %s (%d)\n", mboxC2, argv[0], getpid());
    Exit();
  }
  // Print a message to show that a char is consumed
  Printf("C2 created\n");

  // Close mailbox 
  if (mbox_close(mboxCO) == MBOX_FAIL) {
    Printf("reaction2 (%d): Could not close mailbox %d!\n", getpid(), mboxCO);
    Exit();
  }

  // Close mailbox 
  if (mbox_close(mboxC2) == MBOX_FAIL) {
    Printf("reaction2 (%d): Could not close mailbox %d!\n", getpid(), mboxC2);
    Exit();
  }

  // Close mailbox 
  if (mbox_close(mboxO2) == MBOX_FAIL) {
    Printf("reaction2 (%d): Could not close mailbox %d!\n", getpid(), mboxO2);
    Exit();
  }


  // Signal the semaphore to tell the original process that we're done
  if(sem_signal(semProcs) != SYNC_SUCCESS) {
    Printf("Bad semaphore s_procs_completed (%d) in ", semProcs); Printf(argv[0]); Printf(", exiting...\n");
    Exit();
  }
}
