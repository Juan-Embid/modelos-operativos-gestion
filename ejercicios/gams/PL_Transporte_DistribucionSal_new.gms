$title Problema de Transporte. Distribuciónd de Sal.

$onText
Hoja 1 problemas de MOG, curso 22-23
Modelización y resolución con GAMS.

La Comunidad de Madrid dispone de tres silos de sal para la conservación de carreteras en temporada invernal.
Ante la alerta de nieve y bajas temperaturas, la sal debe ser transportada a 9 localidades repartidas por la región y destinados
a proteger la red de carreteras de la región.

unidades: miles de toneladas de sal, distancia en kms
$offText

Sets
   silos de sal de la CAM / 1*3 /
   localidades de sal en la CAM / 1*9 /;

Parameters
   cap(silos) 'capacidad silos'
        /1  9
         2 10
         3 6 /
   dem(localidades) 'demanda localidades'
        /1 4
          2 3
          3 4
          4 3
          5 3
          6 2
          7 2
          8 2
          9 2/;

Table d(silos,localidades) 'distancia en Kms'
    1   2  3   4   5   6   7   8   9  
1  20  40 60  25  50  60  35  55  70 
2  55  35 15  65  40  20  70  45  40
3  65  60 65  35  40  35  20  15  20;

Scalar f 'coste de transporte en euros por km y unidad carga' / 10 /;

Parameters c(silos,localidades) 'coste de transporte uitario';
c(silos,localidades) = f*d(silos,localidades);

Variables
   cantidad(silos,localidades) 'miles de toneladas de sal desde el silo a la localidad'
   z      'coste total del transporte en euros';

Positive Variables cantidad(silos,localidades);

Equations
   coste      'función objetivo'
   suministro(silos) 'cantidad de sal envíada del silo'
   demanda(localidades) 'demanda de sal mandada a la localidad';

coste..      z =e= sum((silos,localidades), c(silos,localidades)*cantidad(silos,localidades));

suministro(silos).. sum(localidades, cantidad(silos,localidades)) =l= cap(silos);

demanda(localidades).. sum(silos, cantidad(silos,localidades)) =g= dem(localidades);


Model transporteSal / all /;

*OPTION LP=CPLEX;

*transporteSal.OPTFILE=1;


solve transporteSal using lp minimizing z;

*display cantidad.l, cantidad.m;
