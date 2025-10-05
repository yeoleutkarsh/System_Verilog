

class transaction;
  rand bit d;
  bit q;
  bit qbar;
  
  constraint c1 {
    d dist { 1 := 80, 0 := 20 };
  }
  
  function void display( string name );
    $display("%s\t:: d=%0d q=%0d qbar=%0d", name, d, q, qbar);
  endfunction
  
    
endclass
