$title Problema de la explotación minera (Borrell)

$onText
Hoja 1 problemas de MOG.
Modelización y resolución con GAMS.

Una empresa minera produce lignito y antracita. Fases del proceso: corte, tamizado y selección.

unidades: toneladas de  mineral, diponibilidad (horas) máquinas en cada fase.
$offText

Sets
   minerales tipos de carbon / lignito, antracita /
   recursos maquinaria utilizada / corte,tamizado,lavado /;

Parameters
   b(minerales) 'beneficio por la venta de una tonelada'
        /lignito   24
         antracita 18/
   r(recursos) 'limite de recursos disponibles (horas maquina)'
        /corte  12
         tamizado 10
         lavado 8/;

Table c(recursos,minerales) 'horas maquina consumidas por cada unidad de carbon'
           lignito  antracita   
corte         3        4
tamizado      3        3
lavado        4        2;


Variables
   cantidad(minerales) 'toneladas producidas de cada mineral'
   be      'beneficio obtenido';

Positive Variables cantidad;

Equations
   benef      'calculo del beneficio'
   consumo(recursos) 'limite en el uso de cada recurso';
  

benef..      be =e= sum(minerales, b(minerales)*cantidad(minerales));

consumo(recursos).. sum(minerales, c(recursos,minerales)*cantidad(minerales)) =l= r(recursos);

Model ExpMinera / all /;

solve ExpMinera using lp maximizing be;

display cantidad.l, cantidad.m;
