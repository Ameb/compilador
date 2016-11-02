%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
extern FILE* yyin;

void yyerror(const char* s);
%}

%%

desc_algoritmo: 
    | algoritmo identificador cabecera_alg bloque_alg falgoritmo {}
;
cabecera_alg:
    | decl_globales decl_a_f decl_ent_sal comentario {}
;
bloque_alg:
    | bloque comentario {}
;
decl_globales:
    | declaracion_tipo decl_globales {}
    | declaracion_const decl_globales {}
;
decl_a_f: 
    | accion_d decl_a_f {}
    | funcion_d decl_a_f {}
;
bloque: 
    | declaraciones instrucciones {}
;
declaraciones: 
    | declaracion_tipo declaraciones {}
    | declaracion_const declaraciones {}
    | declaracion_var declaraciones {}
    | declaraciones {}
;
declaracion_tipo: 
    | tipo lista_d_tipo ftipo {}
;
declaracion_cte:
    | const lista_d_cte fconst {}
;
declaracion_var: 
    | var lista_d_var {}
;
lista_d_tipo:
    | identificador TOK_IGUAL d_tipo TOK_PCOMA lista_d_tipo {}
;
d_tipo: 
    | tupla lista_campos ftupla {}
    | tabla TOK_ABCORCH expresion_t TOK_SUBRANGO expresion_t TOK_CERCORCH de d_tipo {}
;
d_tipo:
    | identificador {}
    | expresion_t TOK_SUBRANGO expresion_t {}
    | ref d_tipo {}
    | tipo_base {}
;
expresion_t: 
    | expresion {}
    | literal_caracter {}
;
lista_campos: 
    | identificador TOK_DOSP d_tipo TOK_PCOMA lista_campos {}
;
lista_d_cte: 
    | identificador TOK_IGUAL literal TOK_PCOMA lista_d_cte {}
;
lista_d_var:
    | lista_id TOK_DOSP identificador  TOK_PCOMA {}
    | d_tipo  TOK_PCOMA {}
    | lista_d_var {}
;
lista_id: 
    | identificador TOK_COMA lista_id {}
    | identificador {}
;
decl_ent_sal: 
    | decl_ent {}
    | decl_ent decl_salida {}
    | decl_salida {}
;
decl_ent: 
    | ent lista_d_var {}
;
decl_sal: 
    | sal lista_d_var {}
;
expresion:
    | exp_a {}
    | exp_b {}
    | funcion ll {}
;
exp_a:
    | exp_a TOK_SUMA exp_a {}
    | exp_a TOK_RESTA exp_a {}
    | exp_a TOK_MULT exp_a {}
    | exp_a TOK_DIV exp_a {}
    | exp_a TOK_MOD exp_a {}
;
exp_a:
    | exp_a TOK_DIVENT exp_a {}
    | TOK_ABPAR exp_a TOK_CERPAR {}
    | operando {}
    | literalnumerico {}
    | TOK_RESTA exp_a {}
;
exp_b:
    | exp_b TOK_Y exp_b {}
    | exp_b TOK_O exp_b {}
    | TOK_NO exp_b {}
    | operando {}
    | TOK_VERDADERO {}
    | TOK_FALSO {}
;
exp_b:
    | expresion oprel expresion {}
    | TOK_ABPAR exp_b TOK_CERPAR {}
;
operando:
    | identificador {}
    | operando TOK_PUNTO operando {}
    | operando TOK_ABCORCH expresion TOK_CERCORCH {}
    | operando ref {}
;

instrucciones:
    | instruccion TOK_PCOMA instrucciones {}
    | instruccion {}
;
instruccion:
    | continuar {}
    | asignacion {}
    | alternativa {}
    | iteracion {}
    | accion_ll {}
;
asignacion:
    | operando TOK_ASIGNACION expresion {}
;
alternativa:
    | si expresion TOK_ENTONCES instrucciones lista_opciones fsi {}
;
lista_opciones:
    | TOK_SINO expresion TOK_ENTONCES instrucciones lista_opciones {}
;
iteracion:
    | it_cota_fija {}
    | it_cota_exp {}
;
it_cota_exp:
    | mientras expresion hacer instrucciones fmientras {}
;
it_cota_fija:
    | para identificador TOK_ASIGNACION expresion hasta expresion hacer instrucciones fpara {}
;
accion_d:
    | accion a_cabecera bloque faccion {}
;
funcion_d:
    | funcion f_cabecera bloque dev expresion ffuncion {}
; 
a_cabecera:
    | identificador TOK_ABPAR d_par_form TOK_CERPAR TOK_PCOMA {}
;
f_cabecera:
    | identificador TOK_ABPAR lista_d_var TOK_CERPAR dev d_tipo TOK_PCOMA {}
;
dparform:
    | dpform TOK_PCOMA dparform {}
;
dpform:
    | ent listaid TOK_DOSP dtipo {}
    | sal listaid TOK_DOSP dtipo {}
    | TOK_ES listaid TOK_DOSP dtipo {}
;
accion_ll: 
    | identificador TOK_ABPAR l_ll TOK_CERPAR {}
;
funcion_ll: 
    | identificador TOK_ABPAR l_ll TOK_CERPAR {}
;
l_ll: 
    | expresion TOK_COMA l_ll {}
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
