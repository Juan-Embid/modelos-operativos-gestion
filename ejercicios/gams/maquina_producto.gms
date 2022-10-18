$title Problema 3 de la hoja 3

Sets
   productos tipos distintos / 'A', 'B', 'C' /
   maquinas tipos de maquinas / 'M1', 'M2' /;

Table tiempos(productos,maquinas) 'tiempo de consumicion en horas por kilo'
    1   2
1   2   2
2   2   1
3   1   3;

Parameters
   beneficio_producto(producto) 'beneficio por producto'
        /A 9000
         B 8000
         C 6000/
         
   tiempo(maquina) 'tiempo por maquina'
        /M1 36
         M2 48/;

Variables
   z      'beneficio total de la compañia';

Positive Variables tiempos(productos,maquinas);

Equations
   beneficio      'función objetivo'
   suministro(silos) 'cantidad de sal envíada del silo'
   demanda(localidades) 'demanda de sal mandada a la localidad';

beneficio..      z =e= sum((silos,localidades), c(silos,localidades)*cantidad(silos,localidades));

suministro(silos).. sum(localidades, cantidad(silos,localidades)) =l= cap(silos);

demanda(localidades).. sum(silos, cantidad(silos,localidades)) =g= dem(localidades);


Model problema3 / all /;

OPTION LP=CPLEX;

problema3.OPTFILE=1;


solve problema3 using lp maximizing z;

*display cantidad.l, cantidad.m;
