# Transfer function
input, output and impulse response can be changed from a signal in the time domain to the frequency domain

<image src=time_frequency_domain.png>

you can convert signalprocessing equations into equivalent standard mathematical equations by converting it in this way through laplace transform

<image src=laplace.png>

# Z transform
$z = e^{jw}$

eulers formula:

$e^{jw} = \cos(w)+j\sin(w)$

when we consider the above, z can be expressed in the complex plane, using eulers formula it can be changed into a circle with radius 1 **IMPORTANT**

in the frequency domain the function would be a delta function if the Z transform is used

*   Time discrete : x[n]
*   Time continuous x[t]

$X(s)=\int-\infty^\infty(xt) $

DTFT:

$X(e^{jw}) = \sum^\infty_{n=-\infty} x[n] \cdot e^{-jwn}$

when we z transform the signal becomes a function of z

$X(z) = \sum^\infty_{n=-\infty} x[n]z^{-n}$

z is a continous complex variable

# fourier transform
$e⁰ = 1$

the fourier transform converges only on the unit circle

eulers formula:

$e^{jw} = \cos(w)+j\sin(w)$

applied:

$X(e^{jw}) = \sum^\infty_{n=-\infty} x[n] \cdot e^{-jwn} = x[0] + x[1]e^{-jw} + x[2]e^{-j2w}$

$X(e^{jw}) = \sum^\infty_{n=-\infty} x[n] \cdot e^{-jwn} = x[0] + x[1](\cos(w)+j\sin(w))+x[2](\cos(2w)+j\sin(2w))$

if the value of a fourier transform is infinity, then the fourier transform doesn't exist

# Region of Convergence
an area around the aforementioned circle with radius 1 where the values of w in there will make the function converge

# poles
if all poles are within ROC then the system is stable