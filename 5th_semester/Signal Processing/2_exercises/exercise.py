from math import exp
from operator import contains
from sys import maxsize
from matplotlib import pyplot as plt

def convolution_sum(f:dict, g:dict) -> dict:
    f_lower_bound = maxsize
    f_upper_bound = -maxsize
    for key in f.keys():
        f_lower_bound = key if key < f_lower_bound else f_lower_bound
        f_upper_bound = key if key > f_upper_bound else f_upper_bound
    
    fg = {}
    for m in range(f_lower_bound, f_upper_bound):
        for n in f.keys():
            if contains(f, m) and contains(g, n-m): fg[n] = f[m] * g[n-m]
    return fg


f = {}
for i in range(0, 5):
    f[i] = i

g = {}
for i in range(10):
    g[i] = 1

print(f'f:  {f}')
print(f'g:  {g}')

fg = convolution_sum(f, g)

print(f'fg: {fg}')
plt.plot([f[key] for key in f.keys()])
plt.plot([g[key] for key in g.keys()])
plt.plot([fg[key] for key in fg.keys()])
plt.legend(["f", "g", "fg"])
plt.ylabel("fg")
plt.show()
