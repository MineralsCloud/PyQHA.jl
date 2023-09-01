using DimensionalData: DimensionalData, Dimensions, DimArray, @dim

export Temperature, Volume, Pressure, FreeEnergy

@dim Temperature "Temperature"
@dim Volume "Volume"
@dim Pressure "Pressure"

FreeEnergy(data::AbstractMatrix, temperature::Temperature, pressure::Pressure) =
    DimArray(data, (temperature, pressure); name="free energy")
FreeEnergy(data::AbstractMatrix, pressure::Pressure, temperature::Temperature) =
    DimArray(data, (pressure, temperature); name="free energy")
FreeEnergy(data::AbstractMatrix, temperature::Temperature, volume::Volume) =
    DimArray(data, (temperature, volume); name="free energy")
FreeEnergy(data::AbstractMatrix, volume::Volume, temperature::Temperature) =
    DimArray(data, (volume, temperature); name="free energy")
