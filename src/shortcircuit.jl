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
    if fase == "a"
        Iseq = PHASE2SEQ*[Iflt; 0; 0]
        Vseq = [-Zth[3]*Iflt; Vth - Zth[1]*Iflt; -Zth[2]*Iflt]
    elseif fase == "b"
        Iseq = PHASE2SEQ*[0; Iflt; 0]
        Vseq = [-Zth[3]*Iflt; ANG*(Vth - Zth[1]*Iflt); ANG^2*-Zth[2]*Iflt]
    elseif fase == "c"
        Iseq = PHASE2SEQ*[0; 0; Iflt]
        Vseq = [-Zth[3]*Iflt; ANG^2*(Vth - Zth[1]*Iflt); ANG*-Zth[2]*Iflt]
    else
        error("Fase só pode ser a, b ou c")
    end
    return SEQ2PHASE*Iseq, SEQ2PHASE*Vseq
end