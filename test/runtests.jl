using AdventOfCodes
using Test

@testset "Day 01" begin
    @test day_01("../data/data-01-01-test.txt", day=1) == 142
    @test day_01("../data/data-01.txt", day=1) == 55029

    @test day_01("../data/data-01-02-test.txt", day=2) == 281
    @test day_01("../data/data-01.txt", day=2) == 55686
end

@testset "Day 02" begin
    score, power = day_02("../data/data-02-01-test.txt")
    @test score == 8
    @test power == 2286

    score, power = day_02("../data/data-02.txt")
    @test score == 2528
    @test power == 67363
end

@testset "Day 03" begin
    @test day_03("../data/data-03-01-test.txt", day=1) == 4361
    @test day_03("../data/data-03-01.txt", day=1) == 531561

    @test day_03("../data/data-03-01-test.txt", day=2) == 467835
    @test day_03("../data/data-03-01.txt", day=2) == 83279367

end

@testset "Day 04" begin
    score, nwinningcards = day_04("../data/data-04-test.txt")
    @test score == 13
    @test nwinningcards == 30

    score, nwinningcards = day_04("../data/data-04.txt")
    @test score == 22488
    @test nwinningcards == 7013204
end
