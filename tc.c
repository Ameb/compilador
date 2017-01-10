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
	printf("Tabla cuadruplas (tamaño %d):\ni\top\top1\top2\tres\n", tabla_cuadruplas->nextquad);	
	int i;
	for (i = 0; i < tabla_cuadruplas->nextquad; i++) {
		printf("%d\t%d\t%d\t%d\t%d\n", i,
			tabla_cuadruplas->cuadruplas[i][0],
			tabla_cuadruplas->cuadruplas[i][1],
			tabla_cuadruplas->cuadruplas[i][2],
			tabla_cuadruplas->cuadruplas[i][3]);
	}
}
void tc_translate(struct tc* tabla_cuadruplas, struct ts* tabla_simbolos) {
	printf("Codigo intermedio:\n");	
	int i;
	for (i = 0; i < tabla_cuadruplas->nextquad; i++) {
		switch (tabla_cuadruplas->cuadruplas[i][0]) {
			case DOP_SUMA_ENT:
				printf("%d\t %s := %s + %s\n", i, varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][3]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][1]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][2]));
				break;
			case DOP_RESTA_ENT:
				printf("%d\t %s := %s - %s\n", i, varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][3]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][1]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][2]));
				break;
			case DOP_MULTIPLICACION_ENT:
				printf("%d\t %s := %s * %s\n", i, varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][3]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][1]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][2]));
				break;
			case DOP_DIVISION_ENT:
				printf("%d\t %s := %s / %s\n", i, varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][3]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][1]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][2]));
				break;
			case DOP_MENOSU_ENT:
				printf("%d\t %s := - %s\n", i, varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][3]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][1]));
				break;
			case DOP_MODENT:
				printf("%d\t %s := %s mod %s\n", i, varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][3]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][1]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][2]));
				break;
			case DOP_DIVENT:
				printf("%d\t %s := %s div %s\n", i, varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][3]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][1]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][2]));
				break;
			case DOP_SUMA_REAL:
				printf("%d\t %s := %s + %s\n", i, varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][3]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][1]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][2]));
				break;
			case DOP_RESTA_REAL:
				printf("%d\t %s := %s - %s\n", i, varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][3]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][1]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][2]));
				break;
			case DOP_MULTIPLICACION_REAL:
				printf("%d\t %s := %s * %s\n", i, varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][3]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][1]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][2]));
				break;
			case DOP_DIVISION_REAL:
				printf("%d\t %s := %s / %s\n", i, varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][3]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][1]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][2]));
				break;
			case DOP_MENOSU_REAL:
				printf("%d\t %s := - %s\n", i, varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][3]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][1]));
				break;
			case DOP_ASIGNACION:
				printf("%d\t %s := %s\n", i, varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][3]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][1]));
				break;
			case DOP_SALTO:
				printf("%d\t goto %d\n", i, tabla_cuadruplas->cuadruplas[i][3]);
				break;
			case DOP_SALTO_SI_MENOR:
				printf("%d\t if %s > %s goto %d\n", i, varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][1]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][2]), tabla_cuadruplas->cuadruplas[i][3]);
				break;
			case DOP_SALTO_SI_MEOI:
				printf("%d\t if %s >= %s goto %d\n", i, varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][1]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][2]), tabla_cuadruplas->cuadruplas[i][3]);
				break;
			case DOP_SALTO_SI_IGUAL:
				printf("%d\t if %s = %s goto %d\n", i, varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][1]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][2]), tabla_cuadruplas->cuadruplas[i][3]);
				break;
			case DOP_SALTO_SI_MAOI:
				printf("%d\t if %s >= %s goto %d\n", i, varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][1]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][2]), tabla_cuadruplas->cuadruplas[i][3]);
				break;
			case DOP_SALTO_SI_MAYOR:
				printf("%d\t if %s > %s goto %d\n", i, varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][1]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][2]), tabla_cuadruplas->cuadruplas[i][3]);
				break;
			case DOP_SALTO_SI_DISTINTO:
				printf("%d\t if %s != %s goto %d\n", i, varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][1]), varname(tabla_simbolos, tabla_cuadruplas->cuadruplas[i][2]), tabla_cuadruplas->cuadruplas[i][3]);
				break;
			default:
				printf("%d\t%d\t%d\t%d\t%d\n", i,
					tabla_cuadruplas->cuadruplas[i][0],
					tabla_cuadruplas->cuadruplas[i][1],
					tabla_cuadruplas->cuadruplas[i][2],
					tabla_cuadruplas->cuadruplas[i][3]);
		}
	}
}
