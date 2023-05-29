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