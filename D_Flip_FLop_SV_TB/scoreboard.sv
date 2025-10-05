
class scoreboard;
  mailbox #( transaction ) gen2scb;
  mailbox #( transaction ) mon2scb;
  int compare_count;
  
  function new( mailbox #( transaction ) gen2scb,
  				mailbox #( transaction ) mon2scb
  );
    	this.gen2scb	= gen2scb;
    	this.mon2scb	= mon2scb;
  endfunction
  
  task main();
    forever begin
      transaction tr;
      transaction tr1;
      gen2scb.get( tr );
      mon2scb.get( tr1 );
      if( ( tr1.q == tr.q ) && ( tr1.qbar == tr.qbar ) )
        begin
          tr1.display("SCOREBOARD VALUES ");
          $display("******************** Transaction Done *********************");
          $display("-----------------------------------------------------------");
        end
      else
        begin
          tr1.display("SCOREBOARD VALUES ");
          $display("******************** Transaction Fail *********************");
          $display("-----------------------------------------------------------");
        end
      compare_count++;
    end
  endtask
  
endclass
