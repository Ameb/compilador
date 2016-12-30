#detectar OS X
OS:= $(shell uname)
ifeq ($(OS),Darwin)
	LFL = -ll
else
	LFL = -lfl
endif
LENGUAJE=lenguaje.lex
CC = gcc
AUXSRC =ts.c tc.c lb.c
AUXOBJS = $(AUXSRC:.c=.o)
all: a.out
lex.yy.c: $(LENGUAJE) parser.tab.h parser.tab.c
	    flex $(LENGUAJE)
# bison
parser.tab.h parser.tab.c: parser.y
	bison -v -d parser.y
#$(AUXOBJS): $(AUXSRC)
#	$(CC) -c -o $@ $<
.c.o:
	$(CC) -c -o $@ $<
a.out: parser.tab.c lex.yy.o $(AUXOBJS)
	$(CC) -Wall parser.tab.c lex.yy.o $(AUXOBJS) $(LFL) -lm
run: a.out
	./a.out
clean:
	rm a.out lex.yy.c parser.tab.* parser.output $(AUXOBJS)
# genera nombre.tab.h que habra que hacer include
# mirar nombre.output
# 
# gcc -c lex.yy.c
# nombre.tab.c lex.yy.o -lfl -lm