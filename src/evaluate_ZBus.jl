"""
Forma ruim de calcular a Zbus (invertendo a matriz)
"""
function naiveZbus(YBus)
    return LinearAlgebra.inv(YBus)
end

"""
Forma esperta de calcular a Zbus (resolvendo um sistema linear para cada barra)
"""
function smartZbus(Ybus)
    Zbus = zeros(Complex, size(Ybus))
    nbuses = size(Ybus, 1)
    for i = 1:nbuses
        I = zeros(nbuses)
        I[i] = 1
        Zbus[:, i] = eval_tensions(I, Ybus)
    end
    return Zbus
end

function smartZth(Ybus, col)
    Zbuscol = zeros(Complex, size(Ybus, 1))
    I = zeros(size(Ybus, 1))
    I[col] = 1
    return eval_tensions(I, Ybus)[col]
end