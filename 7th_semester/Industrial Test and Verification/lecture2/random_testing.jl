using Test
using Random: GLOBAL_RNG, seed!

include("NextDate.jl")

k = 100  # number of test cases per function

@testset "Random testing" begin
    # fix random seed to a random number and print it
    seed = abs(rand(Int))
    @show seed
    seed!(GLOBAL_RNG, seed)

    @testset "IsLeapYear" begin
        for _ in 1:k
            y = rand(Int)
            res = IsLeapYear(y)
            exp = (y % 4 == 0 && (y % 100 != 0 || y % 400 == 0))

            @test res == exp
        end
    end

    @testset "NextDate arbitrary inputs" begin
        n_errors = 0
        for _ in 1:k
            d = rand(1:31)
            m = rand(1:12)
            y = rand(1850:2050)

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

    @testset "NextDate valid inputs" begin
        for _ in 1:k
            m = rand(1:12)
            y = rand(1850:2050)
            if m == 2
                num_days = IsLeapYear(y) ? 29 : 28
            else
                num_days = m ∈ (4, 6, 9, 11) ? 30 : 31
            end
            d = rand(1:num_days)

            @test NextDate(d, m, y) isa Tuple
        end
    end
end

nothing
