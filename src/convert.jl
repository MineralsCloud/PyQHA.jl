export converter

@pymutable FromQEOutput
FromQEOutput(inp_file_list, inp_static, inp_q_points) =
    FromQEOutput(qha_input_maker.FromQEOutput(inp_file_list, inp_static, inp_q_points))

function converter(inp_file_list, inp_static, inp_q_points)
    conv = FromQEOutput(inp_file_list, inp_static, inp_q_points)
    conv.read_file_list()
    conv.read_static()
    conv.read_q_points()
    conv.read_frequency_files()
    conv.write_to_file()
end
