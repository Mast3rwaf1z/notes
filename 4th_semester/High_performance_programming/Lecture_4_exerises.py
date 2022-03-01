from matplotlib.pyplot import scatter,show
#   n   p=1     p=4     p=8     p=16    p=32
#   16  1       1/2     1/4     1/9     1/21
#   32  1       2/3     2/5     2/10    2/22
#   64  1       4/5     4/7     4/12    4/24
#   128 1       8/9     8/11    8/16    8/28
#   256 1       16/17   16/19   16/25   16/37
#   512 1       32/33   32/35   32/40   32/52

## exercise 1
def ex1():
    scatter([
        1,      1,      1,      1,      1,      1,
        1/2,    2/3,    4/5,    8/9,    16/17,  32/33,
        1/4,    2/5,    4/7,    8/11,   16/19,  32/35,
        1/9,    2/10,   4/12,   8/16,   16/25,  32/40,
        1/21,   2/22,   4/24,   8/28,   16/37,  32/52], 
        
        ["n16 p1",  "n16 p4",   "n16 p8",   "n16 p16",  "n16 p32",
        "n32 p1",   "n32 p4",   "n32 p8",   "n32 p16",  "n32 p32",
        "n64 p1",   "n64 p4",   "n64 p8",   "n64 p16",  "n64 p32",
        "n128 p1",  "n128 p4",  "n128 p8",  "n128 p16", "n128 p32",
        "n256 p1",  "n256 p4",  "n256 p8",  "n256 p16", "n256 p32",
        "n512 p1",  "n512 p4",  "n512 p8",  "n512 p16", "n512 p32"])
    show()


## exerise 2
from multiprocessing import Pool
import os

def double(i):
    print(f"i = {i}, PID = {os.getpid()}\n")
    return i * 2

def ex2():
    A = [0, 1, 2, 3, 4, 5,6,7,8,9]
    with Pool(5) as pool:
        result = pool.map(double, A)
        print(result)

if __name__ == "__main__":
    ex1()