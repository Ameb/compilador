SOURCE=lenguaje.lex
all: a.out
lex.yy.c: $(SOURCE)
	    flex $(SOURCE)

a.out: lex.yy.c
	    gcc lex.yy.c -lfl
run: a.out
	./a.out
clean:
	rm a.out lex.yy.c
#bison
# bison -v -d nombre.y
# genera nombre.tab.h que habra que hacer include
# mirar nombre.output
# 
# gcc -c lex.yy.c
# nombre.tab.c lex.yy.o -lfl -lm