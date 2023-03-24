CC= gcc
CFLAGS = -c -Wall
OFLAGS = -lm

all: TempStub main

TempStub : TempStub.o
	$(CC) TempStub.o $(OFLAGS) -o $@
	
TempStub.o : TempStub.c
	@echo "compile $<"
	$(CC) $(CFLAGS) $<
	
main : main.o
	$(CC) main.o -pthread -o $@

main.o : main.c
	@echo "Compile $<"
	$(CC) $(CFLAGS) $<


clean:
	@echo "sletter nu"
	rm -fr *.o 
