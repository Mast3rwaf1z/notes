#   High Performance Programming Lecture 3
Parallel Algorithmic Paradigms and Design Process
*   inherintly sequential
        what we normally code basicly

        some algorithms will inherintly be sequential where its either impossible or ineffective to run in parallel

*   parallel

    a parallel algorithm is multiple processes running simultaneously to solve a problem

    in this case some algorithms will be able to be run in parallel without communication or minimal communication, and not be limited by each other

*   somewhat parallel

    in contrast to sequential and parallel algorithms, a somewhat parallel algorithm uses processes which are dependant on each other, or will need to do some processing sequentially

so when we want to calculate the speedup for a problem set up in a tree as shown in figure graph.png we would count all the nodes and divide it by the amount of time steps it would take to complete the graph with the given amount of processes.

the time step is defined by the time taken to process a task for each process based on the graph. it cannot process nodes from different levels in one time step

so for this particular graph it would be 15/4