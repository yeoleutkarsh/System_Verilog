
module d_ff( clk, rst, d, q, qbar );
  input clk, rst;
  input d;
  output reg q;
  output qbar;
  
  always @( posedge clk )
    begin
      if( rst )
        q	<= 1'b0;
      else
        q 	<= d;
    end
  assign qbar = ~q;
endmodule
