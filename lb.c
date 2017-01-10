#include <stdlib.h>
#include <stdio.h>
#include "lb.h"
// inicializar una lista con una posicion
struct lb * makelist(int i) {
	struct lb * l = malloc(sizeof(struct lb));
	l->item = i;
	l->next = NULL;
	return l;

}
// juntar dos listas de bools
struct lb * merge(struct lb * l1, struct lb * l2) {
	if (l1 == NULL && l2 == NULL) {
		return NULL;
	}
	if (l1 == NULL) {
		return l2;
	}
	if (l2 == NULL) {
		return l1;
	}
	struct lb * p = l1;
	struct lb * q;
	while (p != NULL) {
		q = p;
		p = p->next;
	}
	q->next = l2;
	return l1;
}
// añadir los saltos en cada una de las posiciones
void backpatch(struct tc * tabla_cuadruplas, struct lb * l, int i) {
	struct lb * p = l;
	//if (p != NULL)
	//	printf("Backpaching...i = %d, indice tabla %d\n",i, p->item);
	while (p != NULL) {
			tabla_cuadruplas->cuadruplas[p->item][3] = i;
		p = p->next;
	}
	//printf("fin backpatching\n");
}
void printlb(struct lb * l) {
	printf("lb: ");
	struct lb * p = l;
	while (p != NULL) {
		printf("%d\t", p->item);
		p = p->next;
	}
	printf("\n");
}