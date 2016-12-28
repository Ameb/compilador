# Procesadores del lenguaje

## Notas sobre la entrega
Cuerpo del mensaje: 
que hemos hecho y no hemos hecho
instrucciones para construir la aplicacion
caracteristicas
cosas extrañas

poner tambien los ejemplos
como os valorais -> porcentaje

Conviene llegar a booleanas.

## Notas sobre el codigo

27/12/2016:
* Hay que evitar que se genere código cuando el tipo es desconocido
* ~~Implementaciones en la tabla de cuádruplas pendientes:~~
	~~makelist, backpatch, merge~~
* Si creamos un cambiar_tipo en la tabla de simbolos podremos trabajar con tipos diferentes

28/12/2016
* ~~Tenemos algún puntero erróneo, segfault al terminar el programa.~~ El problema lo causa la busqueda de una variable por nombre en la TS, cuando la variable no está.
* Cambiada la gramática para incorporar M en las expresiones booleanas
* Cambiada la gramática para incorporar el token igual en las operaciones relacionales