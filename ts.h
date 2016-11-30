#ifndef JJIB_TS_H
#define JJIB_TS_H
#define LONG_MAX_NOMBRE 16
typedef enum etipo {entero, booleano, caracter, real, cadena} etipo;
// estructura basica de nuestra lista enlazada
typedef struct {
	char nombre[LONG_MAX_NOMBRE];
	enum etipo tipo;
	struct nodo * sig;
} nodo;
typedef struct {
	struct nodo * init;
	struct nodo * fin;
} ts;
#endif
