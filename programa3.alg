algoritmo sumacomb
    ent n, m, a: entero;
    sal suma: entero;
{Prec: n= N AND m = M AND M >= N >0}
    var
        i, comb: entero;
    fvar
    i:= a;
    suma:= a;
    comb:= m;
    mientras i < n hacer
        suma := suma + comb;
        comb := comb * (m - i - a) div (i + a);
        i := i+a
    fmientras;
{Post: n =N AND suma = SUMATORIO(i=1..N)(M sobre i)}
falgoritmo
