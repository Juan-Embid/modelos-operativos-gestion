$title Problema de la Mezcla de Aceites

$onText
Problema de las diapositivas del tema 2 parte 1
$offText

Sets
    aceites / 'VEG1','VEG2','OIL1','OIL2','OIL3' /
    vege(aceites) aceites vegetales / 'VEG1','VEG2' /
    mine(aceites) aceites minerales / 'OIL1','OIL2','OIL3' /;

Parameters
    coste(aceites) coste de cada aceite
        / VEG1 110
          VEG2 120
          OIL1 130
          OIL2 110
          OIL3 115 /
          
*porque se separa con comas y no como el coste(aceites)
    dureza(aceites) dureza de cada aceite
        / VEG1 8.8, VEG2 6.1, OIL1 2.0, OIL2 4.2, OIL3 5.0 /;
          
Scalars
    dureza_min dureza minima aceite / 3 /
    dureza_max dureza maxima aceite / 6 /
    precio_venta precio de venta del aceite / 150 /
    refino_vege max Tn aceite vegetal / 200 /
    refino_mine max Tn aceite mineral / 250 /;
    

Variables
    cantidad(minerales) 'toneladas producidas de cada mineral'
    be 'beneficio obtenido'
    
Positive Variables cantidad;

Equations
    benef 'calculo del beneficio'
    consumo(recursos) 'limite en el uso de cada recurso';
   
* de que manera se usa el sum, porque lo multiplica a cantidad(minerales)
benef.. be =e= sum(minerales, b(minerales)*cantidad(minerales));
* porque pone el =l= en el lado derecho
consumo(recursos).. sum(minerales, c(recursos, minerales)*cantidad(minerales)) =l= r(recursos);

Model ExpMinera / all /;

*OPTION LP=CPLEX;

* porque maximizig be
solve ExpMinera using lp maximizing be;

*display rubia, morena;