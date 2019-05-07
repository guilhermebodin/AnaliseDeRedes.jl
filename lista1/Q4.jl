push!(LOAD_PATH, "/Users/guilhermebodin/Documents/AnaliseDeRedes.jl/src")
using AnaliseDeRedes

#item a
admitancias = [
    1 4 1/(0.05im)
    1 3 1/(0.1im)
    2 3 1/(0.1im)
    2 5 1/(0.05im)
    1 2 1/(0.1im)
]

cargas = [ #bus #g #b
    4 0 -5
    5 0 -5
]

idx_buses = [1;2;3;4;5]
Ybus = buildYbus(admitancias, idx_buses; cargas  = cargas)

Zbus = naiveZbus(Ybus)

admitancias = [
    1 4 1/(0.05im)
    1 3 1/(0.3im)
    2 3 1/(0.3im)
    1 2 1/(0.3im)
]

cargas = [ #bus #g #b
    4 0 -7.142857142857142
    2 0 -20
]

idx_buses = [1;2;3;4]
Ybus = buildYbus(admitancias, idx_buses; cargas  = cargas)

Zbus = naiveZbus(Ybus)

#item b
I012 = [0; 1/0.175im; 0]
IABC = SEQ2PHASE*I012

#item c
icc = 1/(2*0.175im + 0.198864im)
i012 = [icc;icc;icc]
iabc = SEQ2PHASE*i012

Zth = [0.198864im; 0.175im; 0.175im]
i012
vcc = [0; 1; 0]
v012 = vcc .- i012.*Zth
vabc = SEQ2PHASE*v012