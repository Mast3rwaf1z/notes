# Probability

## Exam set 2016
**Problem 1: Let a production line consist of 5 components (or robots $R1,\cdots , R5$), two robots in sequence, followed by 3 robots in parallel (see Figure). Each robot $R_i$ functions independently from the others with a probability $p_i$, $i = 1, \cdots , 5$. Find the probability that the whole production line is functioning.**

i'm redefining some things to make these equations readable:
$P(R_i) = P_i$

$P(R_1 \cap R_2 \cap (R_3 \cup R_4 \cup R_5)) = P_1 \cdot P_2 \cdot (P_3 + P(R_4 \cup R_5) - P(R_3 \cap (R_4 \cup R_5)))$

$=P_1 \cdot P_2 \cdot (P_3 + ((P_4 + P_5) - (P_4 * P_5)) - (P_3 * (P_4 + P_5 + (P_4*P_5))))$

**Problem 2:**

A:

Since the data can only originate from one sensor, they have to be mutually exclusive. so the probability of correct data would be $P(S_i) \cap P(S_{id})$ for sensor i

$P(S_1) = 0.99$

$P(S_2) = 0.75$

$P(S_3) = 0.50$

$P(S_{1d}) = 0.50$

$P(S_{2d}) = 0.25$

$P(S_{3d}) = 0.25$

$P((S_1 \cap S_{1d}) \oplus (S_2 \cap S_{2d}) \oplus (S_3 \cap S_{3d})) = P(S_1) * P(S_{1d}) + P(S_2) * P(S_{2d}) + P(S_3) * P(S_{3d}) = 0.8075$

B:

using bayes' rule:

$P(S_i|correct) = P(S_i) \cdot \frac{P(correct|S_i)}{P(correct)}$

for sensor 1: $0.50 \cdot \frac{0.99}{0.8075} = 0.6130030959752322$

for sensor 2: $0.25 \cdot \frac{0.75}{0.8075} = 0.23219814241486067$

for sensor 3: $0.25 \cdot \frac{0.50}{0.8075} = 0.15479876160990713$

so sensor 1 is the most likely to produce the reading.

**Problem 3:**

A:

$E[X] = 0$

$E[Y] = 1$

$Var(X) = 1$

$Var(Y) = 1$

$E[Z] = 2 E[X] - 4 E[Y] + 10$

$E[Z] = 2 * 0 - 4 * 1 + 10 = 6$

to find the variance of Z, we can apply the following rule:

$Var(aX+b) = a^2Var(X)$

because the variance of b will be 0: $Var(b) = 0$

and also since the variables are independant then we can split the expression for X and Y into a sum of the variances:

$Var(Z) = Var(2X - 4Y + 10)$

since 10 can be interpreted as b, we can remove that, X and Y is independant so the expression is as follows:

$Var(Z) = Var(2X) + Var(-4Y)$

finally the expression using the rule defined above:

$Var(Z) = 4 * Var(X) + 16 * Var(Y) = 20$

we can do this because the variance of a number is always the same regardless of being negative or positive

B:

$M = (X - 1)Y$

$E[M] = E[(X - 1)Y]$

$E[M] = E[XY - Y]$

Since X and Y are independant:

$E[M] = E[X] * E[Y] - E[Y] = -1$

C:

$Cov(X, Y) = E[XY] - E[X] * E[Y]$

Since X and Y are independant:

$Cov(X, Y) = E[X] * E[Y] - E[X] * E[Y] = 0$

## Exam Set 2015

**Problem 1:**

A:

$P_X(x)=\sum_{y_j\in R_Y} P_{XY}(x,y_j) \text{\textit{ for any }} x\in R_X$

$P(X=-1) = \frac14 + 0 = \frac14$

$P(X=0) = \frac14 + \frac14 = \frac12$

$P(X=1) = 0 + \frac14 = \frac14$



$P_Y(y)=\sum_{x_i\in R_X} P_{XY}(x_i,y) \text{\textit{ for any }} y\in R_Y$

$P(Y=-1) = \frac14 + \frac14 + 0 = \frac12$

$P(Y=1) = 0 + \frac14 + \frac14 = \frac12$

B:

These values are dependent as:

$P(X=-1) * P(Y=-1) = \frac12 * \frac14 = \frac18$

which is not equal to $P(X=-1, Y=-1)$.

New variables, we just set everything to be $P(X_1=i, Y_1=j) = P(X=i) \cdot P(Y=j)$:

$P(X=-1,Y=-1) = \frac18$

$P(X=0,Y=-1) = \frac14$

$P(X=1,Y=-1) = \frac18$

$P(X=-1,Y=1) = \frac18$

$P(X=0,Y=1) = \frac14$

$P(X=1,Y=1) = \frac18$

C:

Expectation of the PMF is defined by: $E[X] = \sum x_i \cdot P(x_i)$, this is correct as the sum of elements in P should be 1.

$E[X] = -1 * \frac14 + 0 * \frac12 + 1 * \frac14 = 0$

$E[Y] = -1 * \frac12 + 1 * \frac12 = 0$

D:

the covariance matrix is defined by:

$\begin{array}{c|c}
    var(x) & cov(x, y) \\\hline
    cov(x, y) & var(y) \\
\end{array}$

now we have to find the variance of these random variables:

Covariance is defined by: $Cov(X, Y) = E[XY] - E[X] \cdot E[Y]$

where $E[XY] = \sum_{i=0}^\infty \sum_{j=0}^\infty x_i y_i p(x_i,y_i)$

$E[XY] = -1 \cdot -1 \cdot \frac14 + 0 \cdot -1 \cdot \frac14 + 1 \cdot -1 \cdot 0 + -1 \cdot 1 \cdot 0 + 0 \cdot 1 \cdot \frac14 + 1 \cdot 1 \cdot \frac14 =\frac12$

since the expectations of X and Y are 0, the covariance is $\frac12$

the variance is defined by: $var(x) = E[x^2] - E[x]^2$

since $E[x] = 0$ we only have to calculate $E[x^2]$:

$E[x^2] = -1^2 * \frac14 + 0^2 * \frac12 + 1^2 * \frac14 = \frac12$

$E[y^2] = -1^2 * \frac12 + 1^2 * \frac12 = 1$

and thus the matrix is:

$\begin{array}{c|c}
    \frac12 & \frac12 \\\hline
    \frac12 & 1
\end{array}$

the correlation coefficient is defined by $corr(x, y) = \frac{cov(x, y)}{\sqrt{var(x)}\cdot \sqrt{var(y)}}$:

$\frac{\frac12}{\sqrt{\frac12} \cdot \sqrt{1}} = 0.7071067811865475$

it is defined that if this coefficient is 0, then the random variables are uncorrelated, otherwise the closer it is to 1 or -1, the more correlated they are. X and Y are correlated.

E:

The expression can be reused from the previous exercise:

$\sum_{i=0}^{\infty} \sum_{j=0}^{\infty} (2X_i - 4Y_j) \cdot P(X_i, Y_j)$

$(2 \cdot (-1) - 4 \cdot (-1)) \cdot \frac14 + (2 \cdot 0 - 4 \cdot (-1)) \cdot \frac14 + (2 \cdot 1 - 4 \cdot (-1)) \cdot 0 + (2 \cdot (-1) + 4 \cdot 1) \cdot 0 + (2 \cdot 0 - 4 \cdot 1) \cdot \frac14 + (2 \cdot 1 - 4 \cdot 1) \cdot \frac14 = 0$

F:

$E[Z] = \sum_{i=0}^{\infty}\sum_{j=0}^{\infty} X_i\cdot Y_i^2 \cdot P(X_i, Y_j)$

$-1 \cdot -1^2 \cdot \frac14 + 0 \cdot -1^2 \cdot \frac14 + 1 \cdot -1^2 \cdot 0 + -1 \cdot 1^2 \cdot 0 + 0 \cdot 1 \cdot \frac14 + 1 \cdot 1 \cdot \frac14 = 0$

**Problem 2:**

A:

so first we can define that the incorrect selections to be when a boy is selected, thus the probability of correctness would be for one class: $P(girl|2A) = \frac{girls_{2A}}{boys_{2A} + girls_{2A}}$

and the probability that a child is from a given class is defined by: $P(class|child)$

and as such we can define that:

$P(girl|2A) = \frac{12}{18+12} = 0.4$

$P(girl|2B) = \frac{20}{15+20} = 0.5714285714285714$

$P(2A) = 0.5$

$P(2B) = 0.5$

then the probability that the given child is a girl is:

$P(girl|2A) \cdot P(2A|child) + P(girl|2B) \cdot P(2B|child) = 0.4857142857142857$

B:

here we will be using bayes' rule:

$P(2B|girl) = P(2B) \cdot \frac{P(girl|2B)}{P(girl)}$

$P(2B|girl) = 0.5882352941176471$

# Exam set 2021
**Problem 1:**

A:

$P(infected|positive) = 0.8$

$P(infected|negative) = 0.1$

$P(infected|inconclusive) = 0.5$

$P(positive) = 0.07$

$P(negative) = 0.9$

$P(inconclusive) = 0.03$

$P(infected) = P(infected|positive) \cdot P(positive) + P(infected|negative) \cdot P(negative) + P(infected|inconclusive) \cdot P(inconclusive) = 0.161$

B:

using bayes' rule:

$P(A|B) = P(A) \cdot \frac{P(B|A)}{P(B)}$

$P(\overline{infected}) = 1 - P(infected) = 0.839$

$P(\overline{infected}|positive) = 1 - P(infected|positive) = 0.2$

$P(positive|\overline{infected}) = P(positive) \cdot \frac{P(\overline{infected}|positive)}{P(\overline{infected})} = 0.07 \cdot \frac{0.2}{0.839} = 0.0166865315852205$

**Problem 4:**

A:

i'll be using a few python libraries to solve this exercise, A is defined as $\beta_0$ and B is defined as $\beta_1$.

the libraries used were installed with:

`pip install numpy scikit-learn statsmodels`

```py
import numpy as np
from sklearn.linear_model import LinearRegression

H = np.array([1,5,15,30,60,120,240,480,720,1440,2880,5760,10080]).reshape(-1, 1)
P = np.array([0.84,0.71,0.61,0.56,0.54,0.47,0.45,0.38,0.36,0.26,0.20,0.16,0.08])

model = LinearRegression()
model.fit(H, P)

print(f'beta_0(A): {model.intercept_}')
print(f'beta_1(B): {model.coef_}')
print(f'determination: {model.score(H, P)}')
```

```py
beta_0(A): 0.5258702544875726
beta_1(B): [-5.57149608e-05]
determination: 0.5708584468698246
```

B:

repeating the script above, but H is redefied as:

```py
H_log = np.log(np.array([1,5,15,30,60,120,240,480,720,1440,2880,5760,10080])).reshape(-1, 1)
```

```py
beta_0(A): 0.846415414211753
beta_1(B): [-0.07922691]
determination: 0.9898776436636187
```

C:

```py
sigma = np.sqrt((1/(len(H)-2)) * (sum([pow(p - (LinearRegression().fit(H,P).intercept_ + (LinearRegression().fit(H,P).coef_ * h)), 2) for p,h in zip(P, H)])))
sigma_log = np.sqrt((1/(len(H_log)-2)) * (sum([pow(p - (LinearRegression().fit(H_log,P).intercept_ + (LinearRegression().fit(H_log,P).coef_ * h)), 2) for p,h in zip(P, H_log)])))

print(f'sigma: {sigma}')
print(f'sigma(log): {sigma_log}')
```

```py
sigma: array([0.15228411])
sigma(log): array([0.02338811])
```

```py
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
ax2.set_title("Logarithmic")
fig.tight_layout()
plt.show()
```

figure: 

<img src="/home/mast3r/git/notes/6th_semester/probability-statistics/2021_4c.png">

D:

well because the time is not increasing linearly, but seems to be closer to exponentially, its obvious that a X axis scale that is also increasing exponentially would be ideal to analyse the results.

**Problem 5:**

A:

The pdf is written in an unintuitive way so:

$f(x, \lambda) = \lambda \cdot e^{-\lambda x}$

The likelyhood function is defined by:

$\mathcal{L}_n(\theta) = \prod_{i=1}^n f(X_i;\theta)$

where $\theta$ will be the maximum likelyhood estimator

i will be solving the equation using sympy in python, the equation should look as follows:

$\hat{\theta} = \frac{\mathscr{d}\ln{\mathcal{L}_n(\theta)}}{\mathscr{d}\theta}$

because sympy isn't a fan of products, i'll simplify the equation:

$\ln{\mathcal{L}(\theta)} = $

```py
def MLE():
    from sympy import Eq, diff, Product, symbols, Symbol, exp, log, IndexedBase, init_printing, pprint, summation
    init_printing()
    i, n, lmb = symbols('i n lmb')
    x = IndexedBase('x')
    log_likelihood = n * log(lmb) - lmb * summation(x[i], (i,0,n))
    print('log likelihood function:')
    pprint(log_likelihood)
    log_mle = Eq(diff(log_likelihood, lmb).doit(), 0)
    print('mle:')
    pprint(solve(log_mle.simplify(), lmb))
MLE()
```
output:

<img src="/home/mast3r/git/notes/6th_semester/probability-statistics/MLE.png">

B:



**Problem 6:**

H0: $P_0 = 0.25$ 

H1: $P_0 > 0.25$

to find the p-value we employ the following equation:

$\text{p-value} = \sum_{k=33}^{100} \overset{100}{k} p_0^k(1-p_0)^{100-k} = 0.04459632521268153$

or in python
```py
from math import factorial as fact
n = 100
k = 33
p0 = .25
# mathy method
print(f'p-value: {sum([(fact(n)/(fact(i) * fact(n - i))) * pow(p0, i) * pow(1 - p0, n - i) for i in range(k, n)])}')

# library methody thingy
from scipy import stats
print(1 - stats.binom.cdf(32,100,.25))
```

# Exam set 2020

**Problem 4:**

A: 

i'll solve this exercise using python:

```py
day = np.array(range(1, 10))
deaths = np.array([2,3,5,10,17,28,35,54,55,133])
total = np.array([222,259,400,500,673,1073,1695,2277,2277,5232]).reshape(-1, 1)

ex4a2020model = LinearRegression().fit(total, deaths)

ex4ab_0 = ex4a2020model.intercept_
ex4ab_1 = ex4a2020model.coef_

print(f'slope: {ex4a2020model.coef_}')
```

```
slope: [0.02585471]
```

B: 
```py
print(f'determination: {ex4a2020model.score(total, deaths)}')
```

```py
determination: 0.995868478432945
```

C:

```py
# deaths = b_0 * e^{b_1*total}
# ln(deaths) = ln(b_0) * b_1 * total

ex4c2020model = LinearRegression().fit(total, np.log(deaths))

ex4cb_0 = np.exp(ex4c2020model.intercept_)
ex4cb_1 = ex4c2020model.coef_

ex4cdetermination = ex4c2020model.score(total, np.log(deaths))

print(f'b0: {ex4cb_0}')
print(f'b1: {ex4cb_1}')
print(f'determination: {ex4cdetermination}')
```

```py
b0: 5.62438815429471
b1: [0.00075576]
determination: 0.7156959287574766
```

D:

The linear model is much better as both axes are increasing seemingly logarithmically already, so you get a much clearer view using a linear model.

**Problem 5:**

MLE is usually a pain to calculate so i'll do this last if i have time



A:

```py
def MLE():
    from sympy import Eq, diff, Product, symbols, Symbol, exp, log, IndexedBase, init_printing, pprint,
summation
    from sympy.solvers import solve, nsolve
    init_printing()
    i, n, t = symbols('i n t')
    x = IndexedBase('x')
    log_likelihood = (n * log(t + 1)) + summation(log(x[i] ** t), (i,0,n))
    print('log likelihood function:')
    pprint(log_likelihood)
    log_mle = Eq(diff(log_likelihood, t).doit(), 0)
    pprint(log_mle)
    print('mle:')
    pprint(solve(log_mle, t))
MLE()
```

**Problem 6:**

$H_0: p_0 = 0.33$

$H_1: p_0 > 0.33$

i'll calculate the p-value using binomial cdf:

```py
from scipy import stats
print(1 - stats.binom.cdf(268,1000,.33))
```