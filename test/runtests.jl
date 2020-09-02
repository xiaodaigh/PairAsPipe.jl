using PairAsPipe
using Test

@testset "PairAsPipe.jl" begin
    # Write your tests here.
end



using DataFrames, DataFramesMeta, Pipe

data = DataFrame(a = rand(1:8, 100), b = rand(1:8, 100), c = rand(100))


@pipe data |>
    groupby(_, :a) |>
    @orderby(_, :b)



