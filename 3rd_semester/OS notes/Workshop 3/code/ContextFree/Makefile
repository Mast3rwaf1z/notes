OLibs=  -lm -lfl
CC= gcc 

ContextFree: lex.yy.o 
	$(CC) -o $@ lex.yy.o $(OLibs) 


lex.yy.c: ContextFree.l
	flex ContextFree.l

clean:
	@echo "Cleaning"
	rm *.o *.c 
