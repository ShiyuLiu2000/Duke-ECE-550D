transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint4\ -\ processor {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint4 - processor/skeleton.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint4\ -\ processor {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint4 - processor/regfile.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint4\ -\ processor {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint4 - processor/processor.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint4\ -\ processor {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint4 - processor/mux.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint4\ -\ processor {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint4 - processor/dffe.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint4\ -\ processor {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint4 - processor/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint4\ -\ processor {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint4 - processor/controlCircuit.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint4\ -\ processor {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint4 - processor/decodeInstruction.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint4\ -\ processor {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint4 - processor/signExtension.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint4\ -\ processor {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint4 - processor/mux_32bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint4\ -\ processor {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint4 - processor/mux_5bits.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint4\ -\ processor {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint4 - processor/imem.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint4\ -\ processor {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint4 - processor/dmem.v}
vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint4\ -\ processor {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint4 - processor/frequency_divider_by4.v}

vlog -vlog01compat -work work +incdir+C:/Users/Daenerys/Desktop/ECE\ 550D/project/checkpoint4\ -\ processor {C:/Users/Daenerys/Desktop/ECE 550D/project/checkpoint4 - processor/skeleton_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  skeleton_tb

add wave *
view structure
view signals
run -all
