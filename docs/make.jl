using PyQHA
using Documenter

DocMeta.setdocmeta!(PyQHA, :DocTestSetup, :(using PyQHA); recursive=true)

makedocs(;
    modules=[PyQHA],
    authors="Qi Zhang <singularitti@outlook.com>",
    repo="https://github.com/MineralsCloud/PyQHA.jl/blob/{commit}{path}#{line}",
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
