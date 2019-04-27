function shortcircuit(impedancias, bus, idxbuses, fase, Vth)
    Zth = Array{Complex}(undef, 3)
    i = 1
    for seq in ["positiva"; "negativa"; "zero"]
        admitancias, cargas = inputs(impedancias; sequencia = seq)
        Ybus = buildYbus(admitancias, idxbuses, cargas = cargas)
        Zth[i] = smartZth(Ybus, bus)
        i+=1
    end
    Iflt = 1/sum(Zth)
    Iseq = [Iflt; Iflt; Iflt]
    Vseq = [-Zth[3]*Iflt; Vth - Zth[1]*Iflt; -Zth[2]*Iflt]
    return SEQ2PHASE*Iseq, SEQ2PHASE*Vseq
end