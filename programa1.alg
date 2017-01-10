algoritmo intercambio
	ent a, b: entero;
	sal a, b: entero;
{Prec: a= A AND b = B}
	var
		aux: entero;
		test: caracter;
	fvar
	aux:=a;
	a:=b;
	b:=aux;
	aux := a+a;
	aux := a+b;
	aux := a*b;
	aux := a/b;
	aux := a mod b;
	a := -b;
	a := -b;
{Post: b=A AND a = B}
falgoritmo
