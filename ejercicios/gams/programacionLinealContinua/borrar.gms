Parameters
    coste_f/59/
    coste_m/63/
    coste_a/73/
    dias_f/20/
    dias_m/23/
    dias_a/22/
    lim_f/3800/
    lim_m/3500/
    lim_a/4400/;

Scalar
    beneficio /73/
    coste_inventario/4/
    lim_inventario/1100/
    inventario_enero/110/
    prod_dia/160/
    min_inventario_abril/120/;

Variables
    xf
    xm
    xa
    vf
    vm
    va
    ifebre
    im
    ia
    z;
Positive variables xf, xm, xa, vf, vm, va, ifebre, im, ia;

Equations
    lim_vf
    lim_vm
    lim_va
    lim_xf
    lim_xm
    lim_xa
    eq_if
    eq_im
    eq_ia
    lim_if
    lim_im
    lim_ia
    min_ia
    objetivo;

lim_vf..        vf =l= lim_f;
lim_vm..        vm =l= lim_m;
lim_va..        va =l= lim_a;
lim_xf..        xf =l= dias_f * prod_dia;
lim_xm..        xm =l= dias_m * prod_dia;
lim_xa..        xa =l= dias_a * prod_dia;
eq_if..         ifebre =e= inventario_enero + xf - vf;
eq_im..         im =e= ifebre + xm - vm;
eq_ia..         ia =e= im + xa - va;
lim_if..        ifebre =l= lim_inventario;
lim_im..        im =l= lim_inventario;
lim_ia..        ia =l= lim_inventario;
min_ia..        ia =g= min_inventario_abril;
objetivo..      z =e= beneficio * (vf + vm + va) - (coste_f* xf + coste_m * xm + coste_a * xa) - coste_inventario * (ifebre + im + ia);

Model borrar /all/;

OPTION LP=CPLEX;
borrar.OPTFILE=1;

solve borrar using lp maximizing z;