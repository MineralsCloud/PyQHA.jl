module Settings

using PythonCall: PythonCall, Py
using PythonCallHelpers: @pymutable

using ..PyQHA: qha_settings

export from_yaml

@pymutable Config
Config(args::AbstractDict...) = Config(qha_settings.Settings(args...))

Base.getindex(config::Config, key) = Py(config).get(key)
Base.setindex!(config::Config, value, key) = Py(config).__setitem__(key, value)

from_yaml(file) = Config(qha_settings.from_yaml(file))

end
