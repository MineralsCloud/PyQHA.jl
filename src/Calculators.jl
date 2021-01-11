module Calculators

using PyCall: PyObject

using PyQHA: qha, @pyinterface

export SingleCalculator, SamePhDOSCalculator, DifferentPhDOSCalculator

abstract type Calculator end
mutable struct SingleCalculator <: Calculator
    o::PyObject
end
mutable struct SamePhDOSCalculator <: Calculator
    o::PyObject
end
mutable struct DifferentPhDOSCalculator <: Calculator
    o::PyObject
end

@pyinterface Calculator

end
