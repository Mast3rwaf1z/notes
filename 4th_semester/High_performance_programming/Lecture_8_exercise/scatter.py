from mpi4py import MPI
from math import floor
from timer import timer

@timer
def scatter_func(array_size = int(1e4)):
    comm = MPI.COMM_WORLD
    nodes = comm.Get_size()
    array = list(range(array_size))
    match comm.rank:
        case 0:
            data = [[array.pop(0) for j in range(floor(array_size/nodes))] for i in range(nodes)]

            pass
        case _:
            data = None
    data = comm.scatter(data, root=0)
    comm.barrier()
    return data