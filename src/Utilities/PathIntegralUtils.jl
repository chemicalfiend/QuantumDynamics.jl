using Combinatorics

"""
    unhash_path(path_num::Int, ntimes::Int, sdim::Int)
Construct a path for a system with `sdim` dimensions, corresponding to the number `path_num`, with `ntimes` time steps.
"""
unhash_path(path_num::Int, ntimes::Int, sdim) = digits(path_num - 1, base=sdim, pad=ntimes + 1) .+ 1

function unhash_path(path_num::Int, states::AbstractVector{<:UInt}, sdim)
    digits!(states, path_num - 1, base=sdim)
    states .+= 1
    nothing
end

"""
    hash_path(states, sdim)
Returns the hashed location of a path for a system with `sdim` dimensions.
"""
function hash_path(states::AbstractVector{<:UInt}, sdim)
    factor = 1
    number = 0
    for s in states
        number += (s - 1) * factor
        factor *= sdim
    end
    number + 1
end

function get_blip_starting_path(ntimes::Int, sdim::Int, nblips::Int, max::Int)
    if ntimes == 0
        return Vector{Vector{UInt64}}([])
    end
    if nblips == 0
        return [repeat([UInt64(1)], ntimes + 1)]
    end
    starting_paths = Vector{Vector{UInt64}}()
    for l = 2:max
        if ntimes > 1
            append!(starting_paths, [vcat(path, l) for path in get_blip_starting_path(ntimes - 1, sdim, nblips - 1, l)])
        else
            if nblips == 1
                push!(starting_paths, [1, l])
            elseif nblips == 2
                for l2 = 2:l
                    push!(starting_paths, [l2, l])
                end
            end
        end
    end
    starting_paths
end

function has_small_changes(path, num_changes)
    nchanges = 0
    @inbounds for (p1, p2) in zip(path, path[2:end])
        if p1 != UInt64(1) && p2 != UInt64(1) && p1 != p2
            nchanges += 1
        end
    end
    nchanges ≤ num_changes
end

"""
    unhash_path_blips(ntimes::Int, sdim::Int, nblips::Int)
Construct all the paths for a system with `sdim` dimensions with `ntimes` time steps and `nblips` blips.
"""
unhash_path_blips(ntimes::Int, sdim::Int, nblips::Int) = vcat([multiset_permutations(p, ntimes + 1) |> collect for p in get_blip_starting_path(ntimes, sdim, nblips, sdim)]...)