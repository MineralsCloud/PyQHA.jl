using CSV: File
using Tables: matrix

export read_f_tv, read_f_tp

function read_f_tv(path)
    file = File(path; delim=" ", header=false, ignorerepeated=true)
    rawdata = matrix(file)
    volumes = Volume(rawdata[1, 2:end])
    temperatures = Temperature(map(Base.Fix1(parse, Float64), rawdata[2:end, 1]))
    return DimArray(rawdata[2:end, 2:end], (temperatures, volumes))
end

function read_f_tp(path)
    file = File(path; delim=" ", header=false, ignorerepeated=true)
    rawdata = matrix(file)
    pressures = Pressure(rawdata[1, 2:end])
    temperatures = Temperature(map(Base.Fix1(parse, Float64), rawdata[2:end, 1]))
    return DimArray(rawdata[2:end, 2:end], (temperatures, pressures))
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
