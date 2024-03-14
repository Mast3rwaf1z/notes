import numpy as np
import sympy as sp
from math import exp, sin
import matplotlib.pyplot as plt

maxlen = 200

class DiscreteSignal(dict):
    def __getitem__(self, key):
        if key in self.keys():
            return super().__getitem__(key)
        else: return 0
    def convolve(self, h):
        result = DiscreteSignal()
        for n in range(len(self.keys()) + len(h.keys()) -1):
            result[n] = sum([self[k] * h[n-k] for k in range(len(h.keys()))])
        return result
    
    def tolist(self):
        result = []
        for value in self.values():
            result.append(value)
        return result
    
    def z(self):
        X = lambda z: sum([self[n]*z**(-n) for n in self.keys()])
        return X

    def ROCRadius(self):
        return 1 / np.amax(np.abs(self.tolist()**(1/np.arange(len(self)))))



class ContinuousSignal:
    def __init__(self, f):
        self.f = f

    def __call__(self, t):
        return self.f(t) 

def convolutionExercises():
    a1 = DiscreteSignal({n:1 for n in range(0, 4)})
    a2 = DiscreteSignal({n:1 for n in range(0, 9)})
    b1 = DiscreteSignal({n:n for n in range(0, 4)})
    b2 = a2
    c1 = DiscreteSignal({n:exp(-n/2) for n in range(0, maxlen)})
    c2 = a2
    d1 = c1
    d2 = DiscreteSignal({n:1 for n in range(0, 9)})
    alpha = 0.125
    omega = 0.4
    e1 = DiscreteSignal({n:alpha*exp(-alpha*n) for n in range(0, maxlen)})
    e2 = DiscreteSignal({n:sin(omega*n) for n in range(0, maxlen)})

    print(a1.convolve(a2))
    plt.plot(a1.convolve(a2).tolist())
    plt.show()
    print(b1.convolve(b2))
    plt.plot(b1.convolve(b2).tolist())
    plt.show()
    print(c1.convolve(c2))
    plt.plot(c1.convolve(c2).tolist())
    plt.show()
    print(d1.convolve(d2))
    plt.plot(d1.convolve(d2).tolist())
    plt.show()
    print(e1.convolve(e2))
    plt.plot(e1.convolve(e2).tolist())
    plt.show()

def zTransform():
    x = DiscreteSignal({n:n+1 for n in range(-4, 4)})
    X = x.z()
    z = sp.Symbol("z")
    sp.plot(X(z), (z, -2, 2), ylim=(-10, 10), xlim=(-10, 10))
    plt.show()

def continuousTest():
    x = ContinuousSignal(lambda t: sin(t))
    print(x(10))

def ROCTest():
    x = DiscreteSignal({n:n*2 for n in range(0, 4)})
    print(x.ROCRadius())



if not __name__ == "__main__": exit(0)

#convolutionExercises()
zTransform()
#continuousTest()
#ROCTest()