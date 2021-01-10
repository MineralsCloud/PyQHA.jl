using PyQHA
using Documenter

makedocs(;
    modules=[PyQHA],
    authors="Qi Zhang <singularitti@outlook.com>",
    repo="https://github.com/MineralsCloud/PyQHA.jl/blob/{commit}{path}#L{line}",
    sitename="PyQHA.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://MineralsCloud.github.io/PyQHA.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/MineralsCloud/PyQHA.jl",
)
