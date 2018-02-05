#ifndef __USERPROG__
#define __USERPROG__



typedef struct SharedMemPage {
  int numProcs;
  sem_t semProcs; // Semaphore used to wait until all spawned processes have completed
  sem_t semS2;    // Semaphore for S2
  sem_t semS;     // Semaphore for S
  sem_t semCO;    // Semaphore for CO
  sem_t semO2;    // Semaphore for O2
  sem_t semC2;    // Semaphore for C2
  sem_t semSO4;   // Semaphore for SO4
  int countS2; 
  int countCO;
} SharedMemPage;

#define INJECTIONS2_TO_RUN "injectionS2.dlx.obj"
#define INJECTIONCO_TO_RUN "injectionCO.dlx.obj"
#define REACTION1_TO_RUN "reaction1.dlx.obj"
#define REACTION2_TO_RUN "reaction2.dlx.obj"
#define REACTION3_TO_RUN "reaction3.dlx.obj"

#endif
