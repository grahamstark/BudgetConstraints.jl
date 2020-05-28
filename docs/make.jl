using BudgetConstraints
using Documenter

makedocs(;
    modules=[BudgetConstraints],
    authors="Graham Stark",
    repo="https://github.com/grahamstark/BudgetConstraints.jl/blob/{commit}{path}#L{line}",
    sitename="BudgetConstraints.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://grahamstark.github.io/BudgetConstraints.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/grahamstark/BudgetConstraints.jl",
)
