transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint1\ -\ ALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint1 - ALU/full_adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint1\ -\ ALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint1 - ALU/RCA_16bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint1\ -\ ALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint1 - ALU/mux.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint1\ -\ ALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint1 - ALU/mux_16bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint1\ -\ ALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint1 - ALU/mux_32bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint1\ -\ ALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint1 - ALU/addition.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint1\ -\ ALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint1 - ALU/CSA_32bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint1\ -\ ALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint1 - ALU/subtraction.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint1\ -\ ALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint1 - ALU/alu.v}

vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint1\ -\ ALU {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint1 - ALU/alu_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  alu_tb

add wave *
view structure
view signals
run -all
