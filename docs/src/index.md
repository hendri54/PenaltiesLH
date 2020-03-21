# PenaltiesLH

Package to keep track of penalty deviations to be used during model calibration.

Intended work flow:

1. When initializing the model, define all possible `Penalty` objects and the associated functions that compute scalar penalties from some model statistics.
2. Collect all `Penalty` objects in a `PenaltyVector` the becomes part of the model.
3. Set which penalties are used during a given run using `use` or `no_use`.
4. During the computation, compute all scalar penalties using [`compute_all_penalties`](@ref).
5. Add the total penalty, computed with [`total_penalty`](@ref), to the objective function.
6. During iterations or at the end, report which penalties were imposed using [`report_penalties`](@ref).

# Function Reference

```@meta
CurrentModule = PenaltiesLH
```

```@autodocs
Modules = [PenaltiesLH]
```


--------
