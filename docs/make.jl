using Documenter, PenaltiesLH

makedocs(
    modules = [PenaltiesLH],
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true"),
    authors = "hendri54",
    sitename = "PenaltiesLH.jl",
    pages = Any["index.md"]
    # strict = true,
    # clean = true,
    # checkdocs = :exports,
)

# deploydocs(
#     repo = "github.com/hendri54/PenaltiesLH.jl.git",
#     push_preview = true
# )
