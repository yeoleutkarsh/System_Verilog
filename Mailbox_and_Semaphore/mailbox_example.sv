/*
// 1) Example code for the parameterized mailbox.
class and_tx;   // transaction class
  rand bit [3:0] a;
  rand bit [3:0] b;
  function void print();
    $display("A=%0d and B=%0d", a, b);
  endfunction
endclass

class and_gen;  // generator class
  and_tx tx;
  int c = 5;
  task run( mailbox #(and_tx) gen2bfm );
    repeat( 10 )
    begin
      tx = new();
      tx.randomize();
      gen2bfm.put(c);
    end
  endtask
endclass

class and_bfm;  // driver class or bfm class
  and_tx tx;
  int d;
  task run( mailbox #(and_tx) gen2bfm );
    repeat( 10 )
    begin
      gen2bfm.get(d);
      $display("D=%0d", d);
    end
  endtask
endclass

class and_env;    // environment class
  and_gen gen;
  and_bfm bfm;

  mailbox #(and_tx) gen2bfm;

  function new();
    gen2bfm = new();
    gen = new();
    bfm = new();
  endfunction

  task run();
    fork
      gen.run( gen2bfm );
      bfm.run( gen2bfm );
    join
  endtask
endclass

module top;
  and_env env;
  initial begin
    env = new();
    env.run();
  end
endmodule
*/
/*
// 2) Example code for the parameterized code.
class and_tx;   // transaction class
  rand bit [3:0] a;
  rand bit [3:0] b;
  function void print();
    $display("A=%0d and B=%0d", a, b);
  endfunction
endclass

class and_gen;  // generator class
  and_tx tx;
  int c = 5;
  task run( mailbox #(and_tx) gen2bfm );
    repeat( 3 )
    begin
      tx = new();
      tx.randomize();
      gen2bfm.put( tx );
    end
  endtask
endclass

class and_bfm;  // driver class or bfm class
  and_tx tx;
  int d;
  task run( mailbox #(and_tx) gen2bfm );
    repeat( 3 )
    begin
      gen2bfm.get( tx );
      tx.print();  
    end
  endtask
endclass

class and_env;    // environment class
  and_gen gen;
  and_bfm bfm;

  mailbox #(and_tx) gen2bfm;

  function new();
    gen2bfm = new();  // unbounded
    gen = new();
    bfm = new();
  endfunction

  task run();
    fork
      gen.run( gen2bfm );
      bfm.run( gen2bfm );
    join
  endtask
endclass

module top;
  and_env env;
  initial begin
    env = new();
    env.run();
  end
endmodule
*/
/*
// 3) Parameterized mailbox of int type.
class and_tx;   // class transaction
  rand bit [3:0] a;
  rand bit [3:0] b;
  function void print();
    $display("A=%0d and B=%0d", a,b);
  endfunction
endclass

class and_gen;    // class generator
  and_tx tx;
  int c = 5;
  task run( mailbox #(int) gen2bfm );
    repeat( 3 )
    begin
      tx = new();
      tx.randomize();
      gen2bfm.put( c );
    end
  endtask
endclass

class and_bfm;    // class driver
  and_tx tx;
  int d;
  task run( mailbox #(int) gen2bfm );
    repeat( 3 )
    begin
      gen2bfm.get( d );
      $display("D=%0d", d);
    end
  endtask
endclass

class and_env;  // class environment
  and_gen gen;
  and_bfm bfm;

  mailbox #(int) gen2bfm;

  function new();
    gen2bfm = new();
    gen = new();
    bfm = new();
  endfunction

  task run();
    fork
      gen.run( gen2bfm );
      bfm.run( gen2bfm );
    join
  endtask
endclass

module top;
  and_env env;
  initial begin
    env = new();
    env.run();
  end
endmodule
*/

// 4) Differance between the UNBOUNDED MAILBOX and BOUNDED MAILBOX
// 4.1] UNBOUNDED MAILBOX exmaple.
/*
module top;
  mailbox mbx;

  class producer;
    task run();
      for( int i=1; i<4; i++)
      begin
        mbx.put( i );
        $display("%0t :: PRODUCER :: after put (%0d)", $time, i);
      end
    endtask
  endclass

  class consumer;
    task run();
      int i;
      repeat( 3 )
      begin
       #1 mbx.get( i );
        $display("%0t :: CONSUMER :: after get (%0d)", $time, i);
      end
    endtask
  endclass

  producer p;
  consumer c;

  initial begin
    mbx = new();  // unbounded mailbox.
    p = new();
    c = new();
    fork
      p.run();  // running both class parallel.
      c.run();
    join
  end
endmodule
*/
// 4.2] BOUNDED mailbox example code.
/*
module top;
  mailbox mbx;

  class producer;
    task run();
      for( int i=1; i<4; i++)
      begin
        mbx.put( i );
        $display("%0t :: PRODUCER :: after put (%0d)", $time, i);
      end
    endtask
  endclass

  class consumer;
    task run();
      int i;
      repeat( 3 )
      begin
        #1 mbx.get( i );
        $display("%0t :: CONSUMER :: after get (%0d)", $time, i);
      end
    endtask
  endclass

  consumer c;
  producer p;
  initial begin
    mbx = new(1); // bounded mailbox
    p = new();
    c = new();
    fork
      p.run();
      c.run();
    join
  end
endmodule
*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Example 1 put() and get() method exmaple.
/*
class and_tx;   // transaction class.
  rand bit [3:0] a;
  rand bit [3:0] b;
  function void print();
    $display("A=%0d and B=%0d", a, b);
  endfunction
endclass

class and_gen;    // generator class.
  and_tx tx;
  task run( mailbox #(and_tx) gen2bfm );
    repeat( 3 )
    begin
      tx = new();
      tx.randomize();
      tx.print();
      gen2bfm.put( tx );
      $display("PUT_method inside generator.");
    end
  endtask
endclass

class and_bfm;    // driver class
  and_tx tx;
  task run( mailbox #(and_tx) gen2bfm );
    repeat ( 3 )
    begin
      gen2bfm.get( tx );
      tx.print();
      $display("GET_method inside bfm.");
    end
  endtask
endclass

class and_env;    // environment class
  and_gen gen;
  and_bfm bfm;

  mailbox #(and_tx) gen2bfm;

  function new();
    gen2bfm = new(3);
    gen = new();
    bfm = new();
  endfunction

  task run();
    fork
      gen.run( gen2bfm );
      bfm.run( gen2bfm );
    join
  endtask
endclass

module top;
  and_env env;
  initial begin
    env = new();
    env.run();
  end
endmodule
*/
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Example 2 Simple example for put and try_put methods.
/*
module top;
  mailbox mbx;

  class producer;
    task run();
      for( int i=1; i<4; i++)
      begin
        mbx.put( i );
        $display("%0t :: PRODUCER :: after put ( %0d )", $time, i);
      end
    endtask
  endclass

  class consumer;
    task run();
      int i;
      repeat( 3 )
      begin
        #1 mbx.try_get(i);
        $display("%0t :: CONSUMER :: after get ( %0d )", $time, i);
      end
    endtask
  endclass

  producer p;
  consumer c;

  initial begin
    mbx = new(1);
    p = new();
    c = new();
    fork
      p.run();
      c.run();
    join
  end
endmodule
*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Example 3 code for the try_put anf try_get.
/*
class and_tx;   // class transaction
  rand bit [3:0] a;
  rand bit [3:0] b;
  function void print();
    $display("A=%0d and B=%0d", a, b);
  endfunction
endclass
class and_gen;  // class generator
  and_tx tx;
  int c = 5;
  task run(mailbox #( and_tx ) gen2bfm);
    repeat( 10 )
    begin
      tx = new();
      tx.randomize();
      if( gen2bfm.try_put( tx ) )
        $display("try_put method inside generator");
      else
        $display("TRY_PUT ::: NOt Working.");
    end
  endtask
endclass
class and_bfm;  // class driver
  and_tx tx;
  task run( mailbox #(and_tx) gen2bfm );
    repeat( 10 )
    begin
      if( gen2bfm.try_get( tx ) )
      begin
        tx.print();
        $display("Try_get method inside bfm.");
        $display("No :: of :: MSG :: %0d", gen2bfm.num());
      end
      else
      begin
        $display("TRY_GET:::NOTWORKING");
        $display("NO::OF::MSG::%0d",gen2bfm.num());
      end
    end
  endtask
endclass
class and_env;  // class enviroment
  and_gen gen;
  and_bfm bfm;
  mailbox #(and_tx) gen2bfm;
  function new();
    gen2bfm = new(5);
    gen = new();
    bfm = new();
  endfunction
  task run();
    fork
      gen.run( gen2bfm );
      bfm.run( gen2bfm );
    join
  endtask
endclass
module top;
  and_env env;
  initial begin
    env = new();
    env.run();
  end
endmodule
*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Example 4 put and try_get example.
/*
class and_tx;   // class transaction
  rand bit [3:0] a;
  rand bit [3:0] b;
  function void print();
    $display("A=%0d and B=%0d", a, b);
  endfunction
endclass
class and_gen;  // class generator
  and_tx tx;
  task run( mailbox #(and_tx) gen2bfm );
    repeat( 10 )
    begin
      tx = new();
      assert( tx.randomize() );
      gen2bfm.put( tx );
      $display("Put inside generator.");
    end
  endtask
endclass
class and_bfm;  // class driver
  and_tx tx;
  task run( mailbox #(and_tx) gen2bfm );
    repeat( 10 )
    begin
      if( gen2bfm.try_get( tx ) )
      begin
        tx.print();
        $display("try_get method inside bfm.");
        $display("N0 :: of :: MSG ::%0d", gen2bfm.num());
      end
      else
      begin
        $display("Try_get :: Not working.");
        $display("N0 :: of :: MSG ::%0d", gen2bfm.num());
      end
    end
  endtask
endclass
class and_env;    // class environment
  and_gen gen;
  and_bfm bfm;

  mailbox #(and_tx) gen2bfm;

  function new();
    gen2bfm = new(5);
    gen = new();
    bfm = new();
  endfunction

  task run();
    fork
      gen.run( gen2bfm );
      bfm.run( gen2bfm );
    join
  endtask
endclass
module top;
  and_env env;
  initial begin
    env = new();
    env.run();
  end
endmodule
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Example 5 try_put and get method.
/*
class and_tx;   // class transaction
  rand bit [3:0] a;
  rand bit [3:0] b;
  function void print();
    $display("A=%0d and B=%0d", a, b);
  endfunction
endclass
class and_gen;  // class generator
  and_tx tx;
  task run( mailbox #(and_tx) gen2bfm );
    repeat( 10 )
    begin
      tx = new();
      tx.randomize();
      if( gen2bfm.try_put( tx ))
        $display("try_put method inside generator.");
      else
        $display("TRY_PUT :: NOT WORKING");
    end
  endtask
endclass
class and_bfm;  // class driver
  and_tx tx;
  task run( mailbox #(and_tx) gen3bfm);
    repeat( 10 )
    begin
      gen3bfm.get( tx );
      tx.print();
      $display("Get method inside bfm");
      $display("N0::of::msg::%0d", gen3bfm.num());
    end
  endtask
endclass
class and_env;    // class environment
  and_gen gen;
  and_bfm bfm;
  mailbox #(and_tx) gen2bfm;
  function new();
    gen2bfm = new(5);
    gen = new();
    bfm = new();
  endfunction
  task run();
    fork
      gen.run( gen2bfm );
      bfm.run( gen2bfm );
    join
  endtask
endclass
module top;
  and_env env;
  initial begin
    env = new();
    env.run();
  end
endmodule
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Example 6 put and peek methods.
/*
class and_tx;   // class transaction
  rand bit [3:0] a;
  rand bit [3:0] b;
  function void print();
    $display("A=%0d and B=%0d", a, b);
  endfunction
endclass

class and_gen;
  and_tx tx;
  task run ( mailbox #(and_tx) gen2bfm );
    repeat( 3 )
    begin
      tx = new();
      tx.randomize();
      tx.print();
      gen2bfm.put( tx );
      $display("put method inside fenerator.");
    end
  endtask
endclass

class and_bfm;
  and_tx tx;
  task run( mailbox #(and_tx) gen2bfm );
    repeat( 3 )
    begin
      gen2bfm.peek( tx );
      tx.print();
      $display("get method inside bfm.");
    end
  endtask
endclass

class and_env;
  and_gen gen;
  and_bfm bfm;
  mailbox #(and_tx) gen2bfm;
  function new();
    gen2bfm = new(2);
    gen = new();
    bfm = new();
  endfunction

  task run();
    fork
      gen.run( gen2bfm );
      bfm.run( gen2bfm );
    join
  endtask
endclass

module top;
  and_env env;
  initial begin
    env = new();
    env.run();
  end
endmodule
*/
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Example 7 put and try_peek
/*
module top;
  mailbox mbx;

  class producer;
    task run();
      for( int i=1; i<4; i++)
      begin
        mbx.put( i );
        $display("%0t :: PRODUCER ::  after put ( %0d )", $time, i);
      end
    endtask
  endclass

  class consumer;
    task run();
      int i;
      repeat( 3 )
      begin
        #1 mbx.try_peek( i );
        $display("%0t :: CONSUMER :: AFTER try_peek %0d", $time, i);
      end
    endtask
  endclass

  producer p;
  consumer c;
  initial begin
    mbx = new(1);
    p = new();
    c = new();
    fork
      p.run();
      c.run();
    join
  end
endmodule
*/
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// example 8 try_put and try_peek.
module top;
  mailbox mbx;

  class producer;
    task run();
      for( int i=1; i<4; i++)
      begin
        if( mbx.try_put (i) )
          $display("%0t :: PRODUCER :: after try_put %0d", $time, i);
        else
          $display("Try_put not working");
      end
    endtask
  endclass

  class consumer;
    task run();
      int i;
      repeat( 3 )
      begin
        #1 mbx.try_peek( i );
        $display("%0t :: CONSUMER :: AFTER try_peek %0d", $time, i);
      end
    endtask
  endclass

  producer p;
  consumer c;
  initial begin
    mbx = new(1);
    p = new();
    c = new();
    fork
      p.run();
      c.run();
    join
  end
endmodule
