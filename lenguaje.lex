%{
#include <stdio.h>
#include "definiciones.h"
#include "parser.tab.h"
%}
ER_cifra               [0-9]
ER_letra               [A-Za-z]
ER_letra_o_cifra       ({ER_letra}|{ER_cifra})
ER_special             [\"\{\}_\']
ER_abpar               \(
ER_cerpar              \)
ER_white_space         [ \t]
ER_identificador       {ER_letra}{ER_letra_o_cifra}*
ER_exponente           (e|E){ER_cifra}+
ER_literal_entero      {ER_cifra}+{ER_exponente}?
ER_literal_real        {ER_cifra}+\.{ER_cifra}+{ER_exponente}?
ER_literal_verdadero   (?i:verdadero)
ER_literal_falso       (?i:falso)
ER_literal_caracter    \"[^\"]*\"
ER_literal_cadena      \'([^']|\/\')*\'
ER_comentario          \{([^\}]|\/\}|ER_letra_o_cifra)*\}
ER_OP_comp_sec         ;
ER_OP_igual            =
ER_OP_asignacion       \:=
ER_OP_tipado           \:
ER_OP_separador        \,
ER_OP_subrango         \.\.
ER_OP_entonces         \-\>
ER_OP_si_no_si         \[\]
ER_OP_array_inicio     \[
ER_OP_array_fin        \]
ER_OP_suma             \+
ER_OP_resta            \-
ER_OP_multiplicacion   \*
ER_OP_division         \/
ER_OP_mayor            \>
ER_OP_menor            \<
ER_OP_mayor_o_igual    \>=
ER_OP_menor_o_igual    \<=
ER_OP_distinto         \<\>
ER_KW_accion           (?i:accion)
ER_KW_algoritmo        (?i:algoritmo)
ER_KW_booleano         (?i:booleano)
ER_KW_cadena           (?i:cadena)
ER_KW_caracter         (?i:caracter)
ER_KW_const            (?i:const)
ER_KW_continuar        (?i:continuar)
ER_KW_de               (?i:de)
ER_KW_dev              (?i:dev)
ER_KW_div              (?i:div)
ER_KW_ent              (?i:ent)
ER_KW_entero           (?i:entero)
ER_KW_es               (?i:e\/s)
ER_KW_faccion          (?i:faccion)
ER_KW_falgoritmo       (?i:falgoritmo)
ER_KW_fconst           (?i:fconst)
ER_KW_ffuncion         (?i:ffuncion)
ER_KW_fmientras        (?i:fmientras)
ER_KW_fpara            (?i:fpara)
ER_KW_fsi              (?i:fsi)
ER_KW_ftipo            (?i:ftipo)
ER_KW_ftupla           (?i:ftupla)
ER_KW_funcion          (?i:funcion)
ER_KW_fvar             (?i:fvar)
ER_KW_hacer            (?i:hacer)
ER_KW_hasta            (?i:hasta)
ER_KW_mientras         (?i:mientras)
ER_KW_mod              (?i:mod)
ER_KW_no               (?i:no)
ER_KW_o                (?i:o)
ER_KW_para             (?i:para)
ER_KW_real             (?i:real)
ER_KW_ref              (?i:ref)
ER_KW_sal              (?i:sal)
ER_KW_si               (?i:si)
ER_KW_tabla            (?i:tabla)
ER_KW_tipo             (?i:tipo)
ER_KW_tupla            (?i:tupla)
ER_KW_var              (?i:var)
ER_KW_y                (?i:y)

%%
{ER_KW_accion} {
    printf("keyword KW_accion %s\n", yytext);
}
{ER_KW_algoritmo} {
    printf("keyword KW_algoritmo %s\n", yytext);
    return TOK_ALGORITMO;
}
{ER_KW_booleano} {
    printf("keyword KW_booleano %s\n", yytext);
    yylval.para_entero = D_BOOLEANO;
    return TOK_TIPOBASE;
}
{ER_KW_cadena} {
    printf("keyword KW_cadena %s\n", yytext);
    yylval.para_entero = D_CADENA;
    return TOK_TIPOBASE;
}
{ER_KW_caracter} {
    printf("keyword KW_caracter %s\n", yytext);
    yylval.para_entero = D_CARACTER;
    return TOK_TIPOBASE;
}
{ER_KW_const} {
    printf("keyword KW_const %s\n", yytext);
    return TOK_CONST;
}
{ER_KW_continuar} {
    printf("keyword KW_continuar %s\n", yytext);
    return TOK_CONTINUAR;
}
{ER_KW_de} {
    printf("keyword KW_de %s\n", yytext);
    return TOK_DE;
}
{ER_KW_dev} {
    printf("keyword KW_dev %s\n", yytext);
    return TOK_DEV;
}
{ER_KW_div} {
    printf("keyword KW_div %s\n", yytext);
    return TOK_DIVENT;
}
{ER_KW_ent} {
    printf("keyword KW_ent %s\n", yytext);
    return TOK_ENT;
}
{ER_KW_entero} {
    printf("keyword KW_entero %s\n", yytext);
    yylval.para_entero = D_ENTERO;
    return TOK_TIPOBASE;
}
{ER_KW_es} {
    printf("keyword KW_es %s\n", yytext);
    return TOK_ES;
}
{ER_KW_faccion} {
    printf("keyword KW_faccion %s\n", yytext);
    return TOK_FACCION;
}
{ER_KW_falgoritmo} {
    printf("keyword KW_falgoritmo %s\n", yytext);
    return TOK_FALGORITMO;
}
{ER_KW_fconst} {
    printf("keyword KW_fconst %s\n", yytext);
    return TOK_FCONST;
}
{ER_KW_ffuncion} {
    printf("keyword KW_ffuncion %s\n", yytext);
    return TOK_FFUNCION;
}
{ER_KW_fmientras} {
    printf("keyword KW_fmientras %s\n", yytext);
    return TOK_FMIENTRAS;
}
{ER_KW_fpara} {
    printf("keyword KW_fpara %s\n", yytext);
    return TOK_FPARA;
}
{ER_KW_fsi} {
    printf("keyword KW_fsi %s\n", yytext);
    return TOK_FSI;
}
{ER_KW_ftipo} {
    printf("keyword KW_ftipo %s\n", yytext);
    return TOK_FTIPO;
}
{ER_KW_ftupla} {
    printf("keyword KW_ftupla %s\n", yytext);
    return TOK_FTUPLA;
}
{ER_KW_funcion} {
    printf("keyword KW_funcion %s\n", yytext);
    return TOK_FUNCION;
}
{ER_KW_fvar} {
    printf("keyword KW_fvar %s\n", yytext);
    return TOK_FVAR;
}
{ER_KW_hacer} {
    printf("keyword KW_hacer %s\n", yytext);
    return TOK_HACER;
}
{ER_KW_hasta} {
    printf("keyword KW_hasta %s\n", yytext);
    return TOK_HASTA;
}
{ER_KW_mientras} {
    printf("keyword KW_mientras %s\n", yytext);
    return TOK_MIENTRAS;
}
{ER_KW_mod} {
    printf("keyword KW_mod %s\n", yytext);
    return TOK_MOD;
}
{ER_KW_no} {
    printf("keyword KW_no %s\n", yytext);
    return TOK_NO;
}
{ER_KW_o} {
    printf("keyword KW_o %s\n", yytext);
    return TOK_O;
}
{ER_KW_para} {
    printf("keyword KW_para %s\n", yytext);
    return TOK_PARA;
}
{ER_KW_real} {
    printf("keyword KW_real %s\n", yytext);
    yylval.para_entero = D_REAL;
    return TOK_TIPOBASE;
}
{ER_KW_ref} {
    printf("keyword KW_ref %s\n", yytext);
    return TOK_REF;
}
{ER_KW_sal} {
    printf("keyword KW_sal %s\n", yytext);
    return TOK_SAL;
}
{ER_KW_si} {
    printf("keyword KW_si %s\n", yytext);
    return TOK_SI;
}
{ER_KW_tabla} {
    printf("keyword KW_tabla %s\n", yytext);
    return TOK_TABLA;
}
{ER_KW_tipo} {
    printf("keyword KW_tipo %s\n", yytext);
    return TOK_TIPO;
}
{ER_KW_tupla} {
    printf("keyword KW_tupla %s\n", yytext);
    return TOK_TUPLA;
}
{ER_KW_var} {
    printf("keyword KW_var %s\n", yytext);
    return TOK_VAR;
}
{ER_KW_y} {
    printf("keyword KW_y %s\n", yytext);
    return TOK_Y;
}

{ER_OP_comp_sec} {
    printf("operator OP_comp_sec %s\n", yytext);
    return TOK_PCOMA;
}
{ER_OP_igual} {
    printf("operator OP_igual %s\n", yytext);
    yylval.para_entero = D_IGUAL;
    return TOK_IGUAL;
}
{ER_OP_asignacion} {
    printf("operator OP_asignacion %s\n", yytext);
    return TOK_ASIGNACION;
}
{ER_OP_tipado} {
    printf("operator OP_tipado %s\n", yytext);
    return TOK_DOSP;
}
{ER_OP_separador} {
    printf("operator OP_separador %s\n", yytext);
    return TOK_COMA;
}
{ER_OP_subrango} {
    printf("operator OP_subrango %s\n", yytext);
    return TOK_SUBRANGO;
}
{ER_OP_entonces} {
    printf("operator OP_entonces %s\n", yytext);
    return TOK_ENTONCES;
}
{ER_OP_si_no_si} {
    printf("operator OP_si_no_si %s\n", yytext);
    return TOK_SINO;
}
{ER_OP_array_inicio} {
    printf("operator OP_array_inicio %s\n", yytext);
    return TOK_ABCORCH;
}
{ER_OP_array_fin} {
    printf("operator OP_array_fin %s\n", yytext);
    return TOK_CERCORCH;
}
{ER_OP_suma} {
    printf("operator OP_suma %s\n", yytext);
    return TOK_SUMA;
}
{ER_OP_resta} {
    printf("operator OP_resta %s\n", yytext);
    return TOK_RESTA;
}
{ER_OP_multiplicacion} {
    printf("operator OP_multiplicacion %s\n", yytext);
    return TOK_MULT;
}
{ER_OP_division} {
    printf("operator OP_division %s\n", yytext);
    return TOK_DIV;    
}
{ER_OP_mayor} {
    printf("operator OP_mayor %s\n", yytext);
    yylval.para_entero = D_MAYOR;
    return TOK_OPREL;
}
{ER_OP_menor} {
    printf("operator OP_menor %s\n", yytext);
    yylval.para_entero = D_MENOR;
    return TOK_OPREL;
}
{ER_OP_mayor_o_igual} {
    printf("operator OP_mayor_o_igual %s\n", yytext);
    yylval.para_entero = D_MAOI;
    return TOK_OPREL;
}
{ER_OP_menor_o_igual} {
    printf("operator OP_menor_o_igual %s\n", yytext);
    yylval.para_entero = D_MEOI;
    return TOK_OPREL;
}

{ER_literal_entero} {
    //yylval.para_valor.val.entero = atoi(yytext);
    printf( "literal_entero: %s (%d)\n", yytext, atoi( yytext ) );
    return TOK_LITERALNUMERICO;
}
{ER_literal_real} {
    //yylval.para_valor.val.real = atof(yytext);
    printf( "literal_real: %s (%g)\n", yytext, atof( yytext ) );
    return TOK_LITERALNUMERICO;
}
{ER_literal_verdadero} {
    printf( "literal_verdadero: %s\n", yytext);
    return TOK_VERDADERO;
}
{ER_literal_falso} {
    printf( "literal_falso: %s\n", yytext);
    return TOK_FALSO;
}
{ER_literal_caracter} {
    printf( "literal_caracter: %s\n", yytext);
    return TOK_LITERALCARACTER;
}
{ER_literal_cadena} {
    printf( "literal_cadena: %s\n", yytext);
    // ...
}

{ER_abpar} {
    return TOK_ABPAR;
}
{ER_cerpar} {
    return TOK_CERPAR;
}
{ER_special} {
    printf( "especial: %s\n", yytext);
}
{ER_white_space} {
    //printf( "white_space: %s\n", yytext);
}
{ER_comentario} {
    printf( "comment: %s\n", yytext);
    return TOK_COMENTARIO;
}
{ER_identificador} {
    yylval.para_cadenas = malloc(strlen(yytext));
    strncpy(yylval.para_cadenas, yytext, strlen(yytext));
    printf("identifier: %s\n", yylval.para_cadenas);
    return TOK_IDENTIFICADOR;
}
. {
    printf( "Unrecognized character: %s\n", yytext );
}
    
%%
