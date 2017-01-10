## Cómo compilar / probar el compilador
El makefile se encargará de realizar los comandos de compilación en el orden correcto. También utilizará los flags adecuados en caso de compilar en OS X.
```sh
$ make
```
Si se quiere hacer limpieza de los archivos que no son código fuente se puede realizar con
```sh
$ make clean
```

No le damos ningún nombre especial al ejecutable, por lo que es a.out
```sh
$ ./a.out ejemplo.alg
```
El ejemplo `ejemplo.alg` contiene una muestra de las expresiones que interpreta el compilador.

## Qué hace el compilador
El programa recibe como argumento el nombre de un archivo de texto que contiene el código de un programa ProAlg completo y correcto, de acuerdo a la especificación dada en el guión de prácticas. Puede haber algún pequeño cambio respecto a la gramática.
El programa imprimirá por pantalla información del escanner así como del parser conforme va leyendo el archivo fuente. Al finalizar la lectura imprimirá por pantalla los contenidos de la tabla de símbolos, los contenidos de la tabla de cuádruplas y la traducción de la tabla de cuádruplas en código intermedio.

### Sintaxis del lenguaje soportada por el compilador

En principio el scanner es capaz de reconocer todos los tokens del léxico del lenguaje
- Declaración de variables. No admite variables duplicadas, no distingue alcance ni diferencia entre variables de entrada y salida. Tipos básicos:
    - Real
    - Entero
    - Cadena*
    - Carácter*
    - Booleanas*
- Expresiones aritméticas y asignaciones: Asignación a variables de expresiones aritméticas entre otras variables del mismo tipo
- Expresiones booleanas: Sólo dentro de estructuras `alternativa` y `it_cota_exp` (if...then y while)
- Instrucciones de control de flujo comentadas anteriormente

#### Notas sobre la sintaxis

- No hemos interpretado los literales numéricos. Tampoco los booleanos. En los ejemplos he sustituido los literales por una variable `lit
- La ausencia de un separador de instrucciones `;` al final de una instrucción puede causar problemas. Hay lugares como después de un `fsi` o antes de `[]` que no resultan intuitivos
- Hemos intentado implementar asignaciones a variables a booleanas sin éxito.
- Se han modificado algunas gramáticas para simplificar u optimizar el funcionamiento del compilador.
