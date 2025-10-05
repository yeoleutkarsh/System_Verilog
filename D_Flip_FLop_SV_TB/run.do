

vlog d_ff.sv testbench.sv
vopt +acc testbench -o dram_opt
vsim -msgmode both -assertdebug dram_opt
add wave /testbench/intff/acc
add wave /testbench/intff/acc2
add wave -position insertpoint sim:/testbench/intff/*
run -all
