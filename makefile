SOURCE=lenguaje.lex
all: a.out
lex.yy.c: $(SOURCE) parser.tab.h parser.tab.c
	    flex $(SOURCE)
# bison
parser.tab.c parser.tab.h: parser.y
	bison -v -d parser.y
a.out: lex.yy.c
	    gcc lex.yy.c -lfl
run: a.out
	./a.out
clean:
	rm a.out lex.yy.c parser.tab.* parser.output
# genera nombre.tab.h que habra que hacer include
# mirar nombre.output
# 
# gcc -c lex.yy.c
# nombre.tab.c lex.yy.o -lfl -lm