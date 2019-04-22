push!(LOAD_PATH, "/home/guilhermebodin/Documents/ELE2504/AnaliseDeRedes.jl/src")
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

Zbus - naiveZbus(Ybus)