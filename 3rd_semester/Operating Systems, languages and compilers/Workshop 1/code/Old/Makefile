CC= gcc
CFLAGS = -c -Wall
OFLAGS = -lm

all: TempStub

TempStub : TempStub.o
	$(CC) TempStub.o $(OFLAGS) -o $@
	
TempStub.o : TempStub.c
	@echo "compile $<"
	$(CC) $(CFLAGS) $<
	
ReaderStub : ReaderStub.o
	$(CC) ReaderStub.o -o $@

ReaderStub.o : ReaderStub.c
	@echo "Compile $<"
	$(CC) $(CFLAGS) $<


clean:
	@echo "sletter nu"
	rm -fr *.o 
