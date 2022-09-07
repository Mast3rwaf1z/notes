# Lecture 2
## questions
is the delta function the original signal? or is it signal x?

actually no, the delta function is the unit sample function
## discrete time signal
the signal is only known for each point where weve sampled it

### unit step function
value is 1 forever after n=0

in these cases the value U[n] equals the sum from negative infinity to n

## notation
a signal x is noted as x[n]

a delayed version of a signal is noted x[n-k] where k is a scalar that determines the delay

a positive k is a late observation

a negative k is likewise an early observation

so a k with value 3 would sample at a n value of -3

## discrete time systems
the system T takes a signal x[n] and returns signal y[n]

y[n] always equals x[n - nd] from negative infinity to infinity

## linear systems
there are two operations on linear systems:
* addition
  * 
* scaling

insert figure:
* all signals fed into a systems together equals the y[n] signal

## causal system
the system is causal if all values preceeding the choice of value n0 are the only values that n will be depending on

an example:
y[n] = x[n+1] -x[n] is not causal because the k value of +1 is in the future

## LTI systems - Linear Time Invariant systems
x[k] is considered as a scalar

tile invariance means that the output is always the same regardless of when i ask the system

delay is not accounted for, a delayed signal is the still invariant as long as the output is the same

if we know the impulse response h[n] we can get the y[n] signal for any x[k]

## convolution
convolutional sum equation

often shortened to y[n] = x[n] * h[n]

\* is NOT scaling, its convolution, scaling is denoted by a dot or nothing at all

## impulse response
the impulse response contains multiple samples


