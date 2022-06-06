# topic9 - Aperiodic tasks and servers
## Exercise:

$T_{min} =$ minimum interarrival time

$T_{mean} =$ mean interarrival time

$c = $ execution time

The following single-CPU-realtime system is to be executed on a Real Time Operating System with preemptive FP scheduling and immediate ceiling:
*   4 alarms with $T_{min} = 10$ min., $c=10$ ms.
*   1 user input with $T_{min}=250$ ms, $T_{mean}= 2000$ ms, and $c =  10$ ms
*   1 network input with $T_{min} = 10$ ms, $T_{mean}= 10000$ ms, $c = 30$ ms
*   1 real-time control of time critical system, sampling time 100 ms, execution time 10 ms.
*   1 real-time control of time critical system, sampling time 1000 ms, execution time 10 ms.
*   1 screen clock, update frequency 1/10 1/sec, execution time 20 ms.
*   user input and 2 real-time control share a common datastructure access time 10 ms

## solution
