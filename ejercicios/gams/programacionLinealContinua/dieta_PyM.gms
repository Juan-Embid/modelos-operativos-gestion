$title Problema alimentar a 2000 familias.

$onText
Hoja 1. Modelización y resolución con GAMS.


Producción de patatas y maíz para dar alimento a 2000 familias.

Unidades: kilos
$offText


Variables
   patata  'kilos de patata producidos'
   maiz  'kilos de maíz producidos'
   z      'coste producción';

Positive Variables patata, maiz;

Equations obj,min_fam,min_p,min_m;
 
obj..      z =e= 3*patata+2*maiz;
min_fam..  4*patata+3*maiz =g= 2000;
min_p..    patata =g= 200;
min_m..    maiz =g= 100;

Model ProdPyM / all /;

OPTION LP=CPLEX;

ProdPyM.OPTFILE=1;

solve ProdPyM using lp minimizing z;


