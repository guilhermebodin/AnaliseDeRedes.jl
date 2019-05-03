push!(LOAD_PATH, "/Users/guilhermebodin/Documents/AnaliseDeRedes.jl/src")
using AnaliseDeRedes

impedancias = [
    #busfr #busto #seqpos #seqneg #seqzero
    0 1 0.10im 0.10im 0.16im
    1 2 0.10im 0.10im 0.10im
    2 3 0.10im 0.10im 0.14im
    3 4 0.25im 0.25im Inf
    4 5 0.30im 0.30im 0.40im
    5 0 0.05im 0.05im Inf
]

admitancias, cargas = inputs(impedancias; sequencia = "zero")
admitancias
cargas

Ybus = buildYbus(admitancias, [1;2;3;4;5], cargas = cargas)
Zbus = smartZbus(Ybus)

Ia, Va = shortcircuit(impedancias, 1, [1;2;3;4;5], "c", 1)
Va
Ia