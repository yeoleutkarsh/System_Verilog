`include "test.sv"
`include "interface.sv"

module tb_top;
  
  intf i_intf();
  
  test t1 ( i_intf );
  
  half_adder H1 (
    .a( i_intf.a ),
    .b( i_intf.b ),
    .s( i_intf.sum),
    .c( i_intf.carry)
  );
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
