"""
Resolve V = YBus*I (b = A*x)
"""
function eval_tensions(I, Ybus)
    return Ybus\I
end