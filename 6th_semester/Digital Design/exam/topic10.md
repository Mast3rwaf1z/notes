# Topic 10

## Ex5.4

$$\begin{array}{|l|c|c|}
\hline
    \text{instruction} & \text{value} & comments \\\hline
    \text{LOAD IMMEDIATE 20} & 20 & \text{push 20 to accumulator} \\\hline
    \text{LOAD DIRECT 20} & 40 & \text{push value of register 20 to accumulator} \\\hline
    \text{LOAD INDIRECT 20} & 60 & \text{register 20 points to register 40, push register 40 to accumulator} \\\hline
    \text{LOAD IMMEDIATE 30} & 30 & \text{push 30 to accumulator} \\\hline
    \text{LOAD DIRECT 30} & 50 & \text{push value of register 30 to accumulator}\\\hline
    \text{LOAD INDIRECT 30} & 70 & \text{register 30 points to register 50, push register 50 to accumulator} \\\hline
\end{array}
$$

## Ex5.6

Compute 0-, 1-, 2-, and 3-address machines by writing programs to compute $X = \frac{A + B \times C}{D-E \times F}$

0 addrs
```
PUSH A
PUSH B
PUSH C
MUL
ADD
PUSH D
PUSH F
PUSH E
MUL
SUB
DIV
POP X
```

1 addr
```
LOAD B
MUL C
ADD A
STORE T
LOAD E
MUL F
STORE M
LOAD D 
SUB M
STORE N
LOAD T
DIV N
STORE X
```

2 addrs
```
MOV R0,B
MUL R0,C
ADD R0,A
MOV R1,E
MUL R1,F
MOV R2,D
SUB R2,R1
DIV R0,R2
MOV X,R0
```

3 addrs
```
MUL R0,B,C
ADD R0,R0,A
MUL R1,E,F
SUB R1,D,R1
DIV R1,R0,R1
MOV X,R1
```

## AVR
<img src="/home/mast3r/git/notes/6th_semester/digitalDesign/exam/l10.png">

This architecture has the following components

EEPROM: The program memory, its overwritten when the CPU is flashed

Program Counter: counts the instructions executed

ALU: the logic unit that executes the intructions

General purpose registers: The storage of data to be used