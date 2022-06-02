import sys
from math import cos, pi, sqrt
import numpy as np
from PIL import Image, ImageOps
from time import perf_counter
import torch

from DCT_Tests_Parallel import ProcessorDCT2_parallel, ProcessorDCT_parallel


def GPUCheck():
    if torch.cuda.is_available():
        device = torch.device("cuda")
    else:
        device = torch.device("cpu")
    print(f'The device used is: {device}')
    
    torch.cuda.synchronize()


def Multiplication(m1, m2):
    if not isinstance(m1, np.ndarray):
        m1 = np.array(m1)
    if not isinstance(m2,np.ndarray):
        m2 = np.array(m2)

    m1 = torch.from_numpy(m1)
    m1 = m1.double()
    m2 = torch.from_numpy(m2)
    m2 = m2.double()
    newmatrix = torch.matmul(m1, m2) # torch.Size([m, j])
    newmatrix = newmatrix.numpy()
    return newmatrix

def HadamardProduct(m1,m2):

    if not isinstance(m1,np.ndarray):
        m1 = np.array(m1)
    if not isinstance(m2,np.ndarray):
        m2 = np.array(m2)
    
    m1 = torch.from_numpy(m1)
    m2 = torch.from_numpy(m2)
    hadamard = m1 * m2
    hadamard = hadamard.numpy()
    return hadamard

# Function to convert image to greyscale
def ConvertGreyscale(Path:str):
    Img = Image.open(Path)
    Grey = ImageOps.grayscale(Img)
    Grey.show("Original Greyscale Image")
    GreyArr = np.array(Grey)
    return GreyArr

# Function to create the DCT matrix.
# Refer to workshop document for explanation about how the matrix is made.
def CreateDCTMatrix(Size):
    L1 = Size
    Res = []
    for i in range(L1):
        Res.append([])
        for j in range(L1):
            Res[i].append(sqrt(2/Size)*cos((pi*(2*j + 1)*i)/(2*L1)))
    Res = np.array(Res)
    Res[0] = Res[0]*sqrt(1/2)
    return Res

def CreateQuantizationMatrix(Size, Quality):
    Res = []
    ScaleFactor = 1/(Size**(Quality/25))
    for i in range(Size):
        Res.append([])
        for j in range(Size):
            Res[i].append(1/(ScaleFactor*(i+j)**2+1))
    return Res

# Function to partition image into square matrices of dimensions (Size x Size)
# With size of 8 the return value is a matrix of matrices,
# Where for example the matrix at (0,0) has the values from (0:7, 0:7)
# The matrix at (0,1) has the values from (0:7, 8:15) and matrix at (1,1) has values from (8:15,8:15) etc.
def PartitionImage(ImageMatrix:np.ndarray, Size):
    # Check that the row dimension of the matrix is divisible by Size
    if ImageMatrix.shape[0]%Size != 0:
        print(f'The row dimension is not divisible by {Size}')
        return ImageMatrix
    else:
        Res = []
        for i in range(ImageMatrix.shape[0]//Size):
            Res.append([])
            # Check that the column dimension of the matrix is divisible by Size
            if ImageMatrix.shape[1]%Size != 0:
                print(f'The column dimension in row {i} is not divisible by {Size}')
                return ImageMatrix
            else:
                # Create the sub-matrices by literally taking a sub-matrix out of the image
                for j in range(ImageMatrix.shape[1]//Size):
                    Partition = ImageMatrix[i*Size:(i+1)*Size, j*Size:(j+1)*Size]
                    Res[i].append(Partition)
        return Res

# This undos what the above function does, by going through the matrices in the matrix and expanding their elements out
def UnpartitionImage(PartitionedMatrix, Size):
    Res = []
    for m in range(len(PartitionedMatrix)):
        # Create the rows beforehand, so that we just append the values to them to expand the sub-matrices
        for _ in range(Size): Res.append([])
        for n in range(len(PartitionedMatrix[m])):
            # Check that the row dimension of the sub-matrix is divisible by Size
            if PartitionedMatrix[m][n].shape[0] != Size:
                print(f'Row dimension if sub-matrix in ({m},{n}) does not match {Size}')
                return PartitionedMatrix
            else:
                for i in range(Size):
                    # Check that the column dimension of the sub-matrix is divisible by Size
                    if PartitionedMatrix[m][n].shape[1] != Size:
                        print(f'Column dimension if sub-matrix in ({m},{n}) does not match {Size}')
                        return PartitionedMatrix
                    else:
                        for j in range(Size):
                            Res[(m*Size+i)].append(PartitionedMatrix[m][n][i][j])
    return Res

# This is the function that does the transformation. It also does compression by quantization.
def ProcessorDCT2(DCT, Image, Size, QuantizationMatrix):
    Image = np.array(Image)
    # Partition the image to sub-matrices of dimension (Size, Size)
    Partitioned = PartitionImage(Image, Size)
    PartitionedTransformed = []                 # Matrix to include the transformed sub-matrices
    for i in range(len(Partitioned)):
        PartitionedTransformed.append([])
        # Go through all sub-matrices and DCT transform them then quantize them.
        for j in range(len(Partitioned[i])):
            #Arr = (DCT@Partitioned[i][j]@DCT)*QuantizationMatrix
            Arr = Multiplication(DCT, Partitioned[i][j]) # multiplies the DCT matrixes with the 8 x 8 blocks
            #print(Arr)
            Arr = Multiplication(Arr, DCT.transpose())   # multiplies the tranformed image matrix with the transposed DCT matrix
            Arr = HadamardProduct(Arr,QuantizationMatrix)
            #Arr = (DCT@Partitioned[i][j])*QuantizationMatrix
            #Arr = (Partitioned[i][j]@DCT) * QuantizationMatrix
            #print(Arr)
            #Arr = np.array(Arr)
            Arr = np.round(Arr, 0)
            PartitionedTransformed[i].append(Arr)
    # Expand the transformed sub-matrices
    UnpartitionedTransformed = UnpartitionImage(PartitionedTransformed, Size)
    return UnpartitionedTransformed

# Does exactly the same as above, but it does not quantize.
def ProcessorDCT(DCT, Image, Size):
    Image = np.array(Image)
    Partitioned = PartitionImage(Image, Size)
    PartitionedTransformed = []
    for i in range(len(Partitioned)):
        PartitionedTransformed.append([])
        for j in range(len(Partitioned[i])):
            PartitionedTransformed[i].append(DCT@Partitioned[i][j]@DCT)
    UnpartitionedTransformed = UnpartitionImage(PartitionedTransformed, Size)
    return UnpartitionedTransformed

# Does exactly as ProcessorDCT2 if you passed the IDCT to it instead. You can use ProcessorDCT2 for both DCT and IDCT
def ProcessorIDCT(IDCT, Image, Size):
    Image = np.array(Image)
    Partitioned = PartitionImage(Image, Size)
    PartitionedTransformed = []
    for i in range(len(Partitioned)):
        PartitionedTransformed.append([])
        for j in range(len(Partitioned[i])):
            #Arr = IDCT@Partitioned[i][j]@IDCT
            #Arr = IDCT@Partitioned[i][j]@IDCT.transpose()
            Arr = Multiplication(IDCT, Partitioned[i][j])
            Arr = Multiplication(Arr, IDCT.transpose())
            #Arr = IDCT@Partitioned[i][j]
            #Arr = Partitioned[i][j]@IDCT
            Arr = np.round(Arr, 0)
            PartitionedTransformed[i].append(Arr)
    UnpartitionedTransformed = UnpartitionImage(PartitionedTransformed, Size)
    return UnpartitionedTransformed

# Test to see if quantization worked
def Test3(Path, BlockSize, Quality):
    Img = ConvertGreyscale(Path)
    # Get original resolution so that we can remove any appended pixels at the end
    OriginalRes = Img.shape
    Correct = False                         # True if appended pixels need to be removed
    PartitionSize = BlockSize
    # Check if the row and column dimensions of the image are divisible by the partition size.
    # If not, append black pixels so that they are.
    if Img.shape[0]%PartitionSize != 0 or Img.shape[1]%PartitionSize != 0:
        Correct = True
        NewRow = (Img.shape[0]//PartitionSize+1)*PartitionSize
        NewCol = (Img.shape[1]//PartitionSize+1)*PartitionSize
        ZeroArr = np.zeros((NewRow,NewCol))
        ZeroArr[:Img.shape[0], :Img.shape[1]] = Img
        Img = ZeroArr
    # Create DCT and Quantization matrix
    DCT = CreateDCTMatrix(PartitionSize)
    QuantizationMatrix = CreateQuantizationMatrix(BlockSize, Quality)
    # Transform and compress the image then inverse transform it
    Time1 = perf_counter()
    Transformed = ProcessorDCT2(DCT, Img, PartitionSize, QuantizationMatrix)
    Time2 = perf_counter()
    Inversed = ProcessorIDCT(DCT.transpose(), Transformed, PartitionSize)
    Time3 = perf_counter()
    print(f'Time taken to transform {Time2-Time1}\nTime taken to invert {Time3-Time2}\nTime for both {Time3-Time1}')
    # Convert the results into numpy arrays and then into pillow images
    Res = Image.fromarray(np.array(Transformed))
    Res2 = Image.fromarray(np.array(Inversed))
    # Show the DCT transformaed image, and then remove appended pixels if needed and show inversed image
    Res.show("DCT Transformed Image")
    if Correct:
        CorrectedInversed = np.array(Inversed)[:OriginalRes[0], :OriginalRes[1]]
        Res3 = Image.fromarray(CorrectedInversed)
        Res3.show("Corrected Compressed Image")
    else:
        Res2.show("Compressed Image")


if __name__ == "__main__":
    t1_start = perf_counter()
    GPUCheck()
    Test3("cat.jpg", 64, 25)
