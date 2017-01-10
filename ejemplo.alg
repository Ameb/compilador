algoritmo ejemplo
    ent a, b, c : entero;
    sal max, min, med: entero;
{Ejemplos orden3, sumacomb e intercambio}
    var
        m, i, suma, comb, n, lit: entero;
        r1, r2, aux: real;
    fvar
    si a >= b y a >= c ->
        max := a;
        si b >= c ->
            med := b;
            min := c;
        [] b <c ->
            med := c;
            min := b;
        fsi;
    [] b >= a y b >= c ->
        max := b;
        si a >= c ->
            med := a;
            min := c;
        [] a <c ->
            med := c; 
            min := a;
        fsi;
    [] c >= b y c >= a ->
        max := c;
        si b >= a ->
            med := b;
            min := a;
        [] b <a ->
            med := a;
            min := b;
        fsi;
    fsi;
    i:= lit;
    suma:= lit;
    comb:= m;
    mientras i < n hacer
        suma := suma + comb;
        comb := comb * (m - i - lit) div (i + lit);
        i := i+lit;
    fmientras;
    aux:= r1;
    r1:= r2;
    r2:= aux;
{Post: a=A AND b = B AND c= C ...}
falgoritmo
