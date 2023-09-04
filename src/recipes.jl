using RecipesBase: @recipe, @userplot, @series

@userplot TempVolPlot
@recipe function f(plot::TempVolPlot)
    # See http://juliaplots.org/RecipesBase.jl/stable/types/#User-Recipes-2
    rawdata = first(plot.args)
    temperatures, volumes = axes(rawdata)
    r = length(plot.args) == 2 ? last(plot.args) : range(1; stop=size(rawdata, 1), length=5)
    r = convert(StepRange{Int64,Int64}, r)
    free_energies = eachrow(rawdata[r, :])  # At each temperature, the free energy is a function of volume.
    size --> (800, 500)
    markersize --> 2
    markerstrokecolor --> :auto
    markerstrokewidth --> 0
    xlims --> extrema(volumes)
    xguide --> "volume"
    yguide --> "free energy"
    guidefontsize --> 11
    tickfontsize --> 9
    legendfontsize --> 9
    legend_foreground_color --> nothing
    legend_position --> :top
    frame --> :box
    margin --> (1.3, :mm)
    grid --> nothing
    for (temperature, free_energy) in Iterators.reverse(zip(temperatures, free_energies))  # To plot temperature from low to high
        @series begin
            primary := true  # Main series
            seriestype --> :path
            z_order --> :back
            label --> raw"$T=" * string(temperature) * raw"\,$K"
            volumes, free_energy
        end
        index = argmin(free_energy)  # The lowest free energy
        @series begin
            primary := false  # See https://discourse.julialang.org/t/what-does-the-primary-attribute-do-and-how-to-plot-curves-with-scatters-added-onto-it-in-plots-jl/93486/2
            seriestype --> :scatter
            label --> ""
            [volumes[index]], [free_energy[index]]
        end
    end
end

@userplot PressTempPlot
@recipe function f(plot::PressTempPlot; reverse=false)
    # See http://juliaplots.org/RecipesBase.jl/stable/types/#User-Recipes-2
    rawdata = first(plot.args)
    pressures, temperatures = axes(rawdata)
    r = length(plot.args) == 2 ? last(plot.args) : range(1; stop=size(rawdata, 1), length=5)
    r = convert(StepRange{Int64,Int64}, r)
    data = eachrow(rawdata[r, :])  # At each pressure, the data is a function of temperature.
    size --> (800, 500)
    markersize --> 2
    markerstrokecolor --> :auto
    markerstrokewidth --> 0
    xlims --> extrema(temperatures)
    xguide --> "volume"
    guidefontsize --> 11
    tickfontsize --> 9
    legendfontsize --> 9
    legend_foreground_color --> nothing
    legend_position --> :bottom
    frame --> :box
    margin --> (1.3, :mm)
    grid --> nothing
    plot_in_order = reverse ? Iterators.reverse : identity
    for (pressure, datum) in plot_in_order(zip(pressures, data))
        @series begin
            seriestype --> :path
            label --> raw"$P=" * string(pressure) * raw"\,$GPa"
            temperatures, datum
        end
    end
end
