module PyQHA

using PythonCall: PythonCall, Py, pynew, pyimport, pyhasattr, pyconvert, pycall, pycopy!

const qha = pynew()
const qha_calculator = pynew()
const qha_basicio_out = pynew()
const qha_settings = pynew()
const qha_plotting = pynew()
const qha_input_maker = pynew()

function __init__()
    pycopy!(qha, pyimport("qha"))
    pycopy!(qha_calculator, pyimport("qha.calculator"))
    pycopy!(qha_basicio_out, pyimport("qha.basic_io.out"))
    pycopy!(qha_settings, pyimport("qha.settings"))
    pycopy!(qha_plotting, pyimport("qha.plotting"))
    pycopy!(qha_input_maker, pyimport("qha.basic_io.input_maker"))
    # Code from https://github.com/JuliaPy/PyPlot.jl/blob/caf7f89/src/init.jl#L168-L173
    vers = qha.__version__
    return global version = try
        VersionNumber(vers)
    catch
        v"0.0.0" # fallback
    end
end

include("data.jl")
include("Settings.jl")
include("Calculators.jl")
include("io.jl")
include("run.jl")
include("plot.jl")
include("convert.jl")
include("recipes.jl")

end
