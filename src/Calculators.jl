module Calculators

using PythonCall: PythonCall
using PythonCallHelpers: @pymutable

using ..PyQHA: qha_calculator
using ..Settings: Config

export SingleCalculator, SamePhDOSCalculator, DifferentPhDOSCalculator

abstract type Calculator end
@pymutable SingleCalculator Calculator
SingleCalculator(config::Config) = SingleCalculator(qha_calculator.Calculator(config))
@pymutable SamePhDOSCalculator Calculator
SamePhDOSCalculator(config::Config) =
    SamePhDOSCalculator(qha_calculator.SamePhDOSCalculator(config))
@pymutable DifferentPhDOSCalculator Calculator
DifferentPhDOSCalculator(config::Config) =
    DifferentPhDOSCalculator(qha_calculator.DifferentPhDOSCalculator(config))

end
