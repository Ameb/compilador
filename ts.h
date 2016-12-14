#ifndef JJIB_TS_H
#define JJIB_TS_H
#define LONG_MAX_NOMBRE 16
typedef enum etipo {entero, booleano, caracter, real, cadena} etipo;
// estructura basica de nuestra lista enlazada
struct nodo{
    char * nombre;
    enum etipo tipo;
    struct nodo * sig;
}nodo;
struct ts{
    struct nodo * init;
    struct nodo * fin;
};

void ts_append(struct ts* tabla_simbolos, struct nodo* n);
void ts_print(struct ts* tabla_simbolos);

#endif
