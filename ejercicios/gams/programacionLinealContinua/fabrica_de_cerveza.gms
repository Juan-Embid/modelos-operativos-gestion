$title Problema de la Fabrica de Cerveza

$onText
Problema de las diapositivas del tema 2 parte 1
$offText

Variables
   rubia litros de cerveza rubia en miles
   negra litros de cerveza negra en miles
   max maximo beneficio;

Positive Variables rubia, negra;

Equations
   beneficio      'función objetivo',
   empleados 'cantidad de empleados trabajando',
   presupuesto 'presupuesto con el que trabajan';
   
beneficio.. max =e= 100*rubia + 125*negra;

empleados.. 3*rubia + 5*negra =l= 15;

presupuesto.. 90*rubia + 85*negra =l= 350;

Model cerveza / all /;

*OPTION LP=CPLEX;

solve cerveza using lp maximizing max;

*display rubia, morena;