#ifndef JJIB_TC_H
#define JJIB_TC_H
#define DOP_SUMA_ENT 11
#define DOP_RESTA_ENT 12
#define DOP_MULTIPLICACION_ENT 13
#define DOP_DIVISION_ENT 14
#define DOP_MENOSU_ENT 15
#define DOP_SUMA_REAL 21
#define DOP_RESTA_REAL 22
#define DOP_MULTIPLICACION_REAL 23
#define DOP_DIVISION_REAL 24
#define DOP_MENOSU_REAL 15

struct tc{
    int nextquad;
    int cuadruplas[100][4];
};

void gen(struct tc* tabla_cuadruplas, int op, int op1, int op2, int res);
void tc_print(struct tc* tabla_cuadruplas);
#endif
