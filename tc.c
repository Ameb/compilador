#include "tc.h"
#include <stdio.h>
void gen(struct tc* tabla_cuadruplas, int op, int op1, int op2, int res) {
	int nq = tabla_cuadruplas->nextquad;
	tabla_cuadruplas->cuadruplas[nq][0] = op;
	tabla_cuadruplas->cuadruplas[nq][1] = op1;
	tabla_cuadruplas->cuadruplas[nq][2] = op2;
	tabla_cuadruplas->cuadruplas[nq][3] = res;
	tabla_cuadruplas->nextquad = nq + 1;
	printf("Introducidos en la tc\n%d\t%d\t%d\t%d\n",op,op1,op2,res);
}
void tc_print(struct tc* tabla_cuadruplas) {
	printf("Tabla cuadruplas:\nop\top1\top2\tres\n");	
	int i;
	for (i = 0; i < tabla_cuadruplas->nextquad; i++) {
		printf("%d\t%d\t%d\t%d\n",
			tabla_cuadruplas->cuadruplas[i][0],
			tabla_cuadruplas->cuadruplas[i][1],
			tabla_cuadruplas->cuadruplas[i][2],
			tabla_cuadruplas->cuadruplas[i][3]);
	}
}