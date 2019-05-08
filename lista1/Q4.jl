push!(LOAD_PATH, "/home/guilhermebodin/Documents/ELE2504/AnaliseDeRedes.jl/src")
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

# item e
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
Zbuspos = naiveZbus(Ybus)

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
Zbuszero = naiveZbus(Ybus)

V2 = 0 .+ Zbuspos[:, 3]*-icc
V1 = 1 .+ Zbuspos[:, 3]*-icc
V0 = 0 .+ [Zbuszero[:, 3];0]*-icc

deltav_a = -(Zbuspos[:, 3]*icc+Zbuspos[:, 3]*icc+[Zbuszero[:, 3];0]*icc)

deltav_b = -((ANG^2)*Zbuspos[:, 3]*icc+(ANG)*Zbuspos[:, 3]*icc+[Zbuszero[:, 3];0]*icc)

Vseq = [V0 V1 V2]
Vfase = Array{Complex, 2}(undef, 5, 3)
for i = 1:5
    Vfase[i, :] = SEQ2PHASE*Vseq[i, :]
end
Vfase

Zzero = [[Zbuszero[i, i] for i = 1:4]; 10^7]
Zpos = [Zbuspos[i, i] for i = 1:5]
Zneg = [Zbuspos[i, i] for i = 1:5]


I0 = -V0./Zzero
I1 = -(V1 .- 1)./Zpos
I2 = -V2./Zneg
Iseq = [I0 I1 I2]
Ifase = Array{Complex, 2}(undef, 5, 3)
for i = 1:5
    Ifase[i, :] = SEQ2PHASE*Iseq[i, :]
end
I0
I1
I2
Ifase[:, 1]
Ifase[:, 2]
Ifase[:, 3]