# Computer architectures
https://en.wikipedia.org/wiki/Von_Neumann_architecture
*   ARM
*   x64
*   RISC
*   CISC
*   Von Neumann
    *   In general it has the following components:

        A processing unit, consisting of an ALU and processor registers
        *   ALU(Arithmetic Logic Unit) is an unit that executes instructions
        
        *   Registers as known from courses, it is some data that is needed as fast as possible, its like RAM but smaller and faster and closer to the CPU

        A control unit with instruction registers and a program counter
        *   instruction registers

        Memory for data and instructions

        Some form of mass storage

        IO
        *   A very relevant topic when talking about the von neumann architecture is the von neumann bottleneck, that is the fact that when the CPU needs an instruction it must first address the memory for the instruction, then address the memory again for the data that needs to be used with the instruction. this means that this is impossible to do in parallel as the memory is accessed on two bus'es, the address bus and the data bus. when the 
*   Harvard
    *   harvard architecture is structured such that there are two memory units, one for data and one for instructions.
    *   this is exaggerated when talking about processors with multiple cores because the primary cache for each core is also split into data and instruction memory like the RAM. this is called the modified harvard architecture.