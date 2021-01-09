module Mapper

using ..Model

const STORE = Dict{Int64, Paper}()
const COUNTER = Ref{Int64}(0)

function store!(paper)
    if haskey(STORE, paper.id)
        # updating
        STORE[paper.id] = paper
    else
        # creating new
        paper.id = COUNTER[] += 1
        STORE[paper.id] = paper
    end
    return
end

function get(id)
    return STORE[id]
end

function delete!(id)
    delete!(STORE, id)
    return
end

function getAllPapers()
    return collect(values(STORE))
end

end

