# Signal Processing

## Calculate the Z-transform for any discrete signal

$$ X(z) = \sum_{n = -\infty}^{\infty} x[n] z^{-n} $$

## Cauchy hadamard (Calculate Region of Convergence (ROC)):

$$ R = \frac{1}{\limsup_{n \to \infty} |x[n]|^{1/n}} $$

## Unit step function:
The unit step function is defined as `u[n]`
$$ X(z) = \sum_{n = 0}^{\infty} \left(\frac{1}{2}\right)^n z^{-n} $$

## neat sum rules

$$\sum_{k=N_1}^{N^2}a^k = \frac{a^{N_1}-a^{N_2+1}}{1-a}$$