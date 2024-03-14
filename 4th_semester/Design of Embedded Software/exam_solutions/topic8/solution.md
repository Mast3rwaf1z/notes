# topic8
## exercise 1
DMS scheduling is a type of scheduling where the tasks with the shortest deadlines are assigned the highest priority, that means that if a task T1 with deadline $d_1 = 3$ and another task T2 with deadline $d_2 = 5$ then T1 would always come first, as the DMS scheduler has assigned a higher priority.

to test the schedulability, the following calculation would have to be made:

$\sum_{i=1}^{n} {C_i \over T_i} \leq 1$

the variables in this exercise is as follows:

$T_1 = 4$, $c_1 = 3$, $d_1 = 4$

$T_2 = 12$, $c_2 = 2$, $d_2 = 7$

-   T: period - how much time between new executions of this task
-   c: execution time - how much time does the task take to execute
-   d: deadline - when does this task have to have finished

to evaluate the scheduability, the following calculation is made:

${3\over4}+{2\over12} \leq 1$

$0.91 \leq 1$

which is true so this problem is schedulable
## exercise 2
as the previous exercise, i will analyse the problem

i will not take the semaphore into account as it does not make sense if the utilization is well below 1

the following variables are defined:

$T_1 = 40$, $c_1 = 10$, $d_1 = 20$

$T_2 = 60$, $c_2 = 20$, $d_2 = 30$

$T_3 = 80$, $c_3 = 20$, $d_3 = 80$

then the schedulability is again calculated:

${10\over40}+{20\over60}+{20\over80}\leq 1$

$0.53 \leq 1$

so this problem is schedulable with DMA