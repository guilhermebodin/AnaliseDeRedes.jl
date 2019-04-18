push!(LOAD_PATH, "/home/guilhermebodin/Documents/ELE2504/AnaliseDeRedes.jl/src")
using AnaliseDeRedes

admitancias = [
    3 2 -4im
    3 1 -4im
    2 1 -8im
    2 4 -5im
    1 4 -2.5im
]

cargas = [ #bus #g #b
    3 0 -0.80
    4 0 -0.80
]

idx_buses = [1;2;3;4]
Ybus = buildYbus(admitancias, [1;2;3;4]; cargas  = cargas)

I = [
    0
    0
    -1im
    -0.4384 - 0.4384im
]

Zbus = smartZbus(Ybus)

V = Zbus*I