push!(LOAD_PATH, "/home/guilhermebodin/Documents/ELE2504/AnaliseDeRedes.jl/src")
using AnaliseDeRedes

Ea = 1
Eb = -0.5 + 0.866im
Ec = -0.5 - 0.866im
E = [Ea;Eb;Ec]

SEQ2PHASE*E

zg = 0.1im
zp = 0.3im
zm = 0.1im
zc = 5im

Zbuslinhas = [
    zp zm zm
    zm zp zm
    zm zm zp
]

Zbuscarga = [
    zc 0 0
    0 zc 0
    0 0 zc
]

Zbusgeradores = [
    zg 0 0
    0 zg 0
    0 0 zg
]

Z = Zbuscarga + Zbusgeradores + Zbuslinhas

I = Z\E

V1 = E - Zbusgeradores*I
V2 = Zbuscarga*I

PHASE2SEQ*V1
PHASE2SEQ*V2


Z012 = SEQ2PHASE*Z*SEQ2PHASE
E012 = SEQ2PHASE*E

I012 = Z012\E012

