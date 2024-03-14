# ex1
calculate cpu utilization:

$U = \sum_{i=1}^{N} {c_i\over T_i}$

calculate the function to determine the upper bound of the system:

$R(t) \leq \sum_{i=1}^{N} c_i + (U - 1) \times t$

## exercise
$T_1 = 5$

$T_2 = 8$

$c_1 = 3$

$c_2 = 3$

$U = {3 \over 5} + {3 \over 8} = 0.975$

$R(t) \leq (3 + (0.975 - 1) \times t) + (3 + (0.975 - 1) \times t)$

$R(t) \leq 5.95t$

Round robin implementation with time slot 1

<image src="round robin2.drawio.png">

Since the utilization is less than 1 then it can be seen as feasable.

# ex2
slot time: 4

round robin scheduling - 

T1 = 4

T2 = 12

c1 = 3

c2 = 2

round robin is not possible, there is an attempt to show it below:

<image src="round robin.drawio.png">

this is because round robin would never schedule more than half of the cpu time for a given task except if there is only one task to be executed

if the utilization is less than 1, then the system is feasable, in this case the utilization would be: 

$U = {3 \over 4} + {2 \over 12} = 0.91$

# ex5
