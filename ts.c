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
