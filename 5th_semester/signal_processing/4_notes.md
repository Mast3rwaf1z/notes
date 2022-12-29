# Lecture 4 notes
pulse != impulse

$\delta$ = dirac delta function:

$\delta(t) = \{^{1\ t=0}_{0\ otherwise}$

Note that when i see the $\delta$ function i should read it as the function is 1 when the expression in the function is 0 and the function is 0 otherwise

$T$ = sample period

$T=\frac{1}{f_s}$

where $f_s$ is the sample frequency

modulating a signal $x_c$ into the modulated signal $x_s$ using the well defined signal $s(t)$ we do it like below

$x_s(t)=x_c(t)\cdot s(t)$

$x_s(t)=x_c(t) \cdot \sum^\infty_{n=-\infty}x_c(t)\delta(t-nT)$

$x_s(t)=\sum^\infty_{n=-\infty}x_c(t)\delta(t-nT)$

$x_s(t)$ is 0 all the time unless $t = nT$

converting into the discrete time domain (x[n]) means to have a set of points in time rather than having a function

an impulse train essentially looks like a discrete time signal

$\omega = \Omega \cdot T$

# exercises
## exercise 4.1
The source signal:

$x_c(t) = sin(2\pi(100)t)$

The value of T:

$T = \frac{1}{400}$

T inserted into the source signal

$x[n] = sin(2\pi(100)n\frac{1}{400})$

the signal reduced

$x[n] = sin(\frac{\pi n}{2})$

## exercise 4.2
We have the sequence:

$x[n] = cos(\frac{\pi}{4}n)$ , $-\infty < n < \infty$

by sampling the signal:

$x_c(t) = cos(\Omega_0t)$ , $-\infty < t < \infty$

at a sampling rate of $1000 \frac{samples}{s}$