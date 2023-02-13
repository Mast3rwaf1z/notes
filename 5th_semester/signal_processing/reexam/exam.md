# 2022 Signal Processing Reexam - 20193387 Thomas Møller Jensen

**A.1**

An FIR filter has the impulse response; $h[0] = h[4] = \frac14, h[1] = h[3] = \frac12, h[2] = 1$

**A. Find the difference equation for the filter**

first i want the impulse response written in a more readable way:

$$h[n] = \{\frac14, \frac12, 1, \frac12, \frac14\}$$

the difference equation y[n] is defined in multiple different ways, a common one is: $y[n] = x[n]* h[n]$, but a simpler way to find y[n] would be the z-transform:

$$X(z) = \sum_{n=0}^{\infty}x[n]z^{-n}$$

we'll be using it from 0, as this signal is only defined between 0 and 4

$$H(z) = \frac14+\frac12z^{-1}+z^{-2}+\frac12z^{-3}+\frac14z^{-4}$$

now we use the definition of $H(z)$: $H(z)=\frac{Y(z)}{X(z)}$, so to find $Y(z)$:
$$Y(z) = (\frac14+\frac12z^{-1}+z^{-2}+\frac12z^{-3}+\frac14z^{-4})\cdot X(z)$$

$$Y(z) = \frac14X(z)+\frac12X(z)z^{-1}+X(z)z^{-2}+\frac12X(z)z^{-3}+\frac14X(z)z^{-4}$$

now its just a question of inverse z transform, this is easy for a difference equation as the pairs in the above expression corresponds directly to a form in the difference equation:

$$y[n]=\frac14x[n]+\frac12x[n-1]+x[n-2]+\frac12x[n-3]+\frac14x[n-4]$$

**B. Using the difference equation found in question A, calculate the first 3 samples of the step response.**

the step response means that we consider the unit step sequence $u[n]$ as the value of $x[n]$. The unit step sequence is defined as follows:

$$u[n]=\{\frac{1, n > 0}{0, otherwise}$$

$$\begin{array}{|c|c|}\hline
    y[0] & 0 \\\hline
    y[1] & \frac141 \\\hline
    y[2] & \frac141+\frac121 \\\hline
    y[3] & \frac141+\frac121+1 \\\hline
\end{array}$$

**C. A finite length sequence $x[n] = \{1,2,3\}, 0 \leq n \leq 2$ is used as input to the filter. Calculate the response $y[n], 0 \leq n \leq 2$, using the convolution sum**

convolution sum has the notation:

$$y[n] = x[n]*h[n]$$

it is important to note that * here does NOT mean multiplication, it is equivalent to multiplication for the z-transform though.

the definition of the operation is the following equation:

$$y[n]=\sum_{k=-\infty}^{\infty}x[k]h[n-k]$$

This will perform an operation similar to a sliding window

so we have to calculate y[n] for the values 0, 1 and 2:

$$y[0] = x[0]h[0]=\frac14$$

$$y[1] = x[0]h[1]+x[1]h[0]=\frac12+2\frac{1}4$$

$$y[2] = x[0]h[2]+x[1]h[1]+x[2]h[0] = 1+1+3\frac14$$

**D. Find the pole location of the filter. *Hint: it might be useful to first establish the transfer function H(z)***

we already have the transfer function from A, so we will reuse that, but i want it on a different form so we will start with Y(z):

$$Y(z) = \frac14X(z)+\frac12X(z)z^{-1}+X(z)z^{-2}+\frac12X(z)z^{-3}+\frac14X(z)z^{-4}$$

we do not have any expression for X, so i will use the definition as mentioned before: $H(z) = \frac{Y(z)}{X(z)}$ and divide by $X(z)$

$$H(z)=\frac{\frac14X(z)+\frac12X(z)z^{-1}+X(z)z^{-2}+\frac12X(z)z^{-3}+\frac14X(z)z^{-4}}{X(z)}$$

$$H(z)=\frac{\frac14+\frac12z^{-1}+z^{-2}+\frac12z^{-3}+\frac14z^{-4}}{1}$$

and as seen in the transfer function, there is a pole in $\frac14$, $\frac12$, and $1$$

**E. Derive the frequency response of the filter.**

The frequency response is defined as:

$$H(e^{j\omega})=DTFT\{h[n]\}$$

so we will calculate the DTFT, DTFT is defined as:

$$H(e^{j\omega})=\sum_{n=-\infty}^{\infty}h[n]e^{-j\omega n}$$

$$H(e^{j\omega})=\frac14+\frac12e^{-j\omega}+e^{-j\omega2}+\frac12e^{-j\omega3}+\frac14e^{j\omega4}$$

**F. You are informed that the filter has a linear phase response. Draw the phase response in the interval $0\leq \omega \leq \frac\pi2$. Argue your answer**

The phase response is defined as: $\arg\{H(j\omega)\}$

so we can assume that $\arg\{H(j\omega)\}$ will look like this:

$$\arg\{H(e^{j\omega})\}=\omega+\omega2+\omega3+\omega4$$

this definition follows a linear function of the definition $\alpha x+\beta$, with $\alpha$ in each of these being 1, 2, 3, and 4. it is plotted below:

<image src="phase_response.png">

**G. The filter is executed using a sample frequency f_s=1kHz. How often is a new sample available on the filter output**

The frequency directly corresponds to time:

$$1kHz=10^{-3}s=1ms$$

so there should be a new sample ready every 1 millisecond.

**H. How many arithmetic operations are needed to calculate one sample y[n]**

**I. Is it possible to somehow reduce the number of arithmetic operations found in question H? Argue your anser.**

**J. You are informed that the filter has two complex conjugated zero pairs in $-0.7429+-j1.5291$ and $-0.2571+-j0.5291$, respectively. Draw the pole/zero diagram.**

<image src="pole_zero.png">

**K. Discuss whether the filter is stable. Argue your answer.**

The filter is not stable, as there are zeroes outside the region of convergence (ROC), if the filter were to be stable, we would want every zero to be inside the region of convergence.

**L. Assume that the output of thefilter, $y[n]$, is next passed through an LTI-system with the transfer function $G(z)=z^{-M}$ to generate the modified output $y'[n]$**

I don't have time to consider what is needed for this question as time is running out for the exam, so i will just answer with what i intuitively would think is correct:

$$y'[n]=y[n]*g[n]$$

so the proceedure would go like

$$y'[n]=\mathcal{Z}^{-1}\{Y(z)G(z)\}$$

and then solve that...

**B.1**

**B.2**

A continuous-time signal is generated by adding two sinusoids, $x_c(t)=\sin(\Omega_1t) + \sin(\Omega_2t)$

**A. Calculate the lowest possible sample frequency needed if we want to sample x_c(t) into x[n] without aliasing. Give the result in Hz.**
the lowest possible sample frequency should be equal to the nyquist frequency, the nyquist frequency is found by considering the highest freqency in a period.

First we need to find the frequency response, we have the signal in the time domain 

once again i'm out of time, and i'm gonna guess it to be the frequency contained in the definition of the highest $\Omega$ value given: 

$$f_2 = \frac{\Omega_2}{\pi}= 3000.00701530499 Hz$$
**B.3**

One period of a discrete-time square-wave signal is given as

$$x[n] = \{\frac{1, 0\leq n \leq 1}{0, 2\leq n \leq 7}$$

(disregard the division line, limitation of the math mode)

**A. Use the DFT to calculate X[k]**

the DFT is defined as:

$$X[k] = \sum_{n=0}^{N-1}x[n]W_N^{kn}$$

inserting x[n] for $N = 7$:

$$X[k] = 1+e^{-j0.8976k}$$

****

**B. Explain how we should interpret $\arg\{X[4]\}$**

what is meant when writing $arg$ in an expression is the phase response, for this particular example it means the value of the phase response for the value 4. the phase response is determined as the imaginary part of the complex exponential. Therefore the result is using python:

```python
import cmath

print(0.8975979010256552*4)
output ------------------------
3.5903916041026207
-----------------------------------
cmath.exp(3.5903916041026207j)
output -------------------------
(-0.9009688679024191-0.433883739117558j)
```

The imaginary part of this complex number and the result is thus:

$$arg\{X[4]\}=0.4338$$

**C. You are informed that $|X[7]| = |X[1]|$, $|X[6]| = |X[2]| |X[5]| = X[3]$**

The amplitude response of a periodic signal is always symetrical over $\frac{N}{2}$, this means that we can plot a signal like so:

<image src="symmetry.png">

In this example we see that illustrated.

**B.4**

a 1024-point DFT means a DFT with N=1024

if i remember correctly, the DFT algorithm has a running time of $O(N^2)$, while the FFT algorithm has a running time of either $O(N\cdot \log(N))$ or $O(\log(N))$, thus this is possible with the FFT algorithm, as:

$$1024^2=1048576$$
while

$$1024*\log(1024)=7097.8271$$