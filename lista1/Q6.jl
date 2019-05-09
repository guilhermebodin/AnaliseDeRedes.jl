push!(LOAD_PATH, "/home/guilhermebodin/Documents/ELE2504/AnaliseDeRedes.jl/src")
using AnaliseDeRedes

Ea = 1
Eb = -0.5 + (sqrt(3)/2)im
Ec = -0.5 - (sqrt(3)/2)im
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
Zbuslinhas*I + V2
V1
V2 = Zbuscarga*I

PHASE2SEQ*V1
PHASE2SEQ*V2


Z012 = SEQ2PHASE*Zbuscarga*PHASE2SEQ + SEQ2PHASE*Zbusgeradores*PHASE2SEQ + SEQ2PHASE*Zbuslinhas*PHASE2SEQ
Z012 = SEQ2PHASE*Z*PHASE2SEQ
E012 = PHASE2SEQ*E

I012 = Z012\E012
Z012geradores = SEQ2PHASE*Zbusgeradores*PHASE2SEQ
Z012carga = SEQ2PHASE*Zbuscarga*PHASE2SEQ

V2012 = Z012carga*I012
V1012 = E012 - Z012geradores*I012

#item c
zg = 0.1im
zp = 0.3im
zm = 0.1im
zc = 0

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
Zbuslinhas*I + V2
V1
V2 = Zbuscarga*I

PHASE2SEQ*V1
PHASE2SEQ*V2

Z012 = SEQ2PHASE*Zbuscarga*PHASE2SEQ + SEQ2PHASE*Zbusgeradores*PHASE2SEQ + SEQ2PHASE*Zbuslinhas*PHASE2SEQ
Z012 = SEQ2PHASE*Z*PHASE2SEQ
E012 = PHASE2SEQ*E

I012 = Z012\E012
Z012geradores = SEQ2PHASE*Zbusgeradores*PHASE2SEQ
Z012carga = SEQ2PHASE*Zbuscarga*PHASE2SEQ

V2012 = Z012carga*I012
V1012 = E012 - Z012geradores*I012