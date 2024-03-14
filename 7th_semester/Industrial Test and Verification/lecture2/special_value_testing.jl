using Test

include("NextDate.jl")

@testset "Special-value testing" begin
    @test NextDate(28, 2, 2023) == (1, 3, 2023)
    @test NextDate(28, 2, 2020) == (29, 2, 2020)
    @test NextDate(28, 2, 2100) == (1, 3, 2100)
    @test NextDate(28, 2, 2000) == (29, 2, 2000)
    @test NextDate(31, 12, 2023) == (1, 1, 2024)
end

nothing
