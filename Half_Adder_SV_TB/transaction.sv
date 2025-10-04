class transaction;
  
  rand bit a;
  rand bit b;
  
  bit sum;
  bit carry;
  
  function void display( string name );
    $display("%s  \t\t:: a = %0d, b = %0d, sum = %0d, carry = %0d", name, a, b, sum, carry);
  endfunction
endclass
