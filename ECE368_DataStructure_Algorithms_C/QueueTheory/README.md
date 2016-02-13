# Queue-Theory
M/M/N/N

Part A is for M/M/1.
Part B is for M/M/N.

An event-driven simulation in C to evaluate the performance of a multipro- cessor system with 64 processors and also a comprehensive report on this project. Report must be typed. The operating environment of the system that needs to be simulated is described below.

1. Assume two types of tasks arriving at the system, having two priority levels; 0 for high, 1 for low. Tasks with priority 0 arrive according to a Poisson process with rate λ0. Similarly, tasks with priority 1 arrive according to a Poisson process with rate λl.

2. Tasks with priority 0 are served first. Tasks with priority 1 are served only if no task with priority 0 is waiting.

3. At the time a task is selected for service, it is broken into multiple sub-tasks and, hence, re- quires a random number of processors. Assume, the number of sub-tasks follows a uniformly distributed random variable with discrete values between 1 and 32. At the time of service, if the desired number of processors are not available for the task present at the front of the queue, that task stays in the queue and the queue is scanned to choose another task that can be served with the current available number of processors. In other words, the first-fit strategy is used for multiprocessor scheduling. You may need to scan the whole queue (starting from the head of the queue) to identify a task for scheduling. The selected task must have the number of sub-tasks which is less than or equal to the number of currently available processors. Assume, scanning of the queue requires 0 time.
• Note, multiples tasks can be loaded in a given scan, provided the number of processors available are sufficient.
• If no task can be loaded from the queue in a given scan, then depending upon the following events, the system proceeds as follows:
a. It must wait till more processors become available, which triggers a new scan. 
b. Some new task with sufficiently small number of sub-tasks arrives, which is then immediately loaded onto the available processors.
c. If both events (a) and (b) happen simultaneously, give preference to event (a)
￼￼
4. Once the processors are allocated to sub-tasks of a task at the start of service, each sub- task uses its allocated processor for a random amount of time which is exponentially distributed
with average of μ1 units of time. When a sub-task of a task completes, it releases its allocated
processor immediately. The freed processor becomes available for other tasks in the queue. At that time, the queue is scanned, as mentioned above. Note, all the subtasks of a task start at the same time, however, upon their completion they independently free their processors,

Note: Additional considerations of Part 1 remain valid.
Preemption: There is no preemption in the system. Once a task is scheduled to a group of
processors, it runs to its completion.

IMPLEMENTATION DETAIL AND REPORTING
Your simulator must accept values for λ0, λ1, and μ at run time. You need to conduct vari-
ous experiments and collect data for five performance parameters, namely: the average waiting
time of type 0 and type 1 tasks, the average queue length, the average utilization of each proces-
sor, and an average load balancing factor (average over all the tasks). These numbers should be
written, in the order given, to the file “proj1_output”, one per line. The average utilization of a
processor is the ratio of the time the processor is performing some useful computation to the total 1−1
time of simulation. The load balancing factor for a task is μmin μmax where 1 is the μ1 μmin
CPU time taken by the longest sub-task and 1 is the CPU time taken by the shortest sub-task μmax
of the task.
Plots for the Report
Use the following parameters for your plots. The values (including the definitions of ρ0 and ρ1) have been chosen to allow stability in the simulation.
Run the simulation for 10,000 arrivals (in each group). Let μ = 0.2
ρ0= λ0/(4* μ)
ρ1= λ1/(4* μ)
Plot results for ρ0 = 0.1, 0.3, 0.5, 0.7 with ρ1 = 0.3 Plot results for ρ1 = 0.1, 0.3, 0.5, 0.7 with ρ0 = 0.3
￼￼￼￼￼￼￼￼￼
Use μ to calculate appropriate values for λ0 and λ1
MODES OF OPERATION AND LENGTH OF SIMULATION
For testing purpose, your simulator must run in two distinct modes. Mode 1 works exactly as described in Part 1. You will simulate the arrival of the specified number of tasks and finish your simulation only when all tasks are completed.

Mode 2 will simulate a predetermined sequence of tasks described in a text file.

• You will write a single program to operate in both modes based on the command line arguments

• The command line format for Mode 1 will be
<executable name> <lambda0> <lambda1> <mu> <number of tasks>
example: project1-B 0.5 0.7 1 15000

• The command line format for Mode 2 will be <executable name> <input file name> example: project1-B input.txt
The input file used in Mode 2 will contain the information for all the tasks to be simulated, one task per line, in order of arrival. The format of a line of this file will be
<arrival time> <priority> <number> <duration list> where “number” is the number of subtasks belonging to a task and the duration
list contains the durations of these sub-tasks . example: 1 0 4 6 7 8 9
The above line would be read as “A task arrives at time 1. This task has priority 0 and breaks up into 4 subtasks, of duration 6, 7, 8 and 9”.

For Mode 2, your program should read to the end of the input file and exit only after all tasks
are completed.
