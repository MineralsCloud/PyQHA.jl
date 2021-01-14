module Calculators

using PyCall: PyObject

using PyQHA: qha_calculator, @pyinterface
using PyQHA.Settings: Config

export SingleCalculator, SamePhDOSCalculator, DifferentPhDOSCalculator

abstract type Calculator end
mutable struct SingleCalculator <: Calculator
    o::PyObject
end
SingleCalculator(config::Config) = SingleCalculator(qha_calculator.Calculator(config))
mutable struct SamePhDOSCalculator <: Calculator
    o::PyObject
end
SamePhDOSCalculator(config::Config) =
    SamePhDOSCalculator(qha_calculator.SamePhDOSCalculator(config))
mutable struct DifferentPhDOSCalculator <: Calculator
    o::PyObject
end
DifferentPhDOSCalculator(config::Config) =
    DifferentPhDOSCalculator(qha_calculator.DifferentPhDOSCalculator(config))

@pyinterface Calculator

end
