```@meta
CurrentModule = PyQHA
```

# PyQHA

Documentation for [PyQHA](https://github.com/MineralsCloud/PyQHA.jl).

See the [Index](@ref main-index) for the complete list of documented functions
and types.

The code is [hosted on GitHub](https://github.com/MineralsCloud/PyQHA.jl),
with some continuous integration services to test its validity.

This repository is created and maintained by [@singularitti](https://github.com/singularitti).
You are very welcome to contribute.

## Installation

The package can be installed with the Julia package manager.
From the Julia REPL, type `]` to enter the Pkg REPL mode and run:

```julia
pkg> add PyQHA
```

Or, equivalently, via the `Pkg` API:

```@repl
import Pkg; Pkg.add("PyQHA")
```

## Documentation

- [**STABLE**](https://MineralsCloud.github.io/PyQHA.jl/stable) — **documentation of the most recently tagged version.**
- [**DEV**](https://MineralsCloud.github.io/PyQHA.jl/dev) — _documentation of the in-development version._

## Project status

The package is tested against, and being developed for, Julia `1.6` and above on Linux,
macOS, and Windows.

## Questions and contributions

Usage questions can be posted on
[our discussion page](https://github.com/MineralsCloud/PyQHA.jl/discussions).

Contributions are very welcome, as are feature requests and suggestions. Please open an
[issue](https://github.com/MineralsCloud/PyQHA.jl/issues)
if you encounter any problems. The [Contributing](@ref) page has
a few guidelines that should be followed when opening pull requests and contributing code.

## Manual outline

```@contents
Pages = [
    "installation.md",
    "developers/contributing.md",
    "developers/style-guide.md",
    "developers/design-principles.md",
    "troubleshooting.md",
]
Depth = 3
```

## Library outline

```@contents
Pages = ["public.md"]
```

### [Index](@id main-index)

```@index
Pages = ["public.md"]
```
