algoritmo programa4
    ent a,b: entero;
    sal c,d: entero;
{Prec}
    a := c+d;
    b := a*(b+a);
    si a > b y c > b ->
        b := a;
    fsi;
    si a > b o c > b ->
        b := a;
    fsi;
{Post}
falgoritmo
