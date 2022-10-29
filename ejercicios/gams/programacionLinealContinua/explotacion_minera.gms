$title Problema de la Explotacion Minera

$onText
Problema de las diapositivas del tema 2 parte 1
$offText

Sets
    minerales tipos de carbon / lignito, antracita /
    recursos maquinaria utilizada / corte, tamizado, lavado /;

Parameters
    b(minerales) 'beneficio por la venta de una tonelada'
        / lignito   24
          antracita 18 /
    r(recursos) 'limite de recursos disponibles (horas maquina)'
        / corte    12
          tamizado 10
          lavado    8 /;
          
Table c(recursos, minerales) 'horas maquina consumidas por cada unidad de carbon'
        lignito antracita
corte       3       4
tamizado    3       3
lavado      4       2;

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