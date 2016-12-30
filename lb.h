#ifndef JJIB_LB_H
#define JJIB_LB_H
#include "tc.h" // no estoy seguro de si es correcto poner el include aqui
struct lb{
	int item;
	struct lb * next;
};
struct lb * makelist(int i);
struct lb * merge(struct lb * l1, struct lb * l2);
void backpatch(struct tc * tabla_cuadruplas, struct lb * l, int i);
void printlb(struct lb * l);
#endif
