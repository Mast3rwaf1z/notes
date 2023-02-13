# Topic 1 Notes
writing 1st chapter notes/first half later

*   Set operations
$$
\begin{array}{|c|c|c|}
    \hline
    \text{name} & \text{notation} & \text{description} \\\hline
    \text{union} & A \cup B & \text{A combination of set A and set B} \\\hline
    \text{intersection} & A \cap B & \text{the shared elements between set A and set B} \\\hline
    \text{subtraction} & A - B & \text{everything in A that is not in B} \\\hline
    \text{compliment} & \neg A = A^c & \text{everything that is part of S and not part of A} \\\hline
    \text{multiplication} & A X B & \text{example: you have set A = {1,2,3} and set B = {2,4,6}, then A X B would be equal to {(1,2), (1,4), (1,6), (2,2), (2,4), (2,6), (3,2), (3,4), (3,6)}} \\\hline
\end{array}
$$

fix compliment and multiplication notation later

## mutual exclusion
If two sets have only unique elements, for set S = {1,2,3,4,5,6}, set A = {1,2,3} and set B = {4,5,6} will be mutually exclusive(disjoint)

## Propositions
They are usually written by the notation $P(A\cup B)$ for the set $A\cup B$<br>

For the set S, $P(S)$ will always be 1

# Exercises
**Problem 1.1**<br>
Let $S = \{1,2,3,4,5,6,7\}$, $E = \{1,3,5,7\}$, $F = \{7,4,6\}$, $G = \{1,4\}$. Find

**a. $EF$**<br>
EF is the intersection between E and F, these values are $E\cap F=\{7\}$

**b. $E\cup FG$**<br>
first we find FG: $F\cap G = \{4\}$, so $E\cup FG = \{1,3,4,5,7\}$

**c. $EG^c$**<br>
$G^c$ is G's compliment, $G^c=\{2,3,5,6,7\}$, then we need the intersection with E: $EG^c=\{3,5,7\}$

**d. $EF^c\cup G$**<br>
$F^c=\{1,2,3,5\}$<br>
$E\cap F^c=\{1,3,5\}$<br>
$EF^c\cup G=\{1,3,4,5\}$<br><br>
**e. $E^c(F\cup G)$**<br>
$F\cup G=\{1,4,6,7\}$<br>
$E^c=\{2,4,6\}$<br>
$E^c\cap(F\cup G)=\{4,6\}$<br><br>
**f. $EG\cup FG$**<br>
$E\cap G=\{1\}$<br>
$F\cap G = \{4\}$<br>
$=\{1,4\}$

**Problem 1.2**<br>
10 books are randomly placed on a shelf.

**A. How many distinct sequences of books are possible?**<br>
we could consider the set to be $S=\{1,2,3,4,5,6,7,8,9,10\}$, book 1 would have 10 possibilities, book 2 would have 9, book 3 would have 8 ... so book 10 would have 1 possibility. thus there will be $n!$ distinct sequences.

**B. How many distinct sequences of books are possible, if we know that two particular books of those ten books are placed next to each other**<br>
if we consider that the first two books are the particular books, this is its own set: $A=\{1,2\}$ and the set $B = \{A,3,4,5,6,7,8,9,10\}$, we observed that there are 1 less object in S, thus there are now only $9!$ distinct sequences. A only has 2 elements, so it has $2!$ distinct sequences, so all possibilities in this problem will be $9!\cdot 2!$

**Problem 1.3**<br>
Show that the probability that exactly one of the events E or F occurs is equal to $P(E)+P(F)-2P(EF6            )$