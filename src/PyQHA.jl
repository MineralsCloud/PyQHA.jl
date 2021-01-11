module PyQHA

__precompile__() # this module is safe to precompile

using PyCall: PyNULL, PyError, PyObject, PyAny, pyimport, pycall
# Extending methods
import PyCall

export qha

const qha = PyNULL()

function __init__()
    copy!(qha, pyimport("qha"))
    # Code from https://github.com/JuliaPy/PyPlot.jl/blob/caf7f89/src/init.jl#L168-L173
    vers = qha.__version__
    global version = try
        VersionNumber(vers)
    catch
        v"0.0.0" # fallback
    end
end

macro pyinterface(T)
    T = esc(T)
    return quote
        # Code from https://github.com/JuliaPy/PyPlot.jl/blob/6b38c75/src/PyPlot.jl#L54-L62
        PyCall.PyObject(f::$T) = getfield(f, :o)
        Base.convert(::Type{$T}, o::PyObject) = $T(o)
        Base.:(==)(f::$T, g::$T) = PyObject(f) == PyObject(g)
        Base.:(==)(f::$T, g::PyObject) = PyObject(f) == g
        Base.:(==)(f::PyObject, g::$T) = f == PyObject(g)
        Base.hash(f::$T) = hash(PyObject(f))
        PyCall.pycall(f::$T, args...; kws...) = pycall(PyObject(f), args...; kws...)
        (f::$T)(args...; kws...) = pycall(PyObject(f), PyAny, args...; kws...)
        Base.Docs.doc(f::$T) = Base.Docs.doc(PyObject(f))
        # Code from https://github.com/JuliaPy/PyPlot.jl/blob/6b38c75/src/PyPlot.jl#L65-L71
        Base.getproperty(f::$T, s::Symbol) = getproperty(PyObject(f), s)
        Base.getproperty(f::$T, s::AbstractString) = getproperty(PyObject(f), s)
        Base.setproperty!(f::$T, s::Symbol, x) = setproperty!(PyObject(f), s, x)
        Base.setproperty!(f::$T, s::AbstractString, x) = setproperty!(PyObject(f), s, x)
        PyCall.hasproperty(f::$T, s::Symbol) = hasproperty(PyObject(f), s)
        Base.propertynames(f::$T) = propertynames(PyObject(f))
        Base.haskey(f::$T, x) = haskey(PyObject(f), x)
        # Common methods
        Base.close(f::$T) = PyObject(f).close()
    end
end

include("Calculators.jl")
end
