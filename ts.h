#ifndef JJIB_TS_H
#define JJIB_TS_H
// estructura basica de nuestra lista enlazada
struct nodo{
	int sid;
    char * nombre;
    int tipo;
    struct nodo * sig;
}nodo;
struct ts{
    struct nodo * init;
    struct nodo * fin;
    int ultimo_sid;
};
void ts_init(struct ts* tabla_simbolos);
int ts_append(struct ts* tabla_simbolos, struct nodo* n);
void ts_print(struct ts* tabla_simbolos);
int ts_tipo(struct ts* tabla_simbolos, int sid);
struct nodo* ts_buscar_nombre(struct ts* tabla_simbolos, char * nombre);
struct nodo* ts_buscar_sid(struct ts* tabla_simbolos, int sid);
int newtemp(struct ts* tabla_simbolos, int tipo);
char * varname(struct ts* tabla_simbolos, int sid);
#endif
