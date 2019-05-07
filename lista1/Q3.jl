push!(LOAD_PATH, "/Users/guilhermebodin/Documents/AnaliseDeRedes.jl/src")
using AnaliseDeRedes

admitancias = [
    1 2 -5.0im
    1 3 -2.0im
    2 3 -2.5im
]

cargas = [ #bus #g #b
    1 0 -5
    3 0 -4
]

idx_buses = [1;2;3]
Ybus = buildYbus(admitancias, idx_buses; cargas  = cargas)

using LinearAlgebra

Ybus = [
    0.0-12.0im   0.0+5.0im  0.0+2.0im
    0.0+5.0im   -0.0-7.5im  0.0+2.5im
    0.0+2.0im    0.0+2.5im  0.0-8.5im
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
L
U

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
z2
Icc = 1/z2[2]
Zbus*[0; -Icc; 0]

-0.515/0.2im
(0.592-0.515)/0.5im
2.575 - 0.154