
`include "package.sv"

program test( intf vif );
    environment env;

    initial begin
        env = new( vif );
        env.gen.no_of_txn = 5;
        env.run();
    end
endprogram


