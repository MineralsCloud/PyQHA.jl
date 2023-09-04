using CSV: File
using Tables: getcolumn, columnnames

export read_f_tv, read_f_tp

function read_f_tv(path)
    iterable = File(path; delim=" ", header=1, ignorerepeated=true)
    header = columnnames(iterable)  # Only read header
    iterator = Iterators.Stateful(iterable)
    volumes = Pressure(map(Base.Fix1(parse, Float64) ∘ string, header[2:end]))
    temperatures, data = Float64[], Vector{Float64}[]
    for row in iterator
        temperature, datum... = [only(getcolumn(row, col)) for col in header]
        push!(temperatures, temperature)
        push!(data, datum)
    end
    temperatures = Temperature(temperatures)
    return DimArray(reduce(hcat, data)', (temperatures, volumes))
end

function read_f_tp(path)
    iterable = File(path; delim=" ", header=1, ignorerepeated=true)
    header = columnnames(iterable)  # Only read header
    iterator = Iterators.Stateful(iterable)
    pressures = Pressure(map(Base.Fix1(parse, Float64) ∘ string, header[2:end]))
    temperatures, data = Float64[], Vector{Float64}[]
    for row in iterator
        temperature, datum... = [only(getcolumn(row, col)) for col in header]
        push!(temperatures, temperature)
        push!(data, datum)
    end
    temperatures = Temperature(temperatures)
    return DimArray(reduce(hcat, data)', (temperatures, pressures))
end

function save_x_tp(df, t, desired_pressures_gpa, p_sample_gpa, outfile_name)
    return qha_basicio_out.save_x_tp(
        df, t, desired_pressures_gpa, p_sample_gpa, outfile_name
    )
end

function save_x_tv(df, t, desired_pressures_gpa, p_sample_gpa, outfile_name)
    return qha_basicio_out.save_x_tv(
        df, t, desired_pressures_gpa, p_sample_gpa, outfile_name
    )
end

save_to_output(fn_output, text) = qha_basicio_out.save_to_output(fn_output, text)

make_starting_string() = qha_basicio_out.make_starting_string()
