#include <stdlib.h>
#include "lb.h"
// inicializar una lista con una posicion
struct lb * makelist(int i) {
	struct lb * l = malloc(sizeof *l);
	l->item = i;
	l->next = null;
	return l;

}
// juntar dos listas de bools
struct lb * merge(struct lb * l1, struct lb * l2) {
	struct lb * l = malloc(sizeof * l);
	struct lb * aux = l;
	struct lb * p = l1;
	while (p != null) {
		aux->next = p;
		p = p->next;
	}
	p = l2;
	while (p != null) {
		aux->next = p;
		p = p->next;
	}
	return l;
}
// añadir los saltos en cada una de las posiciones
void backpatch(struct tc * tabla_cuadruplas, struct lb * l, int i) {
	struct lb * p = l;
	while (p != null) {
		tabla_cuadruplas->cuadruplas[p.item][3] = i;
		p = p->next;
	}
}