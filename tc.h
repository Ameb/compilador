#ifndef JJIB_TC_H
#define JJIB_TC_H
#define DOP_SUMA_ENT 11
#define DOP_RESTA_ENT 12
#define DOP_MULTIPLICACION_ENT 13
#define DOP_DIVISION_ENT 14
#define DOP_MENOSU_ENT 15
#define DOP_MODENT 16
#define DOP_DIVENT 17
#define DOP_SUMA_REAL 21
#define DOP_RESTA_REAL 22
#define DOP_MULTIPLICACION_REAL 23
#define DOP_DIVISION_REAL 24
#define DOP_MENOSU_REAL 25
#define DOP_ASIGNACION 30
#define DOP_SALTO 100
#define DOP_SALTO_SI_MENOR 201
#define DOP_SALTO_SI_MEOI 202
#define DOP_SALTO_SI_IGUAL 203
#define DOP_SALTO_SI_MAOI 204
#define DOP_SALTO_SI_MAYOR 205
#define DOP_SALTO_SI_DISTINTO 206
struct tc{
    int nextquad;
    int cuadruplas[100][4];
};
void gen(struct tc* tabla_cuadruplas, int op, int op1, int op2, int res);
void tc_print(struct tc* tabla_cuadruplas);
#endif
