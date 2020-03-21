@with_kw_noshow mutable struct Penalty{T1 <: AbstractFloat}
    name :: Symbol
    isUsed :: Bool = true
    scalarValue :: T1
    # Function that computes `scalarValue`
    scalarFct :: Function
    showFct :: Union{Function, Nothing} = nothing
end


mutable struct PenaltyVector
    pv :: Vector{Penalty}
end

# ---------------