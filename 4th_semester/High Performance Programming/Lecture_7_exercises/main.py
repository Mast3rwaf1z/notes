from os import system
from random import randint


def gen_csv(elements:int):
    system("rm numbers.csv")
    numbers = [randint(0, 100) for _ in range(elements)]
    with open("numbers.csv", "w") as file:
        file.write(str(numbers[0]))
        for i in range(1, len(numbers)):
            file.write("," + str(numbers[i]))
if __name__ == "__main__":
    import parallel_random_set
    import sequential_random_set
    import jit_random_set
    from sys import argv
    if len(argv) == 3:
        elements = int(argv[1]) #n elements
        sets = int(argv[2]) #k sets
    else:
        elements = 10000
        sets = 100

    gen_csv(elements)

    # read and save the generated csv in memory
    with open("numbers.csv", "r") as file:
        _in = file.read()
        l = [int(element) for element in _in.split(sep=",")]
    jit_random_set.function(elements, sets)
    parallel_random_set.function(elements, sets)
    sequential_random_set.function(elements, sets)