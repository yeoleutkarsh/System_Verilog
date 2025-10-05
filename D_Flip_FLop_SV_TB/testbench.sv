`include "interface.sv"
`include "test.sv"

module testbench;
  logic rst, clk;
  
  intf intff ( .clk(clk), .rst(rst) );
  test t1 ( intff );
  
  d_ff uut (
    .clk	( intff.clk ),
    .rst	( intff.rst ),
    .d  	( intff.d ),
    .q  	( intff.q ),
    .qbar 	( intff.qbar )
  );
  
  initial begin
    clk = 0;
    forever #2 clk = ~clk;
  end
  
  initial begin
    intff.d = 0;
    rst = 1;
    #5;
    rst = 0;
    #200;
    $finish();
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
  
endmodule
