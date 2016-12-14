#include<stdio.h>
#include<stdlib.h>
#include "ts.h"

void ts_append(struct ts* tabla_simbolos, struct nodo* n) {
    
    if (tabla_simbolos->init == NULL) {
        tabla_simbolos->init = n;
        tabla_simbolos->fin = n;
    }
    else {
        tabla_simbolos->fin->sig = n;
        tabla_simbolos->fin = n;
    }
}
void ts_print(struct ts* tabla_simbolos) {
    printf("-------------------\nImprimiendo variables de la tabla de simbolos\n");
    struct nodo* test;
    test = tabla_simbolos->init;
    while (test != NULL) {
        printf("Variable %s de tipo %d\n",test->nombre, test->tipo);
        test = test->sig;
    }
}