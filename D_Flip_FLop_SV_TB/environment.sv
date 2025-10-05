
class environment;
  virtual intf vif;
  
  generator		gen;
  driver		drv;
  monitor		mon;
  scoreboard	scb;
  
  mailbox #( transaction ) gen2scb;
  mailbox #( transaction ) gen2drv;
  mailbox #( transaction ) mon2scb;
  
  function new( virtual intf vif );
    this.vif = vif;
    
    gen2scb = new();
    gen2drv = new();
    mon2scb = new();
    
    gen = new( gen2drv, gen2scb );
    drv = new( vif, gen2drv );
    mon = new( vif, mon2scb );
    scb = new( gen2scb, mon2scb );
  endfunction
  
  task run();
    fork
      gen.main();
      drv.main();
      mon.main();
      scb.main();
    join_any
    wait( gen.no_of_txn == scb.compare_count );
  endtask
  
endclass
