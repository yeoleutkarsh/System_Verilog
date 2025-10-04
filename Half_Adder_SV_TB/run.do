
vlog testbench.sv half_adder.sv
vopt work.tb_top +cover=fcbest -o duv_opt
vsim -coverage duv_opt
add wave -position insertpoint sim:/tb_top/H1/*
run -all
