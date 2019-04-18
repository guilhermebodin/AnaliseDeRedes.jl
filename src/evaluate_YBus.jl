"""
ramos devem ser descritos como matrizes do tipo
ramos = [ #from #to #r #x
    1 2 0.01938 0.05917
    1 3 0.05403 0.22304
    2 3 0.04699 0.19797
]
"""
function evaladmitancias(ramos)
    impedancias = Array{Any, 2}(undef, size(ramos, 1), size(ramos, 2) - 1)
    impedancias[:, 1:2] = ramos[:, 1:2]
    impedancias[:, 3] = ramos[:, 3] .+ ramos[:, 4]im
    admitancias = [ramos[:, 1:2] impedancias[:, 3].^-1]
    return admitancias
end

"""
admitancias devem ser do tipo
admitanias = [#from #to #y
    1.0+0.0im  2.0+0.0im  4.99913-15.2631im
    1.0+0.0im  3.0+0.0im   1.0259-4.23498im
    2.0+0.0im  3.0+0.0im  1.13502-4.78186im
]
cargas devem ser do tipo :
cargas = [ #bus #g #b
    2 1.25 -0.50
    3 0.90 -0.30
]
"""
function buildYbus(admitancias, idx_buses; cargas = [])
    if cargas != []
        idx_cargas = Int.(cargas[:, 1])
    end
    fr, to = (Int.(admitancias[:, 1]), Int.(admitancias[:, 2]))
    nbuses = length(idx_buses)
    YBus = zeros(Complex, nbuses, nbuses)
    for j = 1:nbuses, i = 1:nbuses
        if idx_buses[i] == idx_buses[j]
            YBus[i, i] = 0
        else
            idx_ad = findfirst((idx_buses[i] .== fr) .& (idx_buses[j] .== to))
            if typeof(idx_ad) != Nothing
                YBus[i, j] = -admitancias[idx_ad, 3]
                YBus[j, i] = -admitancias[idx_ad, 3]
            end
        end
    end
    for i = 1:nbuses
        if cargas != []
            hascarga = findfirst(x -> x == i, idx_cargas)
        else
            hascarga = nothing
        end
        if typeof(hascarga) == Nothing
            YBus[i, i] = -sum(YBus[:, i])
        else
            idx_carga = findfirst(x -> x == i, idx_cargas)
            YBus[i, i] = -sum(YBus[:, i]) + cargas[idx_carga, 2] + cargas[idx_carga, 3]im
        end
    end
    return YBus
end