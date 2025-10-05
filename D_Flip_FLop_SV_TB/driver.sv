
class driver;
  transaction trans;
  virtual intf vif;
  mailbox #( transaction ) gen2drv;
  
  function new( virtual intf vif,
  			    mailbox #( transaction ) gen2drv
   );
    	this.vif 		= vif;
    	this.gen2drv	= gen2drv;
  endfunction
  
  task main();
    forever begin
      @( posedge vif.clk );
      gen2drv.get( trans );
      vif.d			<= trans.d;
      @( posedge vif.clk );
      trans.q		<= vif.q;
      trans.qbar	<= vif.qbar;
      trans.display("DRIVER VALUES     ");
    end
  endtask
  
endclass
