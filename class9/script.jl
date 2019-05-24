push!(LOAD_PATH, "/Users/guilhermebodin/Documents/AnaliseDeRedes.jl/src")
using AnaliseDeRedes

ramos = [ #from #to #r #x
    1 2 0.05 0.10
]

cargas = [ #bus #g #b
    1 0 0.02
    2 0 0.02
]

Ybus = buildYbus(evaladmitancias(ramos), [1,2]; cargas = cargas)

P(x) = 4*cos(x) - 8*sin(x) - 4.4
Pdx(x) = -4*sin(x) - 8*cos(x)


function newton(func::Function, derivative::Function; init::Float64 = 0.0, maxiter::Int = 100, tol::Float64 = 0.001)
    k = 0
    xk = init
    for k = 1:maxiter
        funcval = func(xk)
        if abs(funcval) <= tol
            return xk
        else
            derivativeval = derivative(xk)
            deltax = -funcval/derivativeval
            xk = xk + deltax
            k += 1
        end
    end
    return "Max iter"
end

function newtonconstder(func::Function, derivative::Function; init::Float64 = 0.0, maxiter::Int = 100, tol::Float64 = 0.001)
    k = 0
    xk = init
    derivativeval = derivative(init)
    for k = 1:maxiter
        funcval = func(xk)
        if abs(funcval) <= tol
            return xk
        else
            deltax = -funcval/derivativeval
            xk = xk + deltax
            k += 1
        end
    end
    return "Max iter"
end

function test(n)
    times = Array{Float64, 2}(undef, n, 2)
    for t = 1:n
        t1 = @timed newton(P, Pdx)
        t2 = @timed newtonconstder(P, Pdx)
        times[t, :] = [t1[2], t2[2]]
    end
    return times
end

@time newton(P, Pdx)
@time newtonconstder(P, Pdx)
t = test(1000)

using Plots
plot(t)