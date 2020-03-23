name(p :: Penalty) = p.name;

is_used(p :: Penalty) = p.isUsed;
use(p :: Penalty) =  set_use(p, true);
no_use(p :: Penalty) =  set_use(p, false);
set_use(p :: Penalty, doUse :: Bool) =  (p.isUsed = doUse);

set_scalar_value(p :: Penalty, v) =  p.scalarValue = v;
scalar_value(p :: Penalty) = p.scalarValue;

function show_string(p :: Penalty)
    vStr = format_number(scalar_value(p));
    return "Penalty $(name(p)):  $vStr";
end

Base.show(io :: IO, p :: Penalty) = println(io,  show_string(p));

"""
	$(SIGNATURES)

Compute and return scalar penalty.
Multiple inputs to `scalarFct` must be packaged into a tuple.
"""
function compute_penalty(p :: Penalty, x)
    sv = p.scalarFct(x);
    set_scalar_value(p, sv);
    return sv
end


# ---------