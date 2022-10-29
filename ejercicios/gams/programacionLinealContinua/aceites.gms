sets aceites /'VEG1','VEG2','OIL1','OIL2','OIL3'/;

sets 
	vege(aceites) /'VEG1','VEG2'/
	mine(aceites) /'OIL1','OIL2','OIL3'/;

parameters
	coste(aceites) /
			VEG1 110
			VEG2 120
			OIL1 130
			OIL2 110
			OIL3 115/
	dureza(aceites) /VEG1 8.8, VEG2 6.1, OIL1 2.0, OIL2 4.2, OIL3 5.0/;
	
scalars
	dureza_min /3/
	dureza_max /6/
	precio_venta /150/
	refino_vege /200/
	refino_mine /250/;
	
display aceites,coste;

variables z, cantidad(aceites);
positive variables cantidad(aceites);
equations
	beneficio
	lim_refino_vegetal
	lim_refino_mineral
	lim_inf_dureza
	lim_sup_dureza;

beneficio.. z =e= precio_venta * sum(aceites,cantidad(aceites)) - sum(aceites, coste(aceites)*cantidad(aceites));
lim_refino_vegetal.. sum(vege(aceites),cantidad(aceites)) 
								=l= refino_vege;
lim_refino_mineral.. sum(mine(aceites),cantidad(aceites)) 
								=l= refino_mine;
lim_inf_dureza.. dureza_min * sum(aceites,cantidad(aceites)) 
								=l= sum(aceites,dureza(aceites)*cantidad(aceites));
lim_sup_dureza.. sum(aceites,dureza(aceites)*cantidad(aceites)) 
								=l= dureza_max * sum(aceites,cantidad(aceites));

model aceite /
	beneficio
	lim_refino_vegetal
	lim_refino_mineral
	lim_inf_dureza
	lim_sup_dureza
        /;


solve aceite using LP maximizing z;

*display cantidad.l;
