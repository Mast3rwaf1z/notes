# Topic 1

## Ex1: Show by perfect induction the following relations:

$$(A+B)*(A+C)=A+(B*C)$$

$$\begin{array}{|c|c|c|c|c|c|c|c|}
			\hline
			A & B & C & A+B & A+C & (A+B)*(A+C) & B*C & A+(B*C) \\\hline
			0 & 0 & 0 & 0   & 0   & 0           & 0   & 0       \\\hline
			0 & 0 & 1 & 0   & 1   & 0           & 0   & 0       \\\hline
			0 & 1 & 0 & 1   & 0   & 0           & 0   & 0\\\hline
			0 & 1 & 1 & 1   & 1   & 1           & 1   & 1\\\hline
			1 & 0 & 0 & 1   & 1   & 1           & 0   & 1\\\hline
			1 & 0 & 1 & 1   & 1   & 1           & 0   & 1\\\hline
			1 & 1 & 0 & 1   & 1   & 1           & 0   & 1\\\hline
			1 & 1 & 1 & 1   & 1   & 1           & 1   & 1\\\hline
	\end{array}
$$

$$A*(A+B)=A$$

$$
		\begin{array}{|c|c|c|c|}
			\hline
			A & B & A+B & A*(A+B) \\\hline
			0 & 0 & 0   & 0       \\\hline
			0 & 1 & 1   & 0       \\\hline
			1 & 0 & 1   & 1       \\\hline
			1 & 1 & 1   & 1       \\\hline
		\end{array}$$

$$A+\overline{A}=1$$

$$
		\begin{array}{|c|c|c|}
			\hline
			A & \overline{A} & A+\overline{A} \\\hline
			0 & 1 		   & 1              \\\hline
			1 & 0 		   & 1              \\\hline
		\end{array}
        $$

$$\overline{A+B+C} = \overline{A}*\overline{B}*\overline{C}$$

$$
		\begin{array}{|c|c|c|c|c|c|c|c|c|}
			\hline
			A & B & C & A+B+C & \overline{A+B+C} & \overline{A} & \overline{B} & \overline{C} & \overline{A}*\overline{B}*\overline{C}\\\hline
			0 & 0 & 0 & 0     & 1                & 1            & 1            & 1   	  & 1                                      \\\hline
			0 & 0 & 1 & 1     & 0                & 1            & 1            & 0            & 0                                      \\\hline
			0 & 1 & 0 & 1     & 0                & 1            & 0            & 1            & 0                                      \\\hline
			0 & 1 & 1 & 1     & 0                & 1            & 0            & 0            & 0                                      \\\hline
			1 & 0 & 0 & 1     & 0                & 0            & 1            & 1            & 0                                      \\\hline
			1 & 0 & 1 & 1     & 0                & 0            & 1            & 0            & 0                                      \\\hline
			1 & 1 & 0 & 1     & 0                & 0            & 0            & 1            & 0                                      \\\hline
			1 & 1 & 1 & 1     & 0                & 0            & 0            & 0            & 0                                      \\\hline
		\end{array}$$

## Ex2: Show that the following expression is equivalent to the exclusive or function

This is denoted by $\oplus$

$$\begin{array}{|c|c|c|c|c|c|c|c|}
		\hline
		A & B & A * \overline{B} & \overline{A} * B & \overline{(A * \overline{B})} & \overline{(\overline{A} * B)} & \overline{(A * \overline{B})} * \overline{(\overline{A} * B)} & \overline{\overline{(A * \overline{B})} * \overline{(\overline{A} * B)}}\\\hline
		0 & 0 & 0 & 0 & 1 & 1 & 1 & 0\\\hline
		0 & 1 & 0 & 1 & 1 & 0 & 0 & 1\\\hline
		1 & 0 & 1 & 0 & 0 & 1 & 0 & 1\\\hline
		1 & 1 & 0 & 0 & 1 & 1 & 1 & 0\\\hline
	\end{array}$$

## Ex3: Reduce the following expressions:

### a

$$A * \overline{B} * \overline{C} + A * B * \overline{C} + \overline{A} * \overline{C}$$


$$\overline{C}(A * \overline{B} + A * B + \overline{A})$$

### b

$$M * \overline{N} * P + \overline{L} * M * P + \overline{L} * M * \overline{N} + \overline{L} * M * N * \overline{P} + \overline{L} * \overline{N} * \overline{P}$$

$$M(\overline{N}*P+\overline{L}*P+\overline{L}*\overline{N}+\overline{L}*N*\overline{P})+\overline{L}*\overline{N}*\overline{P}$$

$$M(\overline{N}*P+\overline{L}(P+\overline{N}+N*\overline{P}))+\overline{L}*\overline{N}*\overline{P}$$

