module Settings

using PyCall: PyObject

using PyQHA: qha_settings, @pyinterface

export from_yaml

mutable struct Config
    o::PyObject
end
Config(args::AbstractDict...) = Config(qha_settings.Settings(args...))

Base.getindex(config::Config, key) = PyObject(config).get(key)
Base.setindex!(config::Config, value, key) = PyObject(config).__setitem__(key, value)

@pyinterface Config

from_yaml(file) = Config(qha_settings.from_yaml(file))

end
