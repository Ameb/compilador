%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
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
}
%type <para_entero> lista_id
%type <para_entero> d_tipo
%type <para_entero> operando
%type <para_entero> exp_a
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
        $$ = $3;
        addVarToTS($1,$3);
        // guardar el tipo en algun sitio

    }
    | TOK_IDENTIFICADOR TOK_COMA lista_id {
        printf("P: leido %s de tipo %d\n", $1, $3);
        $$ = $3;
        addVarToTS($1,$3);
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
expresion: exp_a {}
    | exp_b {}
    | funcion_ll {}
;
exp_a: exp_a TOK_SUMA exp_a {
        if (ts_tipo($1) == ts_tipo($3)) {
            int res = newtemp(tabla_simbolos, ts_tipo($1));
            gen(tabla_cuadruplas, $2, $1, $3, res);
        }
        else {
            yyerror("Tipos incompatibles.");        
        }
    }
    | exp_a TOK_RESTA exp_a {
        if (ts_tipo($1) == ts_tipo($3)) {
            int res = newtemp(tabla_simbolos, ts_tipo($1));
            gen(tabla_cuadruplas, $2, $1, $3, res);
        }
        else {
            yyerror("Tipos incompatibles.");        
        }
    }
    | exp_a TOK_MULT exp_a {
        if (ts_tipo($1) == ts_tipo($3)) {
            int res = newtemp(tabla_simbolos, ts_tipo($1));
            gen(tabla_cuadruplas, $2, $1, $3, res);
        }
        else {
            yyerror("Tipos incompatibles.");        
        }
    }
    | exp_a TOK_DIV exp_a {
        if (ts_tipo($1) == ts_tipo($3)) {
            int res = newtemp(tabla_simbolos, ts_tipo($1));
            gen(tabla_cuadruplas, $2, $1, $3, res);
        }
        else {
            yyerror("Tipos incompatibles.");        
        }
    }
    | exp_a TOK_MOD exp_a {
        if (ts_tipo($1) == ts_tipo($3)) {
            int res = newtemp(tabla_simbolos, ts_tipo($1));
            gen(tabla_cuadruplas, $2, $1, $3, res);
        }
        else {
            yyerror("Tipos incompatibles.");        
        }
    }
;
exp_a: exp_a TOK_DIVENT exp_a {
        if (ts_tipo($1) == ts_tipo($3)) {
            int res = newtemp(tabla_simbolos, ts_tipo($1));
            gen(tabla_cuadruplas, $2, $1, $3, res);
        }
        else {
            yyerror("Tipos incompatibles.");        
        }
    }
    | TOK_ABPAR exp_a TOK_CERPAR {
        $$ = $2;
    }
    | operando {}
    | TOK_LITERALNUMERICO {
        //printf("Leido %f",$1.val_real);
    }
    | TOK_MENOSU exp_a {
        int res = newtemp(tabla_simbolos, ts_tipo($2));
        gen(tabla_cuadruplas, ts_tipo($2), NULL, $2, res); /// CAMBIAR EL NULL
    }
;
exp_b: exp_b TOK_Y exp_b {}
    | exp_b TOK_O exp_b {}
    | TOK_NO exp_b {}
//    | operando {}    las expresiones booleanas ya no pueden ser terminales
    | TOK_VERDADERO {}
    | TOK_FALSO {}
;
exp_b: expresion TOK_OPREL expresion {}
    | TOK_ABPAR exp_b TOK_CERPAR {}
;
operando: TOK_IDENTIFICADOR {
        // sacar sid de la variable y meterlo en $$
    }
    | operando TOK_PUNTO operando {}
    | operando TOK_ABCORCH expresion TOK_CERCORCH {}
    | operando TOK_REF {}
;

instrucciones: instruccion TOK_PCOMA instrucciones {
        printf("P: Reducida instruccion con mas instrucciones detras\n");
    }
    | instruccion {
        printf("P: Reducida instruccion 'suelta'\n");
    }
    | {}
;
instruccion:  TOK_CONTINUAR {}
    | asignacion {
        printf("P: reducida instruccion asignacion\n");
        }
    | alternativa {}
    | iteracion {}
    | accion_ll {}
;
asignacion: operando TOK_ASIGNACION expresion {}
;
alternativa: TOK_SI expresion TOK_ENTONCES instrucciones lista_opciones TOK_FSI {}
;
lista_opciones: TOK_SINO expresion TOK_ENTONCES instrucciones lista_opciones {}
    |
;
iteracion: it_cota_fija {}
    | it_cota_exp {}
;
it_cota_exp: TOK_MIENTRAS expresion TOK_HACER instrucciones TOK_FMIENTRAS {}
;
it_cota_fija: TOK_PARA TOK_IDENTIFICADOR TOK_ASIGNACION expresion TOK_HASTA expresion TOK_HACER instrucciones TOK_FPARA {}
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
    tabla_cuadruplas = (struct tc*) malloc (sizeof(struct tc));
    yyparse();
    ts_print(tabla_simbolos);
    test = ts_buscar_nombre(tabla_simbolos,(char*) aux);
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
