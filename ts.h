#ifndef JJIB_TS_H
#define JJIB_TS_H
#define LONG_MAX_NOMBRE 16
typedef enum etipo {entero, booleano, caracter, real, cadena} etipo;
// estructura basica de nuestra lista enlazada
struct nodo{
	int id_aux;
    char * nombre;
    int tipo;
    struct nodo * sig;
}nodo;
struct ts{
    struct nodo * init;
    struct nodo * fin;
    int ultimo_id_aux;
};

void ts_append(struct ts* tabla_simbolos, struct nodo* n);
void ts_print(struct ts* tabla_simbolos);
struct nodo*  ts_buscar(struct ts* tabla_simbolos, char * nombre);

#endif
