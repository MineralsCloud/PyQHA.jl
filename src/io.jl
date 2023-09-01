using CSV: File
using DataFrames: DataFrame

export read_f_tv, read_f_tp

function read_f_tv(path)
    file = File(path; delim=" ", header=1, ignorerepeated=true)
    df = DataFrame(file)
    volumes = Volume(map(Base.Fix1(parse, Float64), names(df)[2:end]))
    temperatures = Temperature(collect(df[:, 1]))
    return DimArray(Matrix(df[:, 2:end]), (temperatures, volumes))
end

function read_f_tp(path)
    file = File(path; delim=" ", header=1, ignorerepeated=true)
    df = DataFrame(file)
    pressures = Pressure(map(Base.Fix1(parse, Float64), names(df)[2:end]))
    temperatures = Temperature(collect(df[:, 1]))
    return DimArray(Matrix(df[:, 2:end]), (temperatures, pressures))
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
