#ifndef __USERPROG__
#define __USERPROG__



typedef struct SharedMemPage {
  int numProcs;
  sem_t semProcs; // Semaphore used to wait until all spawned processes have completed
  mbox_t mboxS2;    // Mailbox for S2
  mbox_t mboxS;     // Mailbox for S
  mbox_t mboxCO;    // Mailbox for CO
  mbox_t mboxO2;    // Mailbox for O2
  mbox_t mboxC2;    // Mailbox for C2
  mbox_t mboxSO4;   // Mailbox for SO4
} SharedMemPage;

#define INJECTIONS2_TO_RUN "injectionS2.dlx.obj"
#define INJECTIONCO_TO_RUN "injectionCO.dlx.obj"
#define REACTION1_TO_RUN "reaction1.dlx.obj"
#define REACTION2_TO_RUN "reaction2.dlx.obj"
#define REACTION3_TO_RUN "reaction3.dlx.obj"

#ifndef NULL
#define NULL (void *)0x0
#endif

#endif
