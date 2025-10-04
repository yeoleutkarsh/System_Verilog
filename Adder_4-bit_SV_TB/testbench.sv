`include "interface.sv"
`include "test.sv"

module testbench;
    logic rst, clk;

    intf if_uut ( .clk(clk), .rst(rst) );
    test t1 ( if_uut );
    adder dut (
        .clk( if_uut.clk ),
        .rst( if_uut.rst ),
        .in1( if_uut.in1 ),
        .in2( if_uut.in2 ),
        .out( if_uut.out )
    );

    initial begin
        clk = 0;
        forever #2 clk = ~clk;
    end

    initial begin
        rst = 1;
        #5;
        rst = 0;
        #300;
        $finish();
    end
endmodule
