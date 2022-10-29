$title Problema de la Residuos Contaminantes
$onText
Problema evaluable
$offText

Sets
    fabricas distintas fabricas / F1, F2, F3 /
    residuos residuos contaminantes / C1, C2 /;

Parameters
    c(fabricas) 'coste en euros por tonelada'
        / F1 10
          F2 15
          F3 16/;
          
Table t(fabricas, residuos) 'reducción de emisión de contaminantes'
        C1         C2
F1     0.54       0.49
F2     0.43       0.18
F3     0.37       0.51;

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

OPTION LP=CPLEX;

ExpMinera.OPTFILE=1;

* porque maximizig be
solve ExpMinera using lp maximizing be;

*display rubia, morena;