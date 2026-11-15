# Session events: the kernel applies these after the current top-level statement. They are not
# functions that mutate the caller: `clear` makes the kernel swap in a fresh session module (or
# drop names), `clc` tells the app to clear its console. Neither touches the app's figure history.

"""The events recorded since the last `take_events()`, in order."""
const EVENTS = Any[]

"""
    clear()
    clear(:x, :y)

`clear()` resets the session before the next statement; `clear(:x)` drops just those bindings.
Figures already in the app's history stay there.
"""
function clear(names...)
    if isempty(names)
        push!(EVENTS, Dict{String, Any}("type" => "clear"))
    else
        push!(EVENTS, Dict{String, Any}("type" => "clear", "names" => [string(n) for n in names]))
    end
    return nothing
end

"""`clc()` clears the app's console."""
function clc()
    push!(EVENTS, Dict{String, Any}("type" => "clc"))
    return nothing
end

"""
    open_example()
    open_example(index::Integer)
    open_example(name::Union{AbstractString, Symbol})

Request that the app open one of its shipped tutorial examples read-only by 1-based index
(defaulting to `1`) or by filename/slug/name.
"""
open_example() = open_example(1)

function open_example(index::Integer)
    (index isa Bool || index < 1) && throw(ArgumentError("example index must be >= 1, got $index"))
    push!(EVENTS, Dict{String, Any}("type" => "open_example", "index" => Int(index)))
    return nothing
end

function open_example(name::Union{AbstractString, Symbol})
    cleaned = strip(String(name))
    isempty(cleaned) && throw(ArgumentError("example name must not be empty"))
    push!(EVENTS, Dict{String, Any}("type" => "open_example", "name" => cleaned))
    return nothing
end

"""`take_events()`: the recorded session events (and forget them)."""
take_events() = (out = copy(EVENTS); empty!(EVENTS); out)
