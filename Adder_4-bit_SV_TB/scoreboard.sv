
class scoreboard;
    mailbox #( transaction ) gen2scb;
    mailbox #( transaction ) mon2scb;
    int compare_count;

    function new( mailbox #( transaction ) gen2scb,
                  mailbox #( transaction ) mon2scb
    );
        this.gen2scb     = gen2scb;
        this.mon2scb    = mon2scb;
    endfunction

    task main();
        forever begin
            transaction trans;
            transaction trans1;
            trans = new();
            mon2scb.get( trans );
            gen2scb.get( trans1 );
            if( trans1.out == trans.out )
            begin
                trans.display("SCOREBOARD VALUES ");
                $display("***************** Transaction Done *****************");
                $display("----------------------------------------------------");
            end
            else
            begin
                trans.display("SCOREBOARD VALUES");
                $display("***************** Transaction Fail *****************");
                $display("----------------------------------------------------");
            end
            compare_count++;
        end
    endtask

endclass
