using PyQHA
using Documenter

DocMeta.setdocmeta!(PyQHA, :DocTestSetup, :(using PyQHA); recursive=true)

makedocs(;
    modules=[PyQHA],
    authors="singularitti <singularitti@outlook.com> and contributors",
    repo="https://github.com/MineralsCloud/PyQHA.jl/blob/{commit}{path}#{line}",
    sitename="PyQHA.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://MineralsCloud.github.io/PyQHA.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/MineralsCloud/PyQHA.jl",
    devbranch="main",
)
