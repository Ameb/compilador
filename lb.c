#include <stdlib.h>
#include <stdio.h>
#include "lb.h"
// inicializar una lista con una posicion
struct lb * makelist(int i) {
	struct lb * l = malloc(sizeof * l);
	l->item = i;
	l->next = NULL;
	return l;

}
// juntar dos listas de bools
struct lb * merge(struct lb * l1, struct lb * l2) {
	printf("Juntando listas...\n");
	printlb(l1);
	printlb(l2);
	//struct lb * l = malloc(sizeof * l);
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
	while (p != NULL) {
		p = p->next;
	}
	p->next = l2;
	return l1;
}
// añadir los saltos en cada una de las posiciones
void backpatch(struct tc * tabla_cuadruplas, struct lb * l, int i) {
	//printf("Backpaching...i = %d\n",i);
	struct lb * p = l;
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