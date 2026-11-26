using Test
using JSON3
using SqueroBase
using Aqua

@testset "SqueroBase" begin

@testset "session events" begin
    reset_queues!()
    clear(); clear(:x, "y"); clc()
    open_example(); open_example(2); open_example(" 01-signals "); open_example(:lorenz)
    events = take_events()
    @test [e["type"] for e in events] == ["clear", "clear", "clc", "open_example", "open_example", "open_example", "open_example"]
    @test !haskey(events[1], "names")
    @test events[2]["names"] == ["x", "y"]
    @test events[4]["index"] == 1
    @test events[5]["index"] == 2
    @test events[6]["name"] == "01-signals"
    @test events[7]["name"] == "lorenz"
    @test isempty(take_events())          # taken once
    @test clear() === nothing && clc() === nothing && open_example(1) === nothing
    @test_throws ArgumentError open_example(0)
    @test_throws ArgumentError open_example(-3)
    @test_throws ArgumentError open_example(true)
    @test_throws ArgumentError open_example("")
    @test_throws ArgumentError open_example("   ")
    @test_throws ArgumentError open_example(Symbol(""))
    reset_queues!()
    @test isempty(take_events())
end

@testset "no plotting surface" begin
    for name in (:plot, :surf, :mesh, :meshgrid, :peaks, :state_space, :figure, :title, :xlabel, :hold, :subplot)
        @test !isdefined(SqueroBase, name)
    end
end

@testset "simulation bridge" begin
    take_runs()
    graph = (nodes = [(id = "plant", type = "control/state_space",
                       params = (A = [0.0 1.0; -2.0 -3.0], B = [0.0; 1.0;;], C = [1.0 0.0], D = [0.0;;], domain = :s))],
             edges = [])
    r = simulate(graph; duration = 10, dt = 0.01, solver = :rk45, variables = (x0 = [1.0, 0.0],))
    @test only(take_runs()) === r
    data = JSON3.read(run_json(r))
    @test data["type"] == "graph.run"
    @test data["settings"]["solver"] == "rk45" && data["settings"]["duration"] == 10.0 && data["settings"]["dt"] == 0.01
    @test data["graph"]["nodes"][1]["params"]["A"] == [[0.0, 1.0], [-2.0, -3.0]]
    @test data["graph"]["nodes"][1]["params"]["domain"] == "s"
    @test data["variables"]["x0"] == [1.0, 0.0]
    @test occursin("1 nodes", sprint(show, r))
    @test !haskey(JSON3.read(run_json(simulate((nodes = [], edges = []))))["settings"], "solver")
    @test_throws ArgumentError simulate((nodes = [],))
    @test_throws ArgumentError simulate(graph; solver = :magic)
    @test_throws ArgumentError simulate(graph; dt = 0)
    @test_throws ArgumentError simulate(graph; duration = -1)
    take_runs()
end

@testset "Aqua" begin
    Aqua.test_all(SqueroBase; persistent_tasks = false)
end

end
