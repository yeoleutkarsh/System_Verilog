
class monitor;
    virtual intf vif;
    mailbox #( transaction ) mon2scb;
    
    covergroup cg;
        A1: coverpoint vif.in1;
        A2: coverpoint vif.in2;
        A3: coverpoint vif.out;
    endgroup
    
    function new( virtual intf vif,
                  mailbox #( transaction ) mon2scb
    );
        this.vif        = vif;
        this.mon2scb    = mon2scb;
        cg = new();
    endfunction

    task main();
        forever begin
            transaction trans;
            wait( !vif.rst );
            @( posedge vif.clk );
            trans = new();
            trans.in1   = vif.in1;
            trans.in2   = vif.in2;
            @( posedge vif.clk );
            trans.out   = vif.out;
            mon2scb.put( trans );
            cg.sample();
            trans.display("MONITOR VALUES    ");
        end
    endtask

endclass
