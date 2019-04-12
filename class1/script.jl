#aula 29/03/2019

push!(LOAD_PATH, "/Users/guilhermebodin/Documents/AnaliseDeRedes.jl/src")
using AnaliseDeRedes

ramos = [ #from #to #r #x
    1 2 0.01938 0.05917
    1 3 0.05403 0.22304
    2 3 0.04699 0.19797
]

cargas = [ #bus #g #b
    2 1.25 -0.50
    3 0.90 -0.30
]

Ybus = buildYbus(evaladmitancias(ramos), 3, cargas)
Zbus = naiveZbus(Ybus)
Zbus = smartZbus(Ybus)