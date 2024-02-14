transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint2\ -\ fullALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint2 - fullALU/addition.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint2\ -\ fullALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint2 - fullALU/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint2\ -\ fullALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint2 - fullALU/CSA_32bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint2\ -\ fullALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint2 - fullALU/full_adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint2\ -\ fullALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint2 - fullALU/mux.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint2\ -\ fullALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint2 - fullALU/mux_16bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint2\ -\ fullALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint2 - fullALU/RCA_16bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint2\ -\ fullALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint2 - fullALU/subtraction.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint2\ -\ fullALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint2 - fullALU/is_less_than.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint2\ -\ fullALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint2 - fullALU/is_not_equal.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint2\ -\ fullALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint2 - fullALU/bitwise_or.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint2\ -\ fullALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint2 - fullALU/bitwise_and.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint2\ -\ fullALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint2 - fullALU/shift_left.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint2\ -\ fullALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint2 - fullALU/shift_right.v}

vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint2\ -\ fullALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint2 - fullALU/alu_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  alu_tb

add wave *
view structure
view signals
run -all
