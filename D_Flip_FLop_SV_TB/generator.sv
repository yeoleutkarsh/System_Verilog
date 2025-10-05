
class generator;
  transaction trans;
  mailbox #( transaction ) gen2drv;
  mailbox #( transaction ) gen2scb;
  int no_of_txn;
  
  function new( mailbox #( transaction ) gen2drv,
  				mailbox #( transaction ) gen2scb
   );
    	this.gen2drv = gen2drv;
    	this.gen2scb = gen2scb;
  endfunction
  
  task main();
    repeat( no_of_txn ) begin
      trans = new();
      assert( trans.randomize() );
      gen2drv.put( trans );
      gen2scb.put( trans );
      trans.display("GENERATOR VALUES");
    end
    $display("-----------------------------------------------------------");
  endtask
  
endclass
