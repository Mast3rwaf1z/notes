# Topic 8 & 9

## 1

I don't know the names of these, but i know the general execution steps...

1.  read the instruction from the stack or something
2.  Fetching the data from a register
3.  calculate in the ALU
4.  store in a register

## 2

The B-bus can only hold one value at a time, as the ALU by design should only take one value at its right entrance, meanwhile at the left entrance it has the value of the H-register, which was loaded previously. The C-bus can load the result of the ALU into multiple registers so it can take multiple values, a bit map should be interpreted as a set of fields.

## 4
```java
ILOAD j
ILOAD m
BIPUSH 8
IADD
IADD
ISTORE i

ILOAD j
ILOAD m
IADD
BIPUSH 8
IADD
ISTORE i
```

## 8
first i'll need to translate the statement into IJVM:

```java
ILOAD j
ILOAD k
IADD
ISTORE i
```

and since we've got GHZ but want time it's neccessary to translate to time:

$$1 Hz = 1 \frac{\text{cycles}}{\text{second}}$$

$$4Ghz = 4 \cdot 10^9 \frac{\text{cycles}}{\text{second}} = \frac{1}{4\cdot10^9} \frac{\text{seconds}}{\text{cycle}} = 0.25\cdot 10^{-9} \text{seconds} = 0.25 \text{ ns}$$

<img src="/home/mast3r/git/notes/6th_semester/digitalDesign/exam/t9e8.jpg">

each of these run once, so:

```
1 main1
2 iload1
3 iload2
4 iload3
5 iload4
6 iload5
7 main1
8 iload1
9 iload2
10 iload3
11 iload4
12 iload5
13 main1
14 iadd1
15 iadd2
16 iadd3
17 main1
18 istore1
19 istore2
20 istore3
21 istore4
22 istore5
23 istore6
```

so there's 23 clock cycles, so:

$$0.25 * 23 = 5.75 \text{ ns}$$