using Test

include("NextDate.jl")

function get_boundary_values(mins, maxs,
                             nominals=(mins .+ ceil.(Int, (maxs .- mins) ./ 2));
                             robust::Bool, single_fault::Bool)
    n = length(mins)
    if n != length(maxs) || n != length(nominals)
        throw(ArgumentError("different lengths"))
    end

    if single_fault
        test_cases = [copy(nominals)]
        for i in 1:n
            vals = copy(nominals)

            vals[i] = mins[i]
            push!(test_cases, copy(vals))

            vals[i] = mins[i] + 1
            push!(test_cases, copy(vals))

            vals[i] = maxs[i] - 1
            push!(test_cases, copy(vals))

            vals[i] = maxs[i]
            push!(test_cases, copy(vals))

            if robust
                vals[i] = mins[i] - 1
                push!(test_cases, copy(vals))

                vals[i] = maxs[i] + 1
                push!(test_cases, copy(vals))
            end
        end
    else
    end

    return test_cases
end

function generate_test_cases(; robust, single_fault)
    mins = [1, 1, 1]
    maxs = [31, 12, 2050]

    n_errors = 0
    for (d, m, y) in get_boundary_values(mins, maxs; robust=robust,
                                         single_fault=single_fault)
        try
            NextDate(d, m, y)
            @test true  # no error
        catch e
            n_errors += 1
            @test e isa ArgumentError  # ArgumentError is allowed
        end
    end
    @show n_errors  # print number of errors
end

@testset "Boundary-value testing" begin
    @testset "Non-robust single fault" begin
        generate_test_cases(; robust=false, single_fault=true)
    end

    @testset "Robust single fault" begin
        generate_test_cases(; robust=true, single_fault=true)
    end

    # not implemented
    # @testset "Non-robust multi fault" begin
    #     generate_test_cases(mins, maxs; robust=false, single_fault=false)
    # end

    # not implemented
    # @testset "Robust multi fault" begin
    #     generate_test_cases(mins, maxs; robust=true, single_fault=false)
    # end
end

nothing
