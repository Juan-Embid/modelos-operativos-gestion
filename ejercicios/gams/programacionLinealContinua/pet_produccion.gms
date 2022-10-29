Variables
    botella 'toneladas de PET-botella'
    fibra   'toneladas de PET-fibra'
    z       'beneficio total obtenido'
    
Positive Variables botella, fibra;
    
Equations obj, PTA, EtG;

    obj..   z =e= 36*botella+30*fibra;
    PTA..   0.966*botella+0.912*fibra =l= 260;
    EtG..   0.365*botella+0.344*fibra =l= 150;
    
Model PetBF /all/;

OPTION LP=CPLEX;

PetBF.OPTFILE=1;

solve PetBF using lp maximizing z;