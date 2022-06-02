# Workshop fixes
## msp exercise
### Work
there has been a few small mistakes for the calculation of the work complexity of the msp algorithm, in the 2nd listing, AlgorithmMSP_1D should take 2m+3, not 2n+3, while the 2nd for loop should take m time, so the calculation would be the following

W = 1 + N * (N + (N - i) * (M + (2m + 3) + 1)) + 1

W = 

### The algorithm
For the java implementation of the MSP algorithm it has been parallelised using the equivalent of concurrent futures. This means that an executorservice has been defined such that processes can be given to this executer and executed while the main process continues. The result from futures can be accessed at any time but if the get function is called it will wait until a result is generated.
## dct exercise
### Parallel
This implementation was implemented using a pool defined from the multiprocessing library.
### jit
First jit had to be investigated, apparently the numpy arrays being worked on was of different datatypes preventing jit from enabling nopython mode, going into object mode.

The fix was to go through every operation that should be run with jit and changing the datatypes of the numpy arrays, while making non-numpy arrays into numpy arrays. this fixed our issue with jit not going into nopython mode.

### cuda
Then cuda was also an issue because it was weirdly fast, the suspicion here was that there should be so much communication cost that it should be significant overhead.

The cuda implementation was tested and apparently the first time it was tested it was not utilizing the GPU, rather the program was running on a cpu. fixing it was a matter of two things; 

first every single tensor should have a device assigned to it

Second the tensors were defined in the multiply and hadamard functions which means that for every loop in the function, the program would create new tensors for the dct and the quantization matrices. these tensors could have been defined once at the beginning of the program, thus generating a significant performance improvement.

## Results with a Geforce GTX 1080 GPU + 6 core cpu

<image src="Figure_1.png">
<image src="Figure_2.png">

## Results with a Nvidia Quadro m3000m integrated GPU + 4 core cpu

<image src="Figure_3.png">
<image src="Figure_4.png">