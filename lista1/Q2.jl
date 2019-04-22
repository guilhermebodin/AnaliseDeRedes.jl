push!(LOAD_PATH, "/home/guilhermebodin/Documents/ELE2504/AnaliseDeRedes.jl/src")
using AnaliseDeRedes


L = [
    -6im 0 0
    5im -21.6333im 0
    0 20im -1.510038im
]

U = [
    1 -0.833333 0
    0 1 -0.924499
    0 0 1
]

# primeira coluna
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

Ybus = L * U
Zbus = naiveZbus(Ybus)
Zbus - smartZbus(Ybus)
Zbus - Zbus1

a = 1/1.2 + 1/1.25
1/a