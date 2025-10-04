
class monitor;
  
  virtual intf vif;
  
  mailbox mon2scb;

  covergroup cg;
	A1: coverpoint vif.a;
	A2: coverpoint vif.b;
	A3: cross A1, A2;
  endgroup
  
  function new( virtual intf vif, mailbox mon2scb );
    this.vif 		= vif;
    this.mon2scb 	= mon2scb;
    cg = new();
  endfunction
  
  task main();
    //transaction trans;
    repeat( 10 )
      #1
      begin
        //#1;
        transaction trans;
        trans = new();
        trans.a		= vif.a;
        trans.b		= vif.b;
        trans.sum	= vif.sum;
        trans.carry	= vif.carry;
        mon2scb.put( trans );
	cg.sample();
        trans.display("MONITOR DATA");
      end
  endtask
  
endclass
