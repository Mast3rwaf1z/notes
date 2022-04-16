import torch

def fill_torch(height:int,width:int,_range:int) -> tuple[torch.Tensor, torch.Tensor]:
    matrix = torch.randint(_range, size=(height,width)).int()
    return matrix



if __name__ == "__main__":
    runs = 1
    #set device to cuda
    device = torch.device("cuda")
    for run in range(runs):
        matrix1 = fill_torch(10, 10, 10)
        matrix2 = fill_torch(10, 10, 10)
        res =torch.matmul(matrix1, matrix2)
        torch
        if run == 0:
            print(matrix1)
            print(matrix2)
            print(res)