module PenaltiesLH

using ArgCheck, DocStringExtensions, Parameters

export Penalty, PenaltyVector
# Penalty
export name, compute_penalty, scalar_value, set_scalar_value, use, no_use, is_used
# PenaltyVector
export retrieve, penalty_dict, total_penalty, compute_all_penalties, report_penalties

include("types.jl")
include("penalty.jl")
include("penalty_vector.jl")

function format_number(x; ndigits = 2)
    xFmt = round(x, digits = ndigits);
    return string(xFmt);
end

end # module
