# exercises

## 1

**a)** $({\frac12}^nu[n])$

For this first equation, the sequence x[n] is defined
$$x[n]=\left(\frac12\right)^nu[n]$$
For the second equation the z-transform is defined for this sequence is defined
$$X(z) = \sum_{n=\infty}^\infty x[n]z^{-n}$$
For the third equation the sequence x[n] is inserted into the z-transform
$$X(z) = \sum_{n=0}^\infty \left(\frac12\right)^nz^{-n}$$
For the fourth equation the second expression in the summation is substituted with a simpler term following the pattern: $a^{-b}=\frac1a^b$
$$X(z) = \sum_{n=0}^\infty \left(\frac12\right)^n\left(\frac1z\right)^n$$
For the fifth equation the two expressions being multiplied with the same power is combined into a single fraction following the following rules: $a^nb^n = ab^n$ and $\frac ab\frac ac = \frac a{bc}$
$$X(z) = \sum_{n=0}^\infty \left(\frac1{2z}\right)^n$$
For the sixth equation, the following rule is defined where a summation can be converted into a regular function, a fraction if the upper expression in the summation is larger or equal to the lower expression.
$$\sum_{k=N_1}^{N_2}a^k=\frac{a^{N_1}-a^{N_2+1}}{1-a} for: N_2 \geq N_1$$
For the seventh equation the rule above is used. Here it should be noted that an expression raised to the power of 0 always equals 1 and a fraction raised to the power of $\infty$ is always 0 as the fraction will approach 0 the closer it comes to infinity.
$$X(z)=\frac{(\frac1{2z})^0-(\frac1{2z})^{\infty+1}}{1-\frac1{2z}}$$
For the eigth expression the rules explained there is used and the function is reduced
$$X(z)=\frac{1-0}{1-\frac1{2z}}$$
For the ninth expression the function is scaled such that the expression is reduced even more.
$$X(z)=\frac{z(1)}{z(1-\frac1{2z})}=\frac z{z-\frac12}$$

This proceedure is used for all exercises onwards.

Slide 22 in lecture 3 shows that there is a pole in $\frac12$

Slide 23 in lecture 3 shows that $|z|<|a|$ so the ROC becomes:

$$|z|>\frac12$$

**b)** $-\left(\frac12\right)^nu[-n-1]$

$$x[n]=-\left(\frac12\right)^nu[-n-1]$$

$$X(z)=\sum_{n=-\infty}^\infty x[n] z^{-n}$$

$$X(z)=\sum_{n=-\infty}^{-1}\left(\frac12\right)^nz^{-n}$$


$$X(z)=\sum_{n=-\infty}^{-1}\left(\frac12\right)^n\left(\frac1z\right)^n$$

$$X(z)=\sum_{n=-\infty}^{-1}\left(\frac1{2z}\right)^n$$

$$X(z)=\frac{\left(\frac1{2z}\right)^{-\infty}-\left(\frac1{2z}\right)^{-1}}{1-\frac1{2z}} = \infty$$ 

?????