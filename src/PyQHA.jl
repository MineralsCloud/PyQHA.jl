module PyQHA

__precompile__() # this module is safe to precompile

using PyCall: PyNULL, PyError, PyObject, PyAny, pyimport, pycall
# Extending methods
import PyCall

const qha = PyNULL()
const qha_calculator = PyNULL()
const qha_basicio_out = PyNULL()
const qha_settings = PyNULL()
const qha_plotting = PyNULL()
const qha_input_maker = PyNULL()

@eval import Conda
Conda.pip_interop(true)
Conda.pip("install", "git+https://github.com/MineralsCloud/qha.git@v1.0.20")

function __init__()
    copy!(qha, pyimport("qha"))
    copy!(qha_calculator, pyimport("qha.calculator"))
    copy!(qha_basicio_out, pyimport("qha.basic_io.out"))
    copy!(qha_settings, pyimport("qha.settings"))
    copy!(qha_plotting, pyimport("qha.plotting"))
    copy!(qha_input_maker, pyimport("qha.basic_io.input_maker"))
    # Code from https://github.com/JuliaPy/PyPlot.jl/blob/caf7f89/src/init.jl#L168-L173
    vers = qha.__version__
    global version = try
        VersionNumber(vers)
    catch
        v"0.0.0" # fallback
    end
end

include("Settings.jl")
include("Calculators.jl")
include("io.jl")
include("run.jl")
include("plot.jl")
include("convert.jl")

end
