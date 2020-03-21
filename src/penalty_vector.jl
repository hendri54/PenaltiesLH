# Penalty Vector

PenaltyVector() = PenaltyVector(Vector{Penalty}());
PenaltyVector(n :: Integer) = PenaltyVector(Vector{Penalty}(undef, n));

Base.length(pv :: PenaltyVector) = length(pv.pv);
Base.isempty(pv :: PenaltyVector) = isempty(pv.pv);
Base.getindex(pv :: PenaltyVector, idx) = getindex(pv.pv, idx);
Base.setindex!(pv :: PenaltyVector, v :: Penalty, idx) = setindex!(pv.pv, v, idx);
Base.push!(pv :: PenaltyVector, v :: Penalty) = push!(pv.pv, v);

Base.iterate(pv :: PenaltyVector) = (pv[1], 2);

function Base.iterate(pv :: PenaltyVector, idx) 
    if idx > length(pv)
        return nothing
    else
        return (pv.pv[idx], idx+1)
    end
end


"""
	$(SIGNATURES)

Retrieve a penalty by name. Returns nothing if not found.
"""
function retrieve(pv :: PenaltyVector, pName :: Symbol)
    pOut = nothing;
    for p in pv
        if name(p) == pName
            pOut = p;
            break;
        end
    end
    return pOut
end


"""
	$(SIGNATURES)

Compute all (used) scalar penalties.
"""
function compute_all_penalties(pv :: PenaltyVector, x)
    for p in pv
        if is_used(p)
            compute_penalty(p, x);
        end
    end
    return nothing
end


"""
	$(SIGNATURES)

Return scalar penalties as Dict mapping names into penalties.
"""
function penalty_dict(pv :: PenaltyVector)
    d = Dict{Symbol, Float64}();
    for p in pv
        if is_used(p)
            d[name(p)] = scalar_value(p);
        end
    end
    return d
end


"""
	$(SIGNATURES)

Computer sum of all used penalties.
Optionally recompute all penalties using the `data` provided.
"""
function total_penalty(pv :: PenaltyVector; data = nothing)
    pTotal = 0.0;
    for p in pv
        if is_used(p)
            if !isnothing(data)
                compute_penalty(p, data);
            end
            pTotal += scalar_value(p);
        end
    end
    return pTotal
end


"""
	$(SIGNATURES)

Report all (positive) penalties. Optionally recompute with provided data.
"""
function report_penalties(pv :: PenaltyVector; data = nothing, io = stdout)
    pTotal = total_penalty(pv; data = data);
    pStr = format_number(pTotal);
    println(io, "Penalties:   total = $pStr")
    for p in pv
        if is_used(p)
            pStr = format_number(scalar_value(p));
            println("  $(name(p)):  $pStr")
        end
    end
    return nothing
end

# ------------