
class driver;
    virtual intf vif;
    mailbox #( transaction ) gen2drv;
    transaction trans;

    function new( virtual intf vif,
                  mailbox #( transaction ) gen2drv 
    );
        this.gen2drv = gen2drv;
        this.vif     = vif;
    endfunction

    task main();
        forever begin
            @( posedge vif.clk );
            gen2drv.get( trans );
            vif.in1     <= trans.in1;
            vif.in2     <= trans.in2;
            @( posedge vif.clk );
            trans.out   <= vif.out;
            trans.display("DRIVER VALUES     ");
        end
    endtask
endclass
