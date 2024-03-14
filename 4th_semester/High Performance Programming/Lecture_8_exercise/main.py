from mpi4py import MPI
from broadcast import broadcast_func
from scatter import scatter_func
from send_receive import send_recv_func
comm = MPI.COMM_WORLD

bcast = broadcast_func(10)
scatter = scatter_func(10)
send_recv = send_recv_func(10)

if comm.rank == 0:
    print(bcast[0])
    print(scatter[0])
    print(send_recv[0])
    print(f'time broadcast: {bcast[1]}')
    print(f'time scatter: {scatter[1]}')
    print(f'time send/recv: {send_recv[1]}')