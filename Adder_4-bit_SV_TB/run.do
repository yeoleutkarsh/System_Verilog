
vlog adder.sv testbench.sv
vopt work.testbench +cover=fcbest -o ad_opt
vsim -coverage ad_opt
add wave -position insertpoint sim:/testbench/if_uut/*
run -all

