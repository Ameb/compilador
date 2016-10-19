%{
#include <stdio.h>
%}


cifra               [0-9]
letra               [A-Za-z]
letra_o_cifra       ({letra}|{cifra})
special             [\"()\{\}_\']
white_space         [ \t]
identificador       {letra}{letra_o_cifra}*
literal_entero      (\+|-)?{cifra}+(e|E){cifra}+
literal_real        (\+-)?{cifra}+\.{cifra}+?(e|E){cifra}+
literal_booleano    ((?i:verdadero)|(?i:falso))
literal_caracter    \"[^\"]*\"
literal_cadena      \'([^']|\/\')*\'
comentario          \{([^\}]|\/\}|letra_o_cifra)*\}
OP_creacion_tipo    =
OP_asignacion       \:\=
OP_tipado           \:
OP_separador        \,
OP_subrango         \.\.
OP_entonces         \-\>
OP_si_no_si         \[\]
OP_array_inicio     \[
OP_array_fin        \]
OP_suma             +
OP_resta            -
OP_multiplicacion   *
OP_division         /
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
    printf("Has leido el keyword %s\n", yytext);
}
{KW_algoritmo} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_booleano} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_cadena} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_caracter} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_const} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_continuar} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_de} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_dev} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_div} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_ent} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_entero} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_es} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_faccion} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_falgoritmo} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_fconst} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_ffuncion} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_fmientras} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_fpara} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_fsi} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_ftipo} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_ftupla} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_funcion} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_fvar} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_hacer} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_hasta} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_mientras} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_mod} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_no} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_o} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_para} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_real} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_ref} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_sal} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_si} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_tabla} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_tipo} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_tupla} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_var} {
    printf("Has leido el keyword %s\n", yytext);
}
{KW_y} {
    printf("Has leido el keyword %s\n", yytext);
}

{OP_creacion_tipo} {
    printf("Has leido el operador %s\n", yytext);
}
{OP_asignacion} {
    printf("Has leido el operador %s\n", yytext);
}
{OP_tipado} {
    printf("Has leido el operador %s\n", yytext);
}
{OP_separador} {
    printf("Has leido el operador %s\n", yytext);
}
{OP_subrango} {
    printf("Has leido el operador %s\n", yytext);
}
{OP_entonces} {
    printf("Has leido el operador %s\n", yytext);
}
{OP_si_no_si} {
    printf("Has leido el operador %s\n", yytext);
}
{OP_array_inicio} {
    printf("Has leido el operador %s\n", yytext);
}
{OP_array_fin} {
    printf("Has leido el operador %s\n", yytext);
    }

{cifra}+ {
     printf( "An integer: %s (%d)\n", yytext,
             atoi( yytext ) );
     }

{literal_entero} {
     printf( "A literal_entero: %s (%g)\n", yytext,
             atof( yytext ) );
     }

{literal_real} {
     printf( "A literal_real: %s (%g)\n", yytext,
             atof( yytext ) );
     }

{literal_booleano} {
     printf( "A literal_booleano: %s (%g)\n", yytext,
             atof( yytext ) );
     }

{literal_caracter} {
     printf( "A literal_caracter: %s (%g)\n", yytext,
             atof( yytext ) );
     }

{literal_cadena} {
     printf( "A literal_cadena: %s (%g)\n", yytext,
             atof( yytext ) );
     }

{special} {
     printf( "A special: %s (%g)\n", yytext,
             atof( yytext ) );
     }

{white_space} {
     printf( "A white_space: %s (%g)\n", yytext,
             atof( yytext ) );
     }

{comentario} {
     printf( "A comentario: %s (%g)\n", yytext,
             atof( yytext ) );
     }

{identificador} {
    printf( "An identifier: %s\n", yytext );
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
