import AbInitioSoftwareBase: load

using .Settings: from_yaml
using .Calculators: SingleCalculator, SamePhDOSCalculator, DifferentPhDOSCalculator

export runcode

function runcode(cfgfile)
    config = from_yaml(cfgfile)

    if !isdir(config["output_directory"])
        mkpath(config["output_directory"])
    end
    config["qha_output"] = joinpath(config["output_directory"], "output.txt")
    if isfile(config["qha_output"])
        rm(config["qha_output"])
    end
    save_to_output(config["qha_output"], make_starting_string())

    str = lowercase(config["calculation"])
    if str == "single"
        calculator = SingleCalculator(config)
        println("You have single-configuration calculation assumed.")
    elseif str == "same phonon dos"
        calculator = SamePhDOSCalculator(config)
        println(
            "You have multi-configuration calculation with the same phonon DOS assumed.",
        )
    elseif str == "different phonon dos"
        calculator = DifferentPhDOSCalculator(config)
        println(
            "You have multi-configuration calculation with different phonon DOS assumed.",
        )
    else
        error("""
              The 'calculation' in your settings in not recognized! It must be one of:
              'single', 'same phonon dos', 'different phonon dos'!
              """)
    end

    calculator.read_input()
    println("Caution: If negative frequencies found, they are currently treated as 0!")

    calculator.refine_grid()
    calculator.desired_pressure_status()
    temperature_array = calculator.temperature_array
    desired_pressures_gpa = calculator.desired_pressures_gpa
    temperature_sample = calculator.temperature_sample_array
    p_sample_gpa = calculator.pressure_sample_array

    results_folder = config["output_directory"]
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
    save_x_tv(
        calculator.f_tv_ev,
        temperature_array,
        calculator.finer_volumes_ang3,
        temperature_sample,
        file_ftv_fitted,
    )

    file_ftv_non_fitted = joinpath(results_folder, "f_tv_nonfitted_ev_ang3.txt")
    save_x_tv(
        calculator.vib_ev,
        temperature_array,
        calculator.volumes_ang3,
        temperature_sample,
        file_ftv_non_fitted,
    )

    file_ptv_gpa = joinpath(results_folder, "p_tv_gpa.txt")
    save_x_tv(
        calculator.p_tv_gpa,
        temperature_array,
        calculator.finer_volumes_ang3,
        temperature_sample,
        file_ptv_gpa,
    )

    file_stv_j = joinpath(results_folder, "s_tv_j.txt")
    save_x_tv(
        calculator.s_tv_j,
        temperature_array,
        calculator.finer_volumes_ang3,
        temperature_sample,
        file_stv_j,
    )

    for idx in config["thermodynamic_properties"]
        if idx in ("F", "G", "H", "U")
            attr_name = calculation_option[idx] * "_" * config["energy_unit"]
            file_name = attr_name * ".txt"
            file_dir = joinpath(results_folder, file_name)
            save_x_tp(
                getproperty(calculator, attr_name),
                temperature_array,
                desired_pressures_gpa,
                p_sample_gpa,
                file_dir,
            )
        elseif idx == "V"
            v_bohr3 = calculation_option[idx] * "_bohr3"
            file_name_bohr3 = v_bohr3 * ".txt"
            file_dir_au = joinpath(results_folder, file_name_bohr3)
            v_ang3 = calculation_option[idx] * "_ang3"
            file_name_ang3 = v_ang3 * ".txt"
            file_dir_ang3 = joinpath(results_folder, file_name_ang3)
            save_x_tp(
                getproperty(calculator, v_bohr3),
                temperature_array,
                desired_pressures_gpa,
                p_sample_gpa,
                file_dir_au,
            )
            save_x_tp(
                getproperty(calculator, v_ang3),
                temperature_array,
                desired_pressures_gpa,
                p_sample_gpa,
                file_dir_ang3,
            )
        elseif idx in ("Cv", "Cp", "Bt", "Btp", "Bs", "alpha", "gamma")
            attr_name = calculation_option[idx]
            file_name = attr_name * ".txt"
            file_dir = joinpath(results_folder, file_name)
            save_x_tp(
                getproperty(calculator, attr_name),
                temperature_array,
                desired_pressures_gpa,
                p_sample_gpa,
                file_dir,
            )
        end
    end
end
