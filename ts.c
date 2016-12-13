#include<stdio.h>
#include<stdlib.h>
 
typedef struct {
	char nombre[LONG_MAX_NOMBRE];
	enum etipo tipo;
	struct nodo * sig;
} nodo;
typedef struct {
	struct nodo * init;
	struct nodo * fin;
} ts;

void ts_append(struct ts* tabla_simbolos, struct nodo* n) {
    
	if (ts->init == NULL) {
		ts->init = n;
		ts->fin = n;
	}
	else {
		ts->fin->sig = n;
		ts->fin = n;
	}
}
