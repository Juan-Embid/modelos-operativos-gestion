$title Problema de distribución de mercancias desde Africa hasta Europa
$onText
Hoja 3 problemas de MOG.
Dualidad y Análisis de Sensibilidad con GAMS.

Una compañía tiene cuatro factorías en el norte de
Marruecos que fabrican el mismo producto. Para su distribución en
Europa, la compañía cuenta con tres centros de distribución, en
Zaragoza, Lyon y Burdeos. Para realizar el transporte, la compañía
puede llevar la mercancía desde las cuatro factorías hasta tres
puertos situados en el norte de Africa. Una vez cargada la mercancía
en un puerto, puede trasladarse por vía marítima hasta los puertos
de Barcelona o Génova y, desde el puerto de llegada, transportarlo
por carretera a los centros de distribución.

unidades: toneladas
$offText

Sets
   puertos_A africanos / 1*3 /
   puertos_EU europeos / PB,PG /
   fabricas_A 'fábricas africanas' /1*4/
   centros_EU centros europeos /Z,B,L/;

Parameters
   cap_max_A(puertos_A) 'capacidad de carga en los puertos africanos'
        /1 2000
         2 2500
         3 3000/
   cap_max_EU(puertos_EU) 'capacidad de descarga en los puertos europeos'
        /PB 3500
         PG 4500/
   produc(fabricas_A) 'producción en las fábricas africanas'
        /1 1000
         2 2000 
         3 3000
         4 1000/     
   dem(centros_EU) 'demanda en los centros europeos'
        /Z 1000
         B 2000 
         L 4000/;

Table ctr_a(fabricas_A,puertos_A) 'coste rutas terrestres africanas'
    1   2  3    
1   9   8  2   
2   6   6  9  
3   9   7  7
4   6   6  8;

Table ctr_m(puertos_A,puertos_EU) 'coste rutas marítimas'
    PB  PG     
1    5   3
2    3   5
3    5   8;

Table ctr_eu(puertos_EU,centros_EU) 'coste rutas terrestres europeas'
     Z  B  L    
PB   5  7  9
PG   9  6  3;  


Variables
   ruta_tA(fabricas_A,puertos_A) 'toneladas desde cada fábrica africana a cada puerto africano'
   ruta_m(puertos_A,puertos_EU) 'toneladas desde cada puerto africano a cada puerto europeo'
   ruta_tEU(puertos_EU,centros_EU) 'toneladas desde cada puerto europeo a cada centro europeo'
   z      'coste total de la distribución de mercancías';

Positive Variables ruta_tA(fabricas_A,puertos_A),ruta_m(puertos_A,puertos_EU),ruta_tEU;

Equations
   coste      'función objetivo'
   suministro(fabricas_A) 'mercancías enviadas desde cada fábrica en Africa'
   demanda(centros_EU) 'demanda de mercancía en cada centro de Europa'
   capacidad_PA(puertos_A) 'límite de capacida máxima de carga en los puertos africanos'
   capacidad_PEU(puertos_EU) 'límite de capacida máxima de descarga en los puertos europeos'
   balance_PA(puertos_A) 'conservación del flujo de mercancías en los puertos africanos'
   balance_PEU(puertos_EU) 'conservación del flujo de mercancías en los puertos europeos';

coste..      z =e= sum((fabricas_A,puertos_A), ctr_a(fabricas_A,puertos_A)*ruta_tA(fabricas_A,puertos_A))+
                   sum((puertos_A,puertos_EU), ctr_m(puertos_A,puertos_EU)*ruta_m(puertos_A,puertos_EU))+
                   sum((puertos_EU,centros_EU), ctr_eu(puertos_EU,centros_EU)*ruta_tEU(puertos_EU,centros_EU));

suministro(fabricas_A).. sum(puertos_A, ruta_tA(fabricas_A,puertos_A)) =l= produc(fabricas_A);
demanda(centros_EU)..    sum(puertos_EU, ruta_tEU(puertos_EU,centros_EU)) =g= dem(centros_EU);

capacidad_PA(puertos_A).. sum(fabricas_A,ruta_tA(fabricas_A,puertos_A))=l=cap_max_A(puertos_A);
capacidad_PEU(puertos_EU).. sum(centros_EU,ruta_tEU(puertos_EU,centros_EU))=l=cap_max_EU(puertos_EU);

balance_PA(puertos_A)..    sum(fabricas_A,ruta_tA(fabricas_A,puertos_A))=e=sum(puertos_EU,ruta_m(puertos_A,puertos_EU));
balance_PEU(puertos_EU)..  sum(puertos_A,ruta_m(puertos_A,puertos_EU))=e=sum(centros_EU,ruta_tEU(puertos_EU,centros_EU));


Model TransMerc / all /;

OPTION LP=CPLEX;

TransMerc.OPTFILE=1;

solve TransMerc using lp minimizing z;

