using RecipesBase: @recipe, @userplot, @series

@userplot TempVolPlot
@recipe function f(plot::TempVolPlot)
    # See http://juliaplots.org/RecipesBase.jl/stable/types/#User-Recipes-2
    path = first(plot.args)
    data = read_f_tv(path)
    volumes = map(Base.Fix1(parse, Float64), names(data)[2:end])
    r = length(plot.args) == 2 ? plot.args[end] : range(1; stop=size(data, 1), length=5)
    r = convert(StepRange{Int64,Int64}, r)
    temperatures = collect(data[r, 1])
    free_energies = collect(collect(values(row)) for row in eachrow(data[r, 2:end]))
    size --> (600, 400)
    markersize --> 2
    markerstrokecolor --> :auto
    markerstrokewidth --> 0
    xlims --> extrema(volumes)
    xguide --> "volumes"
    yguide --> "free energy"
    guidefontsize --> 10
    tickfontsize --> 8
    legendfontsize --> 8
    legend_foreground_color --> nothing
    legend_position --> :top
    frame --> :box
    palette --> :tab20
    grid --> nothing
    for (temperature, free_energy) in Iterators.reverse(zip(temperatures, free_energies))
        @series begin
            seriestype --> :path
            z_order --> :back
            label --> "T=" * string(temperature) * " K"
            volumes, free_energy
        end
        index = argmin(free_energy)
        @series begin
            seriestype --> :scatter
            label := ""
            [volumes[index]], [free_energy[index]]
        end
    end
end
