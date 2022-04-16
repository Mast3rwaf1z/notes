from mpi4py import MPI
from math import floor
from timer import timer

@timer
def send_recv_func(array_size = int(1e4)):
    comm = MPI.COMM_WORLD
    nodes = comm.Get_size()
    array = list(range(array_size))
    match comm.rank:
        case 0:
            msg_size = floor(array_size/(nodes))
            remainder = len(array)-(msg_size*(nodes))
            for node in range(1,nodes):
                if len(array) >= msg_size*2:
                    msg = [array.pop(0) for _ in range(msg_size)]
                else:
                    msg = [array.pop(0) for _ in range(len(array))]
                comm.send(msg, node)
            data = array
        case _:
            data = comm.recv(source=0)

    comm.barrier()
    return data