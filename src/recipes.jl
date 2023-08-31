using RecipesBase: @recipe, @userplot, @series

@userplot TempVolPlot
@recipe function f(plot::TempVolPlot)
    # See http://juliaplots.org/RecipesBase.jl/stable/types/#User-Recipes-2
    path = first(plot.args)
    rawdata = read_f_tv(path)
    volumes = map(Base.Fix1(parse, Float64), names(rawdata)[2:end])
    r = length(plot.args) == 2 ? plot.args[end] : range(1; stop=size(rawdata, 1), length=5)
    r = convert(StepRange{Int64,Int64}, r)
    temperatures = collect(rawdata[r, 1])
    data = (collect(values(row)) for row in eachrow(rawdata[r, 2:end]))
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
    for (temperature, datum) in Iterators.reverse(zip(temperatures, data))
        @series begin
            seriestype --> :path
            z_order --> :back
            label --> "T=" * string(temperature) * " K"
            volumes, datum
        end
        index = argmin(datum)
        @series begin
            seriestype --> :scatter
            label := ""
            [volumes[index]], [datum[index]]
        end
    end
end
