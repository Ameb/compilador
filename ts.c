#include<stdio.h>
#include<stdlib.h>
#include <string.h>
#include "ts.h"
void ts_init(struct ts* tabla_simbolos) {
    tabla_simbolos->init = NULL;
    tabla_simbolos->fin = NULL;
    tabla_simbolos->ultimo_sid = 0;
}
int ts_append(struct ts* tabla_simbolos, struct nodo* n) {
    tabla_simbolos->ultimo_sid = tabla_simbolos->ultimo_sid+1;
    n->sid = tabla_simbolos->ultimo_sid;
    if (tabla_simbolos->init == NULL) {
        tabla_simbolos->init = n;
        tabla_simbolos->fin = n;
    }
    else {
        tabla_simbolos->fin->sig = n;
        tabla_simbolos->fin = n;
    }
    return n->sid;
}
void ts_print(struct ts* tabla_simbolos) {
    printf("Tabla simbolos:\nsid\tnombre\ttipo\n");
    struct nodo* test;
    test = tabla_simbolos->init;
    while (test != NULL) {
        printf("%3d\t%s\t%d\n",test->sid, test->nombre, test->tipo);
        test = test->sig;
    }
}

int ts_tipo(struct ts* tabla_simbolos, int sid) {
    struct nodo * aux;
    aux = ts_buscar_sid(tabla_simbolos, sid);
    if (aux != NULL) {
        return aux->tipo;
    }
    else {
        return 0;    
    }
}

// busqueda en la ts
struct nodo* ts_buscar_nombre(struct ts* tabla_simbolos, char * nombre) {
    struct nodo * aux;
    if (tabla_simbolos == NULL) return NULL;
    aux = tabla_simbolos->init;
    while (aux != NULL && (strcmp(aux->nombre, nombre) != 0)) {
        aux = aux->sig;
    }
    return aux;
}
struct nodo* ts_buscar_sid(struct ts* tabla_simbolos, int sid) {
    struct nodo * aux;
    if (tabla_simbolos == NULL) return NULL;
    aux = tabla_simbolos->init;
    while (aux != NULL && aux->sid != sid ) {
        aux = aux->sig;
    }
    return aux;
    printf("Encontrado %s en la ts\n", aux->nombre);
}
// 
int newtemp(struct ts* tabla_simbolos, int tipo) {
    struct nodo * temp;
    temp = (struct nodo *) malloc(sizeof(struct nodo));
    temp->tipo = tipo;
    //temp->nombre = (char *)malloc(strlen("temporal"));
    //temp->nombre = "temporal";
    //temp->sig = NULL;
    return ts_append(tabla_simbolos, temp);
}
