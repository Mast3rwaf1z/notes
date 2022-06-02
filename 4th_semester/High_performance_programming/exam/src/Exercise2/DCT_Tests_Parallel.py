import numpy as np
from multiprocessing import Pool
from math import sqrt, pi, cos

PROCESSORS = 4

def PartitionImage(ImageMatrix:np.ndarray, Size):
    if ImageMatrix.shape[0]%Size != 0:
        print(f'The row dimension is not divisible by {Size}')
        return ImageMatrix
    else:
        Res = []
        for i in range(ImageMatrix.shape[0]//Size):
            Res.append([])
            if ImageMatrix.shape[1]%Size != 0:
                print(f'The column dimension in row {i} is not divisible by {Size}')
                return ImageMatrix
            else:
                for j in range(ImageMatrix.shape[1]//Size):
                    Partition = ImageMatrix[i*Size:(i+1)*Size, j*Size:(j+1)*Size]
                    Res[i].append(Partition)
        return Res

def UnpartitionImage(PartitionedMatrix, Size):
    Res = []
    for m in range(len(PartitionedMatrix)):
        for _ in range(Size): Res.append([])
        for n in range(len(PartitionedMatrix[m])):
            if PartitionedMatrix[m][n].shape[0] != Size:
                print(f'Row dimension if sub-matrix in ({m},{n}) does not match {Size}')
                return PartitionedMatrix
            else:
                for i in range(Size):
                    if PartitionedMatrix[m][n].shape[1] != Size:
                        print(f'Column dimension if sub-matrix in ({m},{n}) does not match {Size}')
                        return PartitionedMatrix
                    else:
                        for j in range(Size):
                            Res[(m*Size+i)].append(PartitionedMatrix[m][n][i][j])
    return Res

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
    Res = np.empty((Size,Size))
    for i in range(Size):
        Res[i] = np.arange(0+i, Size+i, 1)
    ScaleFactor = 1/(Size**(Quality/25))
    Res = ScaleFactor*Res*Res+np.ones((Size, Size))
    return Res


### PARALLEL IMPLEMENTATION ###
def ProcessorDCT_process(args):
    DCT, element = args
    return DCT@element@DCT.transpose()

def ProcessorDCT_parallel(DCT, Image, Size):
    Image = np.array(Image)
    Partitioned = PartitionImage(Image, Size)
    PartitionedTransformed = list()
    for row in Partitioned:
        with Pool(PROCESSORS) as p:
            PartitionedTransformed.append(p.map(ProcessorDCT_process, [(DCT, e) for e in row]))
    return UnpartitionImage(PartitionedTransformed, Size)

def ProcessorDCT2_proccess(args):
    DCT, element, QuantizationMatrix = args
    return np.round((DCT@element@DCT.transpose())/QuantizationMatrix, 0)

def ProcessorDCT2_parallel(DCT, Image, Size, QuantizationMatrix):
    Image = np.array(Image)
    Partitioned = PartitionImage(Image, Size)
    PartitionedTransformed = list()
    for row in Partitioned:
        with Pool(PROCESSORS) as p:
            PartitionedTransformed.append(p.map(ProcessorDCT2_proccess, [(DCT, e, QuantizationMatrix) for e in row]))
    return UnpartitionImage(PartitionedTransformed, Size)
