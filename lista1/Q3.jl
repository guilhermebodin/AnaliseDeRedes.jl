push!(LOAD_PATH, "/Users/guilhermebodin/Documents/AnaliseDeRedes.jl/src")
using AnaliseDeRedes

admitancias = [
    1 2 0.2im
    1 3 0.5im
    2 3 0.4im
]

cargas = [ #bus #g #b
    1 0 0.2
    3 0 0.25
]

idx_buses = [1;2;3]
Ybus = buildYbus(admitancias, idx_buses; cargas  = cargas)

using LinearAlgebra

Ybus = [
    0.0+0.9im  -0.0-0.2im  -0.0-0.5im
    -0.0-0.2im  -0.0+0.6im  -0.0-0.4im
    -0.0-0.5im  -0.0-0.4im   0.0+1.15im
]

L, U = lu(Ybus)

c1 = L\[1; 0; 0]
z1 = U\c1
# segunda coluna
c2 = L\[0; 1; 0]
z2 = U\c2
# terceira coluna
c3 = L\[0; 0; 1]
z3 = U\c3
# Zbus completa
Zbus = [z1 z2 z3]

A = [
 1 0 3
 2 1 3
 4 1 2
]

E21 = [
    1 0 0
    -2 1 0
    0 0 1
]

E31 = [
    1 0 0
    0 1 0
    -4 0 1
]

E32 = [
    1 0 0
    0 1 0
    0 -1 1
]

B = E32*E31*E21
inv(B)

lu(A)


# item b
I = Ybus*[0 ; 1; 0]
