export QEConverter

abstract type Converter end
@pymutable QEConverter Converter
QEConverter(inp_file_list, inp_static, inp_q_points) =
    QEConverter(qha_input_maker.FromQEOutput(inp_file_list, inp_static, inp_q_points))

function (conv::QEConverter)
    conv.read_file_list()
    conv.read_static()
    conv.read_q_points()
    conv.read_frequency_files()
    conv.write_to_file()
    return nothing
end
