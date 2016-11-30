%{
#include <stdio.h>
#include <stdlib.h>
#include "ts.h"

int yylex();
extern FILE* yyin;

void yyerror(const char* s);
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
%token TOK_VAR
%token TOK_TUPLA TOK_FTUPLA
%token TOK_TABLA
%token TOK_DE
%token TOK_REF
%token TOK_ABCORCH TOK_CERCORCH
%left TOK_PUNTO
%token TOK_TIPOBASE
%token TOK_LITERAL
%token TOK_LITERALCARACTER
%token TOK_LITERALNUMERICO
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
%token TOK_PCOMA
%token TOK_COMA
%token TOK_ES
%token TOK_SUBRANGO
%token TOK_DOSP
%left TOK_SUMA TOK_RESTA
%left TOK_MULT TOK_DIV
%left TOK_MOD TOK_DIVENT

%union {
    struct nodo * para_lista_id;
    char * para_cadenas;
}
%type <para_lista_id> lista_id_prueba
%%



desc_algoritmo: TOK_ALGORITMO TOK_IDENTIFICADOR cabecera_alg bloque_alg TOK_FALGORITMO {}
;
cabecera_alg: decl_globales decl_a_f decl_ent_sal TOK_COMENTARIO {}
;
bloque_alg: bloque TOK_COMENTARIO {}
;
decl_globales: declaracion_tipo decl_globales {}
    | declaracion_cte decl_globales {}
    |
;
decl_a_f: accion_d decl_a_f {}
    | funcion_d decl_a_f {}
    |
;
bloque: declaraciones instrucciones {}
;
declaraciones: declaracion_tipo declaraciones {}
    | declaracion_cte declaraciones {}
    | declaracion_var declaraciones {}
    |  {}
;
declaracion_tipo: TOK_TIPO lista_d_tipo TOK_FTIPO {}
;
declaracion_cte: TOK_CONST lista_d_cte TOK_FCONST {}
;
declaracion_var: TOK_VAR lista_d_var {}
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
    | TOK_TIPOBASE {}
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
lista_d_var: lista_id TOK_DOSP TOK_IDENTIFICADOR TOK_PCOMA lista_d_var {}
    |  lista_id TOK_DOSP d_tipo TOK_PCOMA lista_d_var {}
    |  {}
;
lista_id: TOK_IDENTIFICADOR TOK_COMA lista_id {}
    | TOK_IDENTIFICADOR {}
;
lista_d_var_prueba: lista_id_prueba TOK_PCOMA lista_id_prueba {
    }
    |   {}
;
lista_id_prueba: TOK_IDENTIFICADOR TOK_DOSP TOK_IDENTIFICADOR {
        // Esta gramatica es para tipos definidos por el usuario
    }
    | TOK_IDENTIFICADOR TOK_DOSP d_tipo {
        // guardar el tipo en algun sitio
    }
    | TOK_IDENTIFICADOR TOK_COMA lista_id_prueba {
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
exp_a: exp_a TOK_SUMA exp_a {}
    | exp_a TOK_RESTA exp_a {}
    | exp_a TOK_MULT exp_a {}
    | exp_a TOK_DIV exp_a {}
    | exp_a TOK_MOD exp_a {}
;
exp_a: exp_a TOK_DIVENT exp_a {}
    | TOK_ABPAR exp_a TOK_CERPAR {}
    | operando {}
    | TOK_LITERALNUMERICO {}
    | TOK_MENOSU exp_a {}
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
operando: TOK_IDENTIFICADOR {}
    | operando TOK_PUNTO operando {}
    | operando TOK_ABCORCH expresion TOK_CERCORCH {}
    | operando TOK_REF {}
;

instrucciones: instruccion TOK_PCOMA instrucciones {}
    | instruccion {}
;
instruccion:  TOK_CONTINUAR {}
    | asignacion {}
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

int main() {

}
int yylex() {

}
void yyerror(const char* s) {
  fprintf(stderr, "Parse error: %s\n", s);

}
