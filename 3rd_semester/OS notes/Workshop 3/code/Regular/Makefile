OLibs=  -lm -lfl
CC= gcc 

Regular: lex.yy.o 
	$(CC) -o $@ lex.yy.o $(OLibs) 


lex.yy.c: Regular.l
	flex Regular.l

clean:
	@echo "Cleaning"
	rm *.o *.c 
