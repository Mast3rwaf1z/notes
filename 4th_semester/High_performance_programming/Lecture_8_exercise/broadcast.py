from mpi4py import MPI
from math import floor
from timer import timer

@timer
def broadcast_func(array_size = int(1e4)):
    comm = MPI.COMM_WORLD
    nodes = comm.Get_size()
    array = list(range(array_size))
    match comm.rank:
        case 0:
            data = [array.pop(0) for i in range(floor(array_size/nodes))]
        case _:
            data = None

    data = comm.bcast(data, root=0)
    comm.barrier()
    return data