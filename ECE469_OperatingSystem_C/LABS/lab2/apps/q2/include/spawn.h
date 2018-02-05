#ifndef __USERPROG__
#define __USERPROG__



typedef struct SharedMemPage {
  int numProcs;
  sem_t semHandle;
  lock_t lockHandle;
  int head;
  int tail;
  char cirBuffer[BUFFERSIZE];
} SharedMemPage;

#define PRODUCER_TO_RUN "producer.dlx.obj"
#define CONSUMER_TO_RUN "consumer.dlx.obj"

#endif
