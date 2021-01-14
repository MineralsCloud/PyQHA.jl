module Calculators

using PyCall: PyObject

using PyQHA: qha_calculator, @pyinterface

export SingleCalculator, SamePhDOSCalculator, DifferentPhDOSCalculator

abstract type Calculator end
mutable struct SingleCalculator <: Calculator
    o::PyObject
end
SingleCalculator(config::AbstractDict) = SingleCalculator(qha_calculator.Calculator(config))
mutable struct SamePhDOSCalculator <: Calculator
    o::PyObject
end
SamePhDOSCalculator(config::AbstractDict) =
    SamePhDOSCalculator(qha_calculator.SamePhDOSCalculator(config))
mutable struct DifferentPhDOSCalculator <: Calculator
    o::PyObject
end
DifferentPhDOSCalculator(config::AbstractDict) =
    DifferentPhDOSCalculator(qha_calculator.DifferentPhDOSCalculator(config))

@pyinterface Calculator

end
