%{
#include <stdio.h>
%}
cifra               [0-9]
letra               [A-Za-z]
letra_o_cifra       ({letra}|{cifra})
special             [\"()\{\}_\']
white_space         [ \t]
identificador       {letra}{letra_o_cifra}*
exponente           (e|E){cifra}+
literal_entero      {cifra}+{exponente}?
literal_real        {cifra}+\.{cifra}+{exponente}?
literal_booleano    ((?i:verdadero)|(?i:falso))
literal_caracter    \"[^\"]*\"
literal_cadena      \'([^']|\/\')*\'
comentario          \{([^\}]|\/\}|letra_o_cifra)*\}
OP_comp_sec         ;
OP_igual            =
OP_asignacion       \:=
OP_tipado           \:
OP_separador        \,
OP_subrango         \.\.
OP_entonces         \-\>
OP_si_no_si         \[\]
OP_array_inicio     \[
OP_array_fin        \]
OP_suma             \+
OP_resta            \-
OP_multiplicacion   \*
OP_division         \/
OP_rel              \>|\<|\>=|\<=
KW_accion           (?i:accion)
KW_algoritmo        (?i:algoritmo)
KW_booleano         (?i:booleano)
KW_cadena           (?i:cadena)
KW_caracter         (?i:caracter)
KW_const            (?i:const)
KW_continuar        (?i:continuar)
KW_de               (?i:de)
KW_dev              (?i:dev)
KW_div              (?i:div)
KW_ent              (?i:ent)
KW_entero           (?i:entero)
KW_es               (?i:e\/s)
KW_faccion          (?i:faccion)
KW_falgoritmo       (?i:falgoritmo)
KW_fconst           (?i:fconst)
KW_ffuncion         (?i:ffuncion)
KW_fmientras        (?i:fmientras)
KW_fpara            (?i:fpara)
KW_fsi              (?i:fsi)
KW_ftipo            (?i:ftipo)
KW_ftupla           (?i:ftupla)
KW_funcion          (?i:funcion)
KW_fvar             (?i:fvar)
KW_hacer            (?i:hacer)
KW_hasta            (?i:hasta)
KW_mientras         (?i:mientras)
KW_mod              (?i:mod)
KW_no               (?i:no)
KW_o                (?i:o)
KW_para             (?i:para)
KW_real             (?i:real)
KW_ref              (?i:ref)
KW_sal              (?i:sal)
KW_si               (?i:si)
KW_tabla            (?i:tabla)
KW_tipo             (?i:tipo)
KW_tupla            (?i:tupla)
KW_var              (?i:var)
KW_y                (?i:y)

%%
{KW_accion} {
    printf("keyword KW_accion %s\n", yytext);
}
{KW_algoritmo} {
    printf("keyword KW_algoritmo %s\n", yytext);
}
{KW_booleano} {
    printf("keyword KW_booleano %s\n", yytext);
}
{KW_cadena} {
    printf("keyword KW_cadena %s\n", yytext);
}
{KW_caracter} {
    printf("keyword KW_caracter %s\n", yytext);
}
{KW_const} {
    printf("keyword KW_const %s\n", yytext);
}
{KW_continuar} {
    printf("keyword KW_continuar %s\n", yytext);
}
{KW_de} {
    printf("keyword KW_de %s\n", yytext);
}
{KW_dev} {
    printf("keyword KW_dev %s\n", yytext);
}
{KW_div} {
    printf("keyword KW_div %s\n", yytext);
}
{KW_ent} {
    printf("keyword KW_ent %s\n", yytext);
}
{KW_entero} {
    printf("keyword KW_entero %s\n", yytext);
}
{KW_es} {
    printf("keyword KW_es %s\n", yytext);
}
{KW_faccion} {
    printf("keyword KW_faccion %s\n", yytext);
}
{KW_falgoritmo} {
    printf("keyword KW_falgoritmo %s\n", yytext);
}
{KW_fconst} {
    printf("keyword KW_fconst %s\n", yytext);
}
{KW_ffuncion} {
    printf("keyword KW_ffuncion %s\n", yytext);
}
{KW_fmientras} {
    printf("keyword KW_fmientras %s\n", yytext);
}
{KW_fpara} {
    printf("keyword KW_fpara %s\n", yytext);
}
{KW_fsi} {
    printf("keyword KW_fsi %s\n", yytext);
}
{KW_ftipo} {
    printf("keyword KW_ftipo %s\n", yytext);
}
{KW_ftupla} {
    printf("keyword KW_ftupla %s\n", yytext);
}
{KW_funcion} {
    printf("keyword KW_funcion %s\n", yytext);
}
{KW_fvar} {
    printf("keyword KW_fvar %s\n", yytext);
}
{KW_hacer} {
    printf("keyword KW_hacer %s\n", yytext);
}
{KW_hasta} {
    printf("keyword KW_hasta %s\n", yytext);
}
{KW_mientras} {
    printf("keyword KW_mientras %s\n", yytext);
}
{KW_mod} {
    printf("keyword KW_mod %s\n", yytext);
}
{KW_no} {
    printf("keyword KW_no %s\n", yytext);
}
{KW_o} {
    printf("keyword KW_o %s\n", yytext);
}
{KW_para} {
    printf("keyword KW_para %s\n", yytext);
}
{KW_real} {
    printf("keyword KW_real %s\n", yytext);
}
{KW_ref} {
    printf("keyword KW_ref %s\n", yytext);
}
{KW_sal} {
    printf("keyword KW_sal %s\n", yytext);
}
{KW_si} {
    printf("keyword KW_si %s\n", yytext);
}
{KW_tabla} {
    printf("keyword KW_tabla %s\n", yytext);
}
{KW_tipo} {
    printf("keyword KW_tipo %s\n", yytext);
}
{KW_tupla} {
    printf("keyword KW_tupla %s\n", yytext);
}
{KW_var} {
    printf("keyword KW_var %s\n", yytext);
}
{KW_y} {
    printf("keyword KW_y %s\n", yytext);
}

{OP_comp_sec} {
    printf("operator OP_comp_sec %s\n", yytext);
}
{OP_igual} {
    printf("operator OP_igual %s\n", yytext);
}
{OP_asignacion} {
    printf("operator OP_asignacion %s\n", yytext);
}
{OP_tipado} {
    printf("operator OP_tipado %s\n", yytext);
}
{OP_separador} {
    printf("operator OP_separador %s\n", yytext);
}
{OP_subrango} {
    printf("operator OP_subrango %s\n", yytext);
}
{OP_entonces} {
    printf("operator OP_entonces %s\n", yytext);
}
{OP_si_no_si} {
    printf("operator OP_si_no_si %s\n", yytext);
}
{OP_array_inicio} {
    printf("operator OP_array_inicio %s\n", yytext);
}
{OP_array_fin} {
    printf("operator OP_array_fin %s\n", yytext);
}
{OP_suma} {
    printf("operator OP_suma %s\n", yytext);
}
{OP_resta} {
    printf("operator OP_resta %s\n", yytext);
}
{OP_multiplicacion} {
    printf("operator OP_multiplicacion %s\n", yytext);
}
{OP_rel} {
    printf("operator OP_rel %s\n", yytext);
}

{literal_entero} {
     printf( "literal_entero: %s (%d)\n", yytext, atoi( yytext ) );
}
{literal_real} {
     printf( "literal_real: %s (%g)\n", yytext, atof( yytext ) );
}
{literal_booleano} {
     printf( "literal_booleano: %s\n", yytext);
}
{literal_caracter} {
     printf( "literal_caracter: %s\n", yytext);
}
{literal_cadena} {
     printf( "literal_cadena: %s\n", yytext);
}

{special} {
     printf( "especial: %s\n", yytext);
}
{white_space} {
     printf( "white_space: %s\n", yytext);
}
{comentario} {
     printf( "comment: %s\n", yytext);
}
{identificador} {
    printf( "identifier: %s\n", yytext);
}
. {
    printf( "Unrecognized character: %s\n", yytext );
}
     
%%
int main( int argc, char **argv ){
++argv, --argc;  /* skip over program name */
if ( argc > 0 )
     yyin = fopen( argv[0], "r" );
else
     yyin = stdin;

yylex();
}
