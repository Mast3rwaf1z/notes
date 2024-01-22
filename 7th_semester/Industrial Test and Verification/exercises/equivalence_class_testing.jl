using Test

include("NextDate.jl")

function get_equivalence_class_values_Cartesian(equivalence_classes_per_variable;
                                                weak::Bool)
    # maximum number of equivalence classes per variable
    l = maximum(length, equivalence_classes_per_variable)

    test_cases = []
    if weak
        for j in 1:l
            test_case = []
            for ecs in equivalence_classes_per_variable
                ec = ecs[min(j, length(ecs))]
                v = select(ec)
                push!(test_case, v)
            end
            push!(test_cases, test_case)
        end
    else
        throw(ArgumentError("not implemented"))
    end

    return test_cases
end

# Instead of this (deterministic) selection, we could instead have passed only
# one selected value per equivalence class to the function.
# Passing the whole equivalence class instead allows us to easily replace this
# selection later, e.g., by a random selection.
function select(ec)
    i = ceil(Int, length(ec) / 2)
    return ec[i]
end

function generate_test_cases(; weak::Bool)
    D1 = 1:27
    D2 = [28]
    D3 = [29]
    D4 = [30]
    D5 = [31]
    M1 = [4, 6, 9, 11]
    M2 = [1, 3, 5, 7, 8, 10]
    M3 = [12]
    M4 = [2]
    Y1 = [y for y ∈ 1850:2050 if IsLeapYear(y) && y != 2000]
    Y2 = [y for y ∈ 1850:2050 if !IsLeapYear(y) && y != 1900]
    Y3 = [1900]
    Y4 = [2000]

    Ds = [D1, D2, D3, D4, D5]
    Ms = [M1, M2, M3, M4]
    Ys = [Y1, Y2, Y3, Y4]

    n_errors = 0
    for (d, m, y) in get_equivalence_class_values_Cartesian([Ds, Ms, Ys];
                                                            weak=weak)
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

@testset "Equivalence-class testing" begin
    @testset "Weak" begin
        generate_test_cases(; weak=true)
    end

    # not implemented
    # @testset "Strong" begin
    #     generate_test_cases(; weak=false)
    # end
end

nothing
