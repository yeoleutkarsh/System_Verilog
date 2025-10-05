
class monitor;
  virtual intf vif;
  mailbox #( transaction ) mon2scb;
  
  covergroup cg;
    A1 : coverpoint vif.d;
  endgroup
  
  function new( virtual intf vif,
  				mailbox #( transaction ) mon2scb
   );
    	this.vif		= vif;
    	this.mon2scb	= mon2scb;
    	cg 				= new();
  endfunction
  
  task main();
    forever begin
      transaction trans;
      wait( !vif.rst );
      @( posedge vif.clk );
      trans = new();
      trans.d 		= vif.d;
      @( posedge vif.clk );
      trans.q 		= vif.q;
      trans.qbar 	= vif.qbar;
      mon2scb.put( trans );
      cg.sample();
      trans.display("MONITOR VALUES    ");
    end
  endtask
  
endclass
