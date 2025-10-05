
interface intf ( input logic clk, rst );
  
  logic d;
  logic q;
  logic qbar;
  
  property ppt;
    @( posedge clk ) disable iff ( rst )
    ( q == $past(d) );
  endproperty
  
  acc: assert property ( ppt )
    else
      $error("Assertion Failed q != d.");
    
   property ppt2;
     @( posedge clk ) disable iff ( rst )
     ( qbar == ~q );
   endproperty
    
    acc2: assert property ( ppt2 )	
      else
        $error("Assertion Failed qbar != q.");
              
endinterface
