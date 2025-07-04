# modelo.mod

# 1. Definición de conjuntos y parámetros (vacíos, se llenan al leer datos)
set NODES ;
param u ;
param h{NODES} ;
param f{NODES} ;
param d{NODES, NODES} ;
param p ;

# 2. Variables binarias
var x{j in NODES} binary ;
var y{i in NODES, j in NODES} binary ;

# 3. Función objetivo
minimize TotalCost:
    sum{i in NODES, j in NODES}
       h[i] * u * d[i,j] * y[i,j]
    + sum{j in NODES}
       f[j] * x[j] ;

# 4. Restricciones

# 4.1 Cobertura: cada demanda i debe asignarse a un solo CD
subject to Cover{i in NODES}:
    sum{j in NODES} y[i,j] = 1 ;

# 4.2 Asignación condicionada: sólo a CDs abiertos
subject to Assign{i in NODES, j in NODES}:
    y[i,j] <= x[j] ;

# 4.3 Límite de centros: a lo más p CDs
subject to Limit:
    sum{j in NODES} x[j] <= p ;
