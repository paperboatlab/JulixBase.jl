"""
    SqueroBase

The session layer of Squero Studio MX: `clear`/`clc` session events, and the bridge that hands
work to Paperboat (`simulate` builds a run request for a station). It does not plot, solve or
integrate; plotting is SqueroPlot's, simulation Paperboat's. Optimization: CasADiNative.jl.

The kernel collects what a statement recorded with `take_events` and `take_runs`.
"""
module SqueroBase

using JSON3

export clear, clc, open_example
export simulate, SimulationRequest, run_json
export take_events, take_runs, reset_queues!

include("session.jl")
include("simulate.jl")

"""`reset_queues!()`: drop every recorded event and run (a kernel `reset`)."""
function reset_queues!()
    empty!(EVENTS)
    empty!(RUNS)
    return nothing
end

end
