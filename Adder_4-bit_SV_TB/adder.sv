
module adder( clk, rst, in1, in2, out );
    input clk, rst;
    input [3:0] in1, in2;
    output reg [4:0] out;

    always @( posedge clk )
    begin
        if( rst )
            out <= 5'd0;
        else
            out <= in1 + in2;
    end
endmodule
