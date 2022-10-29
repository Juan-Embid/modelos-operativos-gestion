$title Problema de la Fabrica de Piensos

$onText
Problema evaluable ejercicio 2
$offText

Sets
    meses meses en los que se realizan pedidos / febrero, marzo, abril /;

Parameters
    p(meses) 'pedidos de cada mes'
         / febrero  3800
           marzo    3500
           abril    4400/
           
    d(meses) 'días de producción'
        /  febrero  20
           marzo    23
           abril    22/
           
    c(meses) 'coste de producción en cada mes'
        / febrero   59
          marzo     63
          abril     73/;

Scalar
    produccion 'capacidad de producción al día' / 160 /
    inventario_ene 'inventario a final de enero' / 110 /
    inventario_lim 'capacidad de inventario limite' / 1100 /
    inventario_abril_min 'minimo de inventario a mantener en el mes de abril' / 120 /
    coste_inventario 'coste de mantener el inventario' / 4 /
    limite_produccion(meses).. lim_produccion =l= d(meses) * produccion *TODO no poner esto dentro de las restricciones
    beneficio_venta 'ingreso neto por venta por cada tonelada' / 73 /;

Variables
    lim_ventas
    lim_produccion
    lim_inventario
    inventario_feb
    inventario_mar
    inventario_abr
    lim_abril
    z;
Positive variables lim_ventas, lim_produccion, inventario_feb, inventario_mar, inventario_abr;

Equations
    limite_ventas 'restricción del límite de ventas para cada mes',
    limite_produccion 'restricción de producción al día para cada mes',
    calc_inventario_feb 'calcula el inventario para final del mes de febrero',
    calc_inventario_mar 'calcula el inventario para final del mes de marzo',
    calc_inventario_abr 'calcula el inventario para final del mes de abril',
    limite_inventario 'restriccion del límite de inventario para cada mes',
    min_inventario_abril 'restriccion del límite de inventario para el final del mes de abril',
    objetivo;

limite_ventas..     lim_ventas =l= p(meses);
xcalc_inventario_feb..   inventario_feb =e= limite_produccion('febrero') + inventario_ene - limite_ventas(0);
calc_inventario_mar..   inventario_mar =e= limite_produccion(1) + inventario_feb - limite_ventas(1);
calc_inventario_abr..   inventario_abr =e= limite_produccion(2) + inventario_mar - limite_ventas(2);
limite_inventario..     lim_inventario =l= inventario_lim;
min_inventario_abril..  lim_abril   =g= inventario_abril_min;
*necesito saber como se suman todos los limites de ventas
objetivo..      z =e= beneficio_venta * limite_ventas - sum(meses, c(meses) * limite_produccion) - coste_inventario * (calc_inventario_feb + calc_inventario_mar + calc_inventario_abr);

Model fabrica_piensos /all/;

OPTION LP=CPLEX;
fabrica_piensos.OPTFILE=1;

solve fabrica_piensos using lp maximizing z;