using .Settings: Config

using PythonCallHelpers: @pymutable

export plot

@pymutable Plotter
Plotter(config::Config) = Plotter(qha_plotting.Plotter(config))

function plot(cfgfile)
    config = from_yaml(cfgfile)

    plotter = Plotter(config)

    desired_pressures_gpa =
        range(config["P_MIN"]; length = config["NTV"], step = config["DELTA_P"])
    config["DESIRED_PRESSURES_GPa"] = desired_pressures_gpa

    results_folder = expanduser(config["output_directory"])
    calculation_option = Dict(
        "F" => "f_tp",
        "G" => "g_tp",
        "H" => "h_tp",
        "U" => "u_tp",
        "V" => "v_tp",
        "Cv" => "cv_tp_jmolk",
        "Cp" => "cp_tp_jmolk",
        "Bt" => "bt_tp_gpa",
        "Btp" => "btp_tp",
        "Bs" => "bs_tp_gpa",
        "alpha" => "alpha_tp",
        "gamma" => "gamma_tp",
    )

    file_ftv_fitted = joinpath(results_folder, "f_tv_fitted_ev_ang3.txt")
    config["f_tv_fitted"] = file_ftv_fitted

    file_ftv_non_fitted = joinpath(results_folder, "f_tv_nonfitted_ev_ang3.txt")
    config["f_tv_non_fitted"] = file_ftv_non_fitted

    file_ptv_gpa = joinpath(results_folder, "p_tv_gpa.txt")
    config["p_tv_gpa"] = file_ptv_gpa

    plotter.fv_pv()

    for idx in config["thermodynamic_properties"]
        if idx in ("F", "G", "H", "U")
            attr_name = calculation_option[idx] * "_" * config["energy_unit"]
            file_name = attr_name * ".txt"
            file_dir = joinpath(results_folder, file_name)
            config[idx] = file_dir
            plotter.plot2file(idx)
        elseif idx == "V"
            v_ang3 = calculation_option[idx] * "_ang3"
            file_name_ang3 = v_ang3 * ".txt"
            file_dir_ang3 = joinpath(results_folder, file_name_ang3)
            config[idx] = file_dir_ang3
            plotter.plot2file(idx)
        elseif idx in ("Cv", "Cp", "Bt", "Btp", "Bs", "alpha", "gamma")
            attr_name = calculation_option[idx]
            file_name = attr_name * ".txt"
            file_dir = joinpath(results_folder, file_name)
            config[idx] = file_dir
            plotter.plot2file(idx)
        end
    end
end
