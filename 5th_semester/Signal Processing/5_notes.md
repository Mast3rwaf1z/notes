# Lecture 5 notes
## Analog filters
we don't need to know the theory about capacitors and inductors

we'll most likely need to apply ohms law $V_R = i_R \cdot R$

a capacitor can store energy

a capacitor consists of two plates that are isolated from each other. When this capacitor is connected to power it will build up a magnetic field and let the current through the capacitor

If we interpret the capacitor as a resistor it will have a complex resistance, this is denoted by impedance $Z_c$ and Ohm's law becomes $V_c = i_c \cdot Z_c$

a DC source connected to a capacitor means that the current $i_c = 0$

The circuit won't work unless a resistor is added before the capacitor, this is called an RC circuit

the impedance $Z_c = \frac{1}{j\Omega C}$ is infinite in a DC circuit

On wednesday we will see how to calculte the output signal which is a function of the input signal: $y(t)=f_1(x(t))$ and the laplace transform $Y(s)=f_2(X(s))$

the inductor(spole) is in many ways the opposite of a capacitor

An active filter contains an amplifier(OpAmp)

$H(s)$ is known as the transfer function, it is found by laplace transforming the impulse response $H(s)=f\{h(t)\}$

$\Omega = 2\pi f$

$f = \frac{1}{t_p}$

where $t_p$ is one period

A transfer function $H(s)$ is defined by $H(s) = H(\sigma + j\omega) = H(j\omega)$ if $\sigma$ is 0

modulus of a transfer function is called the aplitude response

the phase response is defined likewise as the argument of $H(j\omega)$, it is denoted by $Arg(H(j\omega))$

modulus  of the transfer function is one if $\Omega_0$ is larger than or equal to $\Omega$: $|H(j\omega)| = \{^{1 |\Omega|\le \Omega_0}_{0 otherwise}$
