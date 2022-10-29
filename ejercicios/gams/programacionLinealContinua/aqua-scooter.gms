
$title Problema de la Empresa de Aqua Scooter
$onText
 Problema evaluable

 La empresa Aqua-Scooter se dedica al montaje de motos naúticas de 125 cv y de 50 cv en versiones monoplaza y biplaza.
 Posee una planta que está estructurada en cuatro departamentos: fabricación de motor, pintura, montaje y el departamento
 de control de calidad. Las horas de mano de obra que necesita cada uno de los modelos de moto en los diferentes
 departamentos son los siguientes:

 Modelo  Motor   Pintura Montaje C. Calidad
 125-bi  6   9   12  5
 125-m   4   8   10  4
 50-bi   2   5   8   2
 50-m    1   4   7   1
 El departamento de fabricaciónn de motor dispone de 17 trabajadores, el de pintura de 19, el de montaje de 8 y el
 control de calidad, de 16. Todos los trabajadores realizan una jornada laboral de 8 horas.

 Si el margen de beneficio de cada uno de los modelos es de 1070, 920, 860 y 650 euros, respectivamente, crear un modelo
 de optimización lineal que permita encontrar la combinación de motos naúticas a producir para el que el beneficio sea máximo.
$offText

 Sets
     moto modelos de las motos nauticas / 125bi, 125m, 50bi, 50m /
     departamentos planta estructurada en 4 departamentos / motor, pintura, montaje, calidad /;

 Table h(moto, departamentos) 'horas de mano de obra que necesita cada modelo en los distintos departamentos'
         motor pintura montaje calidad
 125bi    6      9       12      5
 125m     4      8       10      4
 50bi     2      5       8       2
 50m      1      4       7       1;

 Parameters
     t(departamentos) 'trabajadores por departamento'
         / motor   17
           pintura 19
           montaje 8
           calidad 16/
           
     b(moto) 'beneficio de cada uno de los modelos'
         / 125bi 1070
           125m  920
           50bi  860
           50m   650/;

 Variables
     cantidad(moto) 'motos producidas de cada modelo'
     be 'beneficio obtenido'
     
 Positive Variables cantidad;

 Equations
     benef 'calculo del beneficio'
     manoObra(departamentos) 'limite en el uso de cada recurso';
    
 benef.. be =e= sum(moto, b(moto)*cantidad(moto));
 manoObra(departamentos).. sum(moto, h(moto, departamentos)*cantidad(moto)) =l= t(departamentos) * 8;

 Model aquaScooter / all /;

 OPTION LP=CPLEX;

 aquaScooter.OPTFILE=1;

* porque maximizig be
 solve aquaScooter using lp maximizing be;
