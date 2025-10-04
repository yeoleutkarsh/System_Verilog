
class generator;
  
  transaction trans;
  
  mailbox gen2driv;
  
  function new( mailbox gen2driv );
    this.gen2driv = gen2driv;
  endfunction
  
  task main();
    repeat( 10 )
      begin
        trans = new();
        assert (trans.randomize()) 
	begin
  		$display("Randomization SUCCESS: a=%0d, b=%0d", trans.a, trans.b);
	end 
	else 
	begin
    		$error("Randomization FAILED for transaction!");
	end
        //trans.display(" GENERATOR DATA ");
        gen2driv.put( trans );	// putting the randomize data in the mailbox.
      end
  endtask

endclass
