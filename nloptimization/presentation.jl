using LinearAlgebra
n = 15
W = Symmetric(rand(n, n))

# Naive way
function bit_representation(n)
    possible_partitions = collect(1:2^n)
    bit_repr = Array{String}(undef, 2^n)
    for i in eachindex(possible_partitions)
        bit_repr[i] = bitstring(i)[end-25:end]
    end
    return bit_repr
end
@time bit_representation(n)

function findbestpartition(W)
    
end

using JuMP, ProxSDP, SCS
n = 15
W = Symmetric(rand(n, n))
function solvewithprox(W, n)
    ones_matrix = ones(n,n)
    m = Model(with_optimizer(ProxSDP.Optimizer, log_verbose = true))
    @variable(m, X[1:n, 1:n], PSD)
    @constraint(m, diag(X) .== 1)
    @objective(m, Min, sum(diag(W*X)))
    optimize!(m)
    solution = JuMP.value.(X)
    eigvals(solution)
    return rank(solution)
end

function solvewithscs(W, n)
    ones_matrix = ones(n,n)
    m = Model(with_optimizer(SCS.Optimizer))
    @variable(m, X[1:n, 1:n], PSD)
    @constraint(m, diag(X) .== 1)
    @objective(m, Min, sum(diag(W*X)))
    optimize!(m)
    solution = JuMP.value.(X)
    eigvals(solution)
    return rank(solution)
end
n = 35
W = Symmetric(rand(n, n))
solvewithprox(W, n)
solvewithscs(W, n)
