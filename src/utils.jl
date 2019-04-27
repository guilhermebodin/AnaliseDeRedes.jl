"""
Resolve V = YBus*I (b = A*x)
"""
function eval_tensions(I, Ybus)
    return Ybus\I
end

"""
Recebe as IMPEDANCIAS dos equipamentos no formato
impedancias = [
    #busfr #busto #seqpos #seqneg #seqzero
    0 1 0.10im 0.10im 0.16im
    1 2 0.10im 0.10im 0.10im
    2 3 0.10im 0.10im 0.14im
    3 4 0.25im 0.25im Inf
    4 5 0.30im 0.30im 0.40im
    5 0 0.05im 0.05im Inf
]
As cargas ligadas a barra 0 (referencia serão consideradas cargas)
"""
function inputs(impedancias; sequencia::String = "positiva", infvalue = 10^7)
    cargas = []
    # Substitui infinitos por infvalue
    treatInfvalue!(impedancias, infvalue)
    if sequencia == "positiva"
        cargas = buildcargas(impedancias[:, [1;2;3]])
        admitancias = buildadmitancias(impedancias[:, [1;2;3]])
    elseif sequencia == "negativa"
        cargas = buildcargas(impedancias[:, [1;2;4]])
        admitancias = buildadmitancias(impedancias[:, [1;2;4]])
    elseif sequencia == "zero"
        cargas = buildcargas(impedancias[:, [1;2;5]])
        admitancias = buildadmitancias(impedancias[:, [1;2;5]])
    else
        error("Só é possível escolher entre sequência positiva, negativa e zero")
    end
    return admitancias, cargas
end

function buildcargas(impedancias)
    idx1 = findall(x -> x .== 0, impedancias[:, 1])
    idx2 = findall(x -> x .== 0, impedancias[:, 2])
    idxcargas = [idx1;idx2]
    
    carga = Array{Float64, 2}(undef, length(idxcargas), 3)
    c = 1
    for i in idxcargas
                    #id bus
            carga[c, :] = [max(real(impedancias[i, 1]), real(impedancias[i, 2])) real(impedancias[i, 3]^-1) imag(impedancias[i, 3]^-1)]
            c+=1
    end
    return carga
end

function buildadmitancias(impedancias)
    idx1 = findall(x -> x .!= 0, impedancias[:, 1])
    idx2 = findall(x -> x .!= 0, impedancias[:, 2])
    idxadmit = intersect(idx1,idx2)
    admit = Array{Complex, 2}(undef, length(idxadmit), 3)
    ad = 1
    for i in idxadmit
                    #id bus
            admit[ad, :] = [impedancias[i, 1] impedancias[i, 2] impedancias[i, 3]^-1]
            ad+=1
    end
    return admit
end

function treatInfvalue!(impedancias, infvalue)
    idxs = findall(x -> x == Inf, impedancias)
    impedancias[idxs] .= infvalue
    return impedancias
end