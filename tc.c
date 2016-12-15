#include "tc.h"

void gen(struct tc* tabla_cuadruplas, int op, int op1, int op2, int res) {
	int nq = tabla_cuadruplas->nextquad;
	tabla_cuadruplas->cuadruplas[nq][0] = op;
	tabla_cuadruplas->cuadruplas[nq][1] = op1;
	tabla_cuadruplas->cuadruplas[nq][2] = op2;
	tabla_cuadruplas->cuadruplas[nq][3] = res;
	tabla_cuadruplas->nextquad = nq + 1;
}