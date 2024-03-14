import seaborn as sns
from math import cos, pi, sqrt
import numpy as np
from PIL import Image, ImageOps
from time import perf_counter
import matplotlib.pyplot as plt
import pandas
from DCT_Tests_Parallel import ProcessorDCT2_parallel, ProcessorDCT_parallel

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
            Res[i].append(ScaleFactor*(i+j)**2+1)
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
            Arr = (DCT@Partitioned[i][j]@DCT.transpose())/QuantizationMatrix
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
            Arr = IDCT@Partitioned[i][j]@IDCT.transpose()
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

def Test3_parallel(Path, BlockSize, Quality):
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
    Transformed = ProcessorDCT2_parallel(DCT, Img, PartitionSize, QuantizationMatrix)
    Time2 = perf_counter()
    Inversed = ProcessorDCT_parallel(DCT.transpose(), Transformed, PartitionSize)
    Time3 = perf_counter()
    #print(f'Time taken to transform {Time2-Time1}\nTime taken to invert {Time3-Time2}\nTime for both {Time3-Time1}')
    # Convert the results into numpy arrays and then into pillow images
    Res = Image.fromarray(np.array(Transformed))
    Res2 = Image.fromarray(np.array(Inversed))
    # Show the DCT transformaed image, and then remove appended pixels if needed and show inversed image
    #Res.show("DCT Transformed Image")
    if Correct:
        CorrectedInversed = np.array(Inversed)[:OriginalRes[0], :OriginalRes[1]]
        Res3 = Image.fromarray(CorrectedInversed)
        #Res3.show("Corrected Compressed Image")
    #else:
        #Res2.show("Compressed Image")

# Create the bar plots
def CreatePlot(Data, Cols, Title, xMax):
    DF = pandas.DataFrame.from_dict(Data, orient="index", columns=Cols)
    DF.reset_index(inplace=True)
    DF = pandas.melt(DF, id_vars="index", var_name="Block Size", value_name="Time (s)")
    DF.rename(columns={"index": "Method"}, inplace=True)
    print(DF)
    ax = sns.barplot(x="Time (s)", y="Method", data=DF, hue="Block Size", palette="Set1")
    ax.set_title(Title)
    ax.set_xlim(left=0, right=xMax)
    plt.savefig(f"{Title}.png")
    plt.show()


if __name__ == "__main__":
    np.set_printoptions(suppress=True)
    Test3("cat.jpg", 128, 25)
    CreatePlot({"JIT": [120, 120, 120, 120],
                "Numpy": [1.32, 0.978, 1.42, 4.73],
                "MP": [7.3, 3.42, 2.49, 5.34],
                "CUDA": [1.79, 1.04, 1.15, 4.37]},
               ["8x8", "32x32", "128x128", "1280x1280"], "1280x800 Image", 10)
    CreatePlot({"JIT": [120, 120, 120, 120],
                "Numpy": [12.7, 9.43, 10.2, 64.9],
                "MP": [40.85, 16.8, 14, 70.7],
                "CUDA": [17.6, 10.4, 8.94, 64.3]},
               ["8x8", "32x32", "128x128", "4608x4608"], "4608x2176 Image", 100)
    #print("i'm done bo"+"y"*5000)
