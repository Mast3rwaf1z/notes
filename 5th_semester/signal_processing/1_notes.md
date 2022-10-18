# Lecture 1 notes
## sampling
*  time between samples: T\_s
   *  this is constant for one sample
*  when using a sample we use the notation of x[n] rather than x[t] because we are using the sample values set instead of continuous time t
## complex numbers
*  bit confused about why the theta in polar form of 1+j is pi/4 + 2kπ
## signals
*  a signal is a sinusoid function
## impulse response
*  the signal a system receiving a signal will respond with once receiving the initial signal
   *  we know everything about the input based on the response

# exercises
7.

determine whether each of the following signals is periodic. if the signal is periodic, state its period

a. $x[n] = e^{j(\pi n / 6)}$

$e^{j\frac{\pi n}{6}}$

$\frac{2\pi}{\frac{\pi}{6}} = 12$

b. $x[n] = e^{j(3\pi n / 4)}$

we must ensure that $e^{j\frac{3 \pi}{4}} (n+N)$ is true for a pair of k and N

$\frac{3\pi }{4}N = 2\pi k$

first we choose an integer k, this will be 1 for now

$N = \frac{2\pi k}{\frac{3\pi}{4}}= \frac{8\pi k}{3\pi} = \frac{8}{3}k = 8$ for k=3

c. $x[n] = \frac{\sin(\pi n / 5)}{\pi n}$

not possible as the signal is divided by a number larger than the periodic part of the signal

d. $x[n] = e^{j \pi n / \sqrt{2}}$

$N = \frac{2\pi k}{\frac{\pi}{\sqrt{2}}} = \sqrt{2} \cdot 2k$

x[n] is NOT periodic because we cannot find an integer k where the equation in (b) holds.