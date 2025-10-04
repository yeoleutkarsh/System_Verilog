
class scoreboard;
  
  mailbox mon2scb;
  
  function new( mailbox mon2scb );
    this.mon2scb	= mon2scb;
  endfunction
  
  task main();
    transaction trans;
    repeat( 10 )
      begin
        mon2scb.get( trans );
        //trans.display(" SCOREBOARD DATA ");
        
	assert (trans.sum == (trans.a ^ trans.b)) 
	begin
        	$display("SCOREBOARD PASS :: a = %0d, b = %0d, sum = %0d", trans.a, trans.b, trans.sum);
        end 
	else begin
        	$error("SCOREBOARD FAIL: Sum mismatch (a = %0d b = %0d expected = %0d got = %0d)", trans.a, trans.b, (trans.a ^ trans.b), trans.sum);
      	end
      
      	// Carry check with action block
      	assert (trans.carry == (trans.a & trans.b)) 
	begin
        	$display("SCOREBOARD PASS :: a = %0d, b = %0d, carry = %0d", trans.a, trans.b, trans.carry);
      	end 
	else begin
        	$error("SCOREBOARD FAIL: Carry mismatch (a = %0d b = %0d expected = %0d got = %0d)", trans.a, trans.b, (trans.a & trans.b), trans.carry);
      	end	
	
        $display("////////////////// TRANSACTION DONE ////////////////////");
      end
  endtask
endclass
