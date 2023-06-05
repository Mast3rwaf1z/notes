import numpy as np
from sklearn.linear_model import LinearRegression
import matplotlib.pyplot as plt

H = np.array([1,5,15,30,60,120,240,480,720,1440,2880,5760,10080]).reshape(-1, 1)
P = np.array([0.84,0.71,0.61,0.56,0.54,0.47,0.45,0.38,0.36,0.26,0.20,0.16,0.08])

model = LinearRegression()
model.fit(H, P)

print(f'beta_0(A): {model.intercept_}')
print(f'beta_1(B): {model.coef_}')
print(f'determination: {model.score(H, P)}')

H_log = np.log(np.array([1,5,15,30,60,120,240,480,720,1440,2880,5760,10080])).reshape(-1, 1)

model_log = LinearRegression()
model_log.fit(H_log, P)

print(f'beta_0(A): {model_log.intercept_}')
print(f'beta_1(B): {model_log.coef_}')
print(f'determination: {model.score(H_log, P)}')

sigma = np.sqrt((1/(len(H)-2)) * (sum([pow(p - (LinearRegression().fit(H,P).intercept_ + (LinearRegression().fit(H,P).coef_ * h)), 2) for p,h in zip(P, H)])))
sigma_log = np.sqrt((1/(len(H_log)-2)) * (sum([pow(p - (LinearRegression().fit(H_log,P).intercept_ + (LinearRegression().fit(H_log,P).coef_ * h)), 2) for p,h in zip(P, H_log)])))

print(f'sigma: {sigma}')
print(f'sigma(log): {sigma_log}')

b_0 = LinearRegression().fit(H,P).intercept_
b_1 = LinearRegression().fit(H,P).coef_

b_log_0 = LinearRegression().fit(H_log,P).intercept_
b_log_1 = LinearRegression().fit(H_log,P).coef_

Z = np.array([(p - b_0 - (b_1 * h)) for h,p in zip(H, P)])
Z_std = Z/sigma
Z_log = np.array([(p - b_log_0 - (b_log_1 * h)) for h,p in zip(H_log, P)])
Z_log_std = Z_log/sigma_log

print(Z)
print(Z_std)
print(Z_log)
print(Z_log_std)

fig, axes = plt.subplots(2)

ax1:plt.Axes = axes[0]
ax2:plt.Axes = axes[1]

ax1.plot(range(len(Z_std)), Z_std, 'o')
ax1.set_title("Normal")
ax2.plot(range(len(Z_log_std)), Z_log_std, 'o')
ax2.set_title("Logarihmic")
fig.tight_layout()
fig.savefig("6th_semester/probability-statistics/2021_4c.png")
plt.show()


from scipy import stats

print(1- stats.binom.cdf(32, 100, 0.25))

day = np.array(range(1, 10))
deaths = np.array([2,3,5,10,17,28,35,54,55,133])
total = np.array([222,259,400,500,673,1073,1695,2277,2277,5232]).reshape(-1, 1)

ex4a2020model = LinearRegression().fit(total, deaths)

ex4ab_0 = ex4a2020model.intercept_
ex4ab_1 = ex4a2020model.coef_

print(f'slope: {ex4a2020model.coef_}')

print(f'determination: {ex4a2020model.score(total, deaths)}')


# deaths = b_0 * e^{b_1*total}
# ln(deaths) = ln(b_0) * b_1 * total

ex4c2020model = LinearRegression().fit(total, np.log(deaths))

ex4cb_0 = np.exp(ex4c2020model.intercept_)
ex4cb_1 = ex4c2020model.coef_

ex4cdetermination = ex4c2020model.score(total, np.log(deaths))

print(f'b0: {ex4cb_0}')
print(f'b1: {ex4cb_1}')
print(f'determination: {ex4cdetermination}')

n = 1000
k = 268
p0 = .26
from math import factorial as fact

print(f'p-value: {sum([(fact(n)/(fact(i) * fact(n - i))) * pow(p0, i) * pow(1 - p0, n - i) for i in range(k, n)])}')

import sympy

x = sympy.Symbol('x')
theta = sympy.Symbol('theta')



#from scipy import stats
#print(1 - stats.binom.cdf(267,1000,.33))