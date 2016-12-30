%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "lb.h"
#include "ts.h"
#include "tc.h"
#include "definiciones.h"

int yylex();
extern FILE* yyin;

void yyerror(const char* s);
void addVarToTS(char* nombre, int tipo);
struct ts* tabla_simbolos;
struct tc* tabla_cuadruplas;
struct nodo * test;
char aux[] = "aux";
%}

%token TOK_ABPAR TOK_CERPAR
%token TOK_Y TOK_O
%token TOK_NO
%token TOK_VERDADERO
%token TOK_FALSO
%token TOK_ASIGNACION
%token TOK_ENTONCES
%token TOK_SINO
%right TOK_MENOSU
%token TOK_ALGORITMO TOK_FALGORITMO
%token TOK_COMENTARIO
%token TOK_TIPO TOK_FTIPO
%token TOK_CONST TOK_FCONST
%token TOK_VAR TOK_FVAR
%token TOK_TUPLA TOK_FTUPLA
%token TOK_TABLA
%token TOK_DE
%token TOK_REF
%token TOK_ABCORCH TOK_CERCORCH
%left TOK_PUNTO
%token <para_entero> TOK_TIPOBASE
%token TOK_LITERAL
%token TOK_LITERALCARACTER
%token <para_valor> TOK_LITERALNUMERICO
%token TOK_ENT TOK_SAL
%nonassoc TOK_OPREL
%token TOK_PARA TOK_HASTA TOK_HACER TOK_FPARA
%token TOK_MIENTRAS TOK_FMIENTRAS
%token TOK_SI TOK_FSI
%token TOK_CONTINUAR
%token <para_cadenas> TOK_IDENTIFICADOR
%token TOK_ACCION TOK_FACCION
%token TOK_FUNCION TOK_FFUNCION
%token TOK_DEV
%token TOK_IGUAL
// asignacion?
%token TOK_PCOMA
%token TOK_COMA
%token TOK_ES
%token TOK_SUBRANGO
%token TOK_DOSP
%left <para_entero> TOK_SUMA TOK_RESTA
%left <para_entero> TOK_MULT TOK_DIV
%left <para_entero> TOK_MOD TOK_DIVENT
%union {
    //struct nodo * para_lista_id;
    int para_entero;
    char * para_cadenas;
    struct {
        struct lb * truelist;
        struct lb * falselist;
    }para_bool;
    struct {
        struct lb * nextlist;
    }para_instr;
}
%type <para_entero> lista_id
%type <para_entero> d_tipo
%type <para_entero> operando
%type <para_entero> exp_a
%type <para_entero> expresion
%type <para_bool> exp_b
%type <para_entero> M
%type <para_entero> op_rel
%type <para_instr> instruccion
%type <para_instr> instrucciones
%type <para_instr> alternativa
%type <para_instr> lista_opciones
%type <para_instr> asignacion
%type <para_instr> it_cota_exp
%%



desc_algoritmo: TOK_ALGORITMO TOK_IDENTIFICADOR cabecera_alg bloque_alg TOK_FALGORITMO {
    printf("P: reducido desc_algoritmo\n");
}
    | exp_a {}
;
cabecera_alg: decl_globales decl_a_f decl_ent_sal TOK_COMENTARIO {
    printf("P: reducido cabecera_alg\n");
}
;
bloque_alg: bloque TOK_COMENTARIO {
    printf("P: reducido bloque_alg\n");
}
;
decl_globales: declaracion_tipo decl_globales {}
    | declaracion_cte decl_globales {}
    | {printf("P: no hay decl_globales\n");}
;
decl_a_f: accion_d decl_a_f {}
    | funcion_d decl_a_f {}
    | {printf("P: no hay decl_a_f\n");}
;
bloque: declaraciones instrucciones {
    printf("P: reducido bloque\n");
}
;
declaraciones: declaracion_tipo declaraciones {}
    | declaracion_cte declaraciones {}
    | declaracion_var declaraciones {
        printf("P: reducida declaracion_var\n");
    }
    | {}
;
declaracion_tipo: TOK_TIPO lista_d_tipo TOK_FTIPO {}
;
declaracion_cte: TOK_CONST lista_d_cte TOK_FCONST {}
;
declaracion_var: TOK_VAR lista_d_var TOK_FVAR{}
;
lista_d_tipo: TOK_IDENTIFICADOR TOK_IGUAL d_tipo TOK_PCOMA lista_d_tipo {}
    |
;
d_tipo: TOK_TUPLA lista_campos TOK_FTUPLA {}
    | TOK_TABLA TOK_ABCORCH expresion_t TOK_SUBRANGO expresion_t TOK_CERCORCH TOK_DE d_tipo {}
;
d_tipo: TOK_IDENTIFICADOR {}
    | expresion_t TOK_SUBRANGO expresion_t {}
    | TOK_REF d_tipo {}
    | TOK_TIPOBASE {
        $$ = $1;
        printf("P: Reducido TOK_TIPOBASE d_tipo: %d\n",$$);
    }
;
expresion_t: expresion {}
    | TOK_LITERALCARACTER {}
;
lista_campos: TOK_IDENTIFICADOR TOK_DOSP d_tipo TOK_PCOMA lista_campos {}
    |
;
lista_d_cte: TOK_IDENTIFICADOR TOK_IGUAL TOK_LITERAL TOK_PCOMA lista_d_cte {}
    |
;
/*
lista_d_var: lista_id TOK_DOSP TOK_IDENTIFICADOR TOK_PCOMA lista_d_var {}
    |  lista_id TOK_DOSP d_tipo TOK_PCOMA lista_d_var {}
    |  {}
;
lista_id: TOK_IDENTIFICADOR TOK_COMA lista_id {}
    | TOK_IDENTIFICADOR {
        printf("P: Reducida lista_id con un unico item\n");
    }
;
*/
lista_d_var: lista_id TOK_PCOMA lista_d_var {}
    |   {}
;
lista_id: TOK_IDENTIFICADOR TOK_DOSP d_tipo {
        printf("P: reducido tipo %d\n",$3);
        printf("P: leido %s de tipo %d\n", $1, $3);
           
	if (ts_buscar_nombre(tabla_simbolos, $1) == NULL) {
		$$ = $3;   	
		addVarToTS($1,$3);
	}
	else {
		yyerror("Variable duplicada");	
	}
        // guardar el tipo en algun sitio

    }
    | TOK_IDENTIFICADOR TOK_COMA lista_id {
        printf("P: leido %s de tipo %d\n", $1, $3);

        if (ts_buscar_nombre(tabla_simbolos, $1) == NULL) {
		$$ = $3;     	
		addVarToTS($1,$3);
	}
	else {
		yyerror("Variable duplicada");	
	}
        // en lista_id tenemos ese tipo guardado para asignarlo a 
        // TOK_IDENTIFICADOR
    }
;
decl_ent_sal: decl_ent {}
    | decl_ent decl_sal {}
    | decl_sal {}
;
decl_ent: TOK_ENT lista_d_var {}
;
decl_sal: TOK_SAL lista_d_var {}
;
expresion: exp_a {
        $$ = $1;
    }
    | exp_b {
        //pasar de booleano a expresion
    }
    | funcion_ll {}
;
exp_a: exp_a TOK_SUMA exp_a {
        //printf("Sumando variables %d y %d de tipos %d y %d\n",$1,$3,ts_tipo(tabla_simbolos, $1),ts_tipo(tabla_simbolos, $3));
        if (ts_tipo(tabla_simbolos, $1) == ts_tipo(tabla_simbolos, $3)) {
            int res = newtemp(tabla_simbolos, ts_tipo(tabla_simbolos,$1));
            int aux;
            switch(ts_tipo(tabla_simbolos,res)) {
                case D_ENTERO:
                    aux = DOP_SUMA_ENT;
                    break;
                case D_REAL:
                    aux = DOP_SUMA_REAL;
                    break;
                default:
                    yyerror("suma: tipo no conocido");
            }
            gen(tabla_cuadruplas, aux, $1, $3, res);
            $$ = res;
        }
        else {
            yyerror("suma: Tipos incompatibles.");        
        }
    }
    | exp_a TOK_RESTA exp_a {
        if (ts_tipo(tabla_simbolos, $1) == ts_tipo(tabla_simbolos, $3)) {
            int res = newtemp(tabla_simbolos, ts_tipo(tabla_simbolos, $1));
            int aux;
            switch(ts_tipo(tabla_simbolos,res)) {
                case D_ENTERO:
                    aux = DOP_RESTA_ENT;
                    break;
                case D_REAL:
                    aux = DOP_RESTA_REAL;
                    break;
                default:
                    yyerror("resta: tipo no conocido");
            }
            gen(tabla_cuadruplas, aux, $1, $3, res);
            $$ = res;
        }
        else {
            yyerror("resta: Tipos incompatibles.");        
        }
    }
    | exp_a TOK_MULT exp_a {
        if (ts_tipo(tabla_simbolos, $1) == ts_tipo(tabla_simbolos, $3)) {
            int res = newtemp(tabla_simbolos, ts_tipo(tabla_simbolos, $1));
            int aux;
            switch(ts_tipo(tabla_simbolos,res)) {
                case D_ENTERO:
                    aux = DOP_MULTIPLICACION_ENT;
                    break;
                case D_REAL:
                    aux = DOP_MULTIPLICACION_REAL;
                    break;
                default:
                    yyerror("mult: tipo no conocido");
            }
            gen(tabla_cuadruplas, aux, $1, $3, res);
            $$ = res;
        }
        else {
            yyerror("mult: tipos incompatibles.");        
        }
    }
    | exp_a TOK_DIV exp_a {
        if (ts_tipo(tabla_simbolos, $1) == ts_tipo(tabla_simbolos, $3)) {
            int res = newtemp(tabla_simbolos, ts_tipo(tabla_simbolos, $1));
            int aux;
            switch(ts_tipo(tabla_simbolos,res)) {
                case D_ENTERO:
                    aux = DOP_DIVISION_ENT;
                    break;
                case D_REAL:
                    aux = DOP_DIVISION_REAL;
                    break;
                default:
                    yyerror("division: tipo no conocido");
            }
            gen(tabla_cuadruplas, aux, $1, $3, res);
            $$ = res;
        }
        else {
            yyerror("division: tipos incompatibles");        
        }
    }
    | exp_a TOK_MOD exp_a {
        if (ts_tipo(tabla_simbolos, $1) == ts_tipo(tabla_simbolos, $3)) {
            int res = newtemp(tabla_simbolos, ts_tipo(tabla_simbolos, $1));
            int aux;
            switch(ts_tipo(tabla_simbolos,res)) {
                case D_ENTERO:
                    aux = DOP_MODENT;
                    break;
                default:
                    yyerror("mod: tipo no conocido");
            }
            printf("mod");
            gen(tabla_cuadruplas, aux, $1, $3, res);
            $$ = res;
        }
        else {
            yyerror("mod: Tipos incompatibles");        
        }
    }
;
exp_a: exp_a TOK_DIVENT exp_a {
        if (ts_tipo(tabla_simbolos, $1) == ts_tipo(tabla_simbolos, $3)) {
            int res = newtemp(tabla_simbolos, ts_tipo(tabla_simbolos, $1));
            int aux;
            switch(ts_tipo(tabla_simbolos,res)) {
                case D_ENTERO:
                    aux = DOP_DIVENT;
                    break;
                default:
                    yyerror("divent: tipo no conocido");
            }
            gen(tabla_cuadruplas, aux, $1, $3, res);
            $$ = res;
        }
        else {
            yyerror("divent: Tipos incompatibles.");        
        }
    }
    | TOK_ABPAR exp_a TOK_CERPAR {
        $$ = $2;
    }
    | operando {} /* $$ = $1 */
    | TOK_LITERALNUMERICO {
        //printf("Leido %f",$1.val_real);
    }
    | TOK_RESTA exp_a {
        int res = newtemp(tabla_simbolos, ts_tipo(tabla_simbolos, $2));
        int aux = 0;
        switch(ts_tipo(tabla_simbolos,res)) {
            case D_ENTERO:
                aux = DOP_MENOSU_ENT;
                break;
            case D_REAL:
                aux = DOP_MENOSU_REAL;
                break;
            default:
                yyerror("restau: tipo no conocido");
        }
        // printf("asd");
        gen(tabla_cuadruplas, aux, $2, 0, res);
        $$ = res;
    }
;
exp_b: exp_b TOK_Y M exp_b {
        backpatch(tabla_cuadruplas, $1.falselist, $3);
        $$.falselist = merge($1.falselist, $4.falselist);
        $$.truelist = $4.truelist;
    }
    | exp_b TOK_O  M exp_b {
        backpatch(tabla_cuadruplas, $1.truelist, $3);
        $$.truelist = merge($1.truelist, $4.truelist);
        $$.falselist = $4.falselist;
    }
    | TOK_NO exp_b {
        $$.truelist = $2.falselist;
        $$.falselist = $2.truelist;
    }
//    | operando {}    las expresiones booleanas ya no pueden ser terminales
    | TOK_VERDADERO {
        $$.truelist = makelist(tabla_cuadruplas->nextquad);
        gen(tabla_cuadruplas, DOP_SALTO, 0, 0, 0);
    }
    | TOK_FALSO {
        $$.falselist = makelist(tabla_cuadruplas->nextquad);
        gen(tabla_cuadruplas, DOP_SALTO, 0, 0, 0);
    }
;
M: {
        $$ = tabla_cuadruplas->nextquad;
    }
;
exp_b: expresion op_rel M expresion {
        int op;
        switch ($2) {
            case D_MENOR:
                op = DOP_SALTO_SI_MENOR;
                break;
            case D_MEOI:
                op = DOP_SALTO_SI_MEOI;
                break;
            case D_IGUAL:/*TOK_IGUAL*/
                op = DOP_SALTO_SI_IGUAL;
                break;
            case D_MAOI:
                op = DOP_SALTO_SI_MAOI;
                break;
            case D_MAYOR:
                op = DOP_SALTO_SI_MAYOR;
                break;
        }
        $$.truelist = makelist($3);
        $$.truelist = makelist($3);
        gen(tabla_cuadruplas, op, $1, $4, 0);
        gen(tabla_cuadruplas, DOP_SALTO, 0, 0, 0);
    }
    | TOK_ABPAR exp_b TOK_CERPAR {}
;
op_rel: TOK_OPREL {}
    | TOK_IGUAL {}
;
operando: TOK_IDENTIFICADOR {
        struct nodo* aux;
        aux = ts_buscar_nombre(tabla_simbolos, $1);
        if (aux != NULL)
            $$ = aux->sid;
        else
            yyerror("variable desconocida");
    }
    | operando TOK_PUNTO operando {}
    | operando TOK_ABCORCH expresion TOK_CERCORCH {}
    | operando TOK_REF {}
;

instrucciones: instruccion TOK_PCOMA M instrucciones {
        printf("P: Reducida instruccion con mas instrucciones detras\n");
        printf("P: nextquad: %d\n", tabla_cuadruplas->nextquad);
        backpatch(tabla_cuadruplas, $1.nextlist, $3);
        /*
        if ($3.nextlist == NULL) {
            $$.nextlist = $1.nextlist;
        }
        else {
            $$.nextlist = $3.nextlist;
        }
        */
    }
    | instruccion {
        printf("P: Reducida instruccion 'suelta'\n");
        $$ = $1;
    }
    | {
        $$.nextlist = NULL;
    }
;
instruccion:  TOK_CONTINUAR {}
    | asignacion {
        printf("P: reducida instruccion asignacion\n");
        $$ = $1;
    }
    | alternativa {}
    | iteracion {}
    | accion_ll {}
;
asignacion: operando TOK_ASIGNACION expresion {
        printf("Asignacion: %d(%d) := %d(%d)\n", $1, ts_tipo(tabla_simbolos, $1), $3, ts_tipo(tabla_simbolos, $3));
        if (ts_tipo(tabla_simbolos, $1) == ts_tipo(tabla_simbolos, $3)) {
            int res = newtemp(tabla_simbolos, ts_tipo(tabla_simbolos, $1));
            gen(tabla_cuadruplas, DOP_ASIGNACION, $1, $3, res);
            $$.nextlist = makelist(tabla_cuadruplas->nextquad);
        } else {
            yyerror("asignacion: Tipos incompatibles."); 
        }
}
;
alternativa: TOK_SI exp_b TOK_ENTONCES M instrucciones lista_opciones TOK_FSI {
        backpatch(tabla_cuadruplas, $2.truelist, $4);
        $$.nextlist = merge($2.falselist, $5.nextlist)
        }
;
lista_opciones: TOK_SINO exp_b TOK_ENTONCES M instrucciones lista_opciones {
        backpatch(tabla_cuadruplas, $2.truelist, $4);
        $$.nextlist = merge($2.falselist, $5.nextlist)
    }
    |   {
            $$.nextlist = NULL;
    }
;
iteracion: it_cota_fija {}
    | it_cota_exp {}
;
it_cota_exp: TOK_MIENTRAS M exp_b TOK_HACER M instrucciones TOK_FMIENTRAS {
    backpatch(tabla_cuadruplas, $6.nextlist, $2);
    backpatch(tabla_cuadruplas, $3.truelist, $5);
    $$.nextlist = $3.falselist;
    gen(tabla_cuadruplas, DOP_SALTO, 0, 0, $2);
}
;
it_cota_fija: TOK_PARA TOK_IDENTIFICADOR TOK_ASIGNACION exp_b TOK_HASTA expresion TOK_HACER instrucciones TOK_FPARA {}
;
accion_d: TOK_ACCION a_cabecera bloque TOK_FACCION {}
;
funcion_d: TOK_FUNCION f_cabecera bloque TOK_DEV expresion TOK_FFUNCION {}
; 
a_cabecera: TOK_IDENTIFICADOR TOK_ABPAR d_par_form TOK_CERPAR TOK_PCOMA {}
;
f_cabecera: TOK_IDENTIFICADOR TOK_ABPAR lista_d_var TOK_CERPAR TOK_DEV d_tipo TOK_PCOMA {}
;
d_par_form:
    | d_p_form TOK_PCOMA d_par_form {}
;
d_p_form: TOK_ENT lista_id TOK_DOSP d_tipo {}
    | TOK_SAL lista_id TOK_DOSP d_tipo {}
    | TOK_ES lista_id TOK_DOSP d_tipo {}
;
accion_ll: TOK_IDENTIFICADOR TOK_ABPAR l_ll TOK_CERPAR {}
;
funcion_ll: TOK_IDENTIFICADOR TOK_ABPAR l_ll TOK_CERPAR {}
;
l_ll: expresion TOK_COMA l_ll {}
    | expresion {}
;

%%
extern FILE * yyin;
int main( int argc, char **argv ){
    ++argv, --argc;  /* skip over program name */
    if ( argc > 0 )
         yyin = fopen( argv[0], "r" );
    else
         yyin = stdin;
    tabla_simbolos = (struct ts*) malloc (sizeof(struct ts));
    ts_init(tabla_simbolos);
    tabla_cuadruplas = (struct tc*) malloc (sizeof(struct tc));
    yyparse();
    ts_print(tabla_simbolos);
    tc_print(tabla_cuadruplas);
    
    struct nodo *aux2;    
    aux2 = ts_buscar_sid(tabla_simbolos, 1);

    test = ts_buscar_nombre(tabla_simbolos,(char*) aux2->nombre);
    if (test != NULL) {
        printf("Encontrado aux: %s", test->nombre);
    }
}

void yyerror(const char* s) {
  fprintf(stderr, "Parse error: %s\n", s);

}
// añadir variable a la tabla de símbolos
void addVarToTS(char *nombre, int tipo) {
    //char * nom = malloc(strlen(nombre));
    //strncpy(nom, nombre, strlen(nombre));
    struct nodo *temp;
    temp = (struct nodo *) malloc(sizeof(struct nodo));
    //temp->nombre = strdup(nombre);
    temp->nombre = (char *)malloc(strlen(nombre));;
    strncpy(temp->nombre, nombre, strlen(nombre));
    temp->tipo = tipo;
    temp->sig = NULL;
    ts_append(tabla_simbolos, temp);
}
