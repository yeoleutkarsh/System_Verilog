// Triggering of covergroup using sample method
class pkt;
  rand bit [2:0] a;

  covergroup cg;
    A1: coverpoint a;
  endgroup

  function new();
    cg = new();
  endfunction

endclass

module test1();
  pkt p;
  initial begin
    p = new();
    repeat( 8 )
    begin
      p.randomize();
      p.cg.sample();
      $display("a=%0d",p.a);
    end
  end
endmodule

// Triggering of covergroup using clock
class pkt1;
  rand bit [2:0] a;
endclass

module test2();
  pkt1 p;
  bit clk;

  always #5 clk = ~clk;

  covergroup cg @( posedge clk );
    A1: coverpoint p.a;
  endgroup

  initial begin
    cg c = new();

    repeat( 10 )
    begin
      p = new();
      p.randomize();
      $display($time," -> a=%0d",p.a);
      #10;
    end
  end

  initial begin
    #100;
    $finish();
  end

endmodule

// Triggering of covergroup using the event
class pkt2;
  rand bit [2:0] a;
endclass

module test3();
  pkt2 p;
  event evt;

  covergroup cg @( evt );
    A1: coverpoint p.a;
  endgroup

  initial begin
    cg c = new();
    repeat ( 10 )
    begin
      p = new();
      p.randomize();
      -> evt;   // event triggering
      $display("a=%0d",p.a);
    end
  end
endmodule
*/

// We can trigger the covergroup using the 3 methods.
// 1) Using the Sample();
// 2) Using the clock
// 3) using the event

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////****************************************/////////////////////////////////////////////////////////
// Coverpoint
class pkt_1;
  rand bit [3:0] a;
  rand bit [3:0] b;
  rand bit [7:0] c;
  function void display();
    $display("a=%0d and b=%0d", a, b);
  endfunction
endclass

module test_1();
  pkt_1 p;
  covergroup cg;
    A1: coverpoint p.a;
    A2: coverpoint p.b;
  endgroup
  initial begin
    cg c = new();
    p = new();
    repeat ( 5 )
    begin
      p.randomize();
      p.display();
      c.sample();
    end
  end
endmodule

// Coverpoint Part Select
module test_2();
  pkt_1 p;
  covergroup cg;
    A1: coverpoint p.c[3:1];
  endgroup
  initial begin
    cg c = new();
    p = new();
    p.randomize();
    $display("C=%0b",p.c);
    c.sample();
    $display("C=%0b", p.c);
  end
endmodule

// Coverpoint expressions
class pkt_2;
  rand bit [3:0] a;
  rand bit [3:0] b;
  constraint c1{
    a == 5;
    b == 4;
  }
endclass
module test_3();
  pkt_2 p;
  covergroup cg;
    A1: coverpoint p.a + p.b;
  endgroup
  initial begin
    cg c = new();
    p = new();
    p.randomize();
    c.sample();
  end
endmodule

// Coverpoint multiple expression
module test_4();
  pkt_2 p;
  covergroup cg;
    A1: coverpoint { p.a - p.b , p.a + p.b };
  endgroup
  initial begin
    cg c = new();
    p = new();
    p.randomize();
    c.sample;
  end
endmodule

// Coverpoint function call
class pkt_3;
  rand bit [0:3] a;
  rand bit [0:3] b;
  function sum ( bit c );
    return c;
  endfunction
  constraint c1{
    a == 5;
    b == 5;
  }
  function bit [3:0] carry ( bit [3:0] d, e );
    if ( d == 5 && e == 5 ) carry = 5;
    if ( d == 6 && e == 6 ) carry = 6;
    return carry;
  endfunction
endclass

module test_5;
  pkt_3 p;
  covergroup cg;
    A1: coverpoint p.sum( p.a );
    A2: coverpoint p.carry( 5, 5 );
  endgroup
  initial begin
    cg c = new();
    p = new();
    repeat( 3 )
    begin
      p.randomize();
      $display("a=%0d and b=%0d", p.a, p.b);
      c.sample();#1;
    end
  end
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////*******************************************************////////////////////////////////////////////////
// Use of Explicit Bins
program top;
  bit [2:0] a;
  covergroup cg;
    A1: coverpoint a{
        bins a_bin = { 0, 1, 2, 3, 4, 5};
    }
  endgroup
  cg c = new();
  initial begin
    for( int i=0; i<4; i++)
    begin
      a = i;
      $display("a=%0b", a);
      c.sample();
    end
  end
endprogram
/////////////////////////////// Example 2
program top_1;
  bit [0:2] y;
  bit [0:2] values[$] = '{1,7};
  covergroup cg;
    A1: coverpoint y{
        bins a = {0,1};
        bins b = {2,3};
        bins c = {4,5};
        bins d = {6,7};
    }
  endgroup
  cg c = new();
  initial begin
    foreach( values[i] )
    begin
      y = values[i];
      c.sample();
    end
  end
endprogram

/////////////////////////////////////////////////////// Example 3
typedef enum{ write, read, w_r} type_id;
program top1;
  type_id id;
  covergroup cg;
    A1: coverpoint id{
        bins write = {0};
        bins read  = {1};
        bins w_r   = {2};
    }
  endgroup
  cg c = new();
  initial begin
    id = write;
    c.sample();
    $display("%s::id=%0d", id, id);
  end
endprogram

//////////////////////////////////////////////////// Example 4
program top2;
  bit [2:0] a;
  covergroup cg;
    A1: coverpoint a{
        bins name[8] = {[0:7]};
    }
  endgroup
  cg c = new();
  initial begin
    for( int i=0; i<8; i++ )
    begin
      a = i;
      $display("a=%0d",a);
      c.sample();
    end
  end
endprogram

///////////////////////////////////////////////////////// Array Of Bins Example 1
class pkt0;
  randc bit [7:0] a;
  constraint c1{
      a >= 0;
      a <= 15;
  }
endclass
module top3;
  pkt0 p;
  covergroup cg;
    A1: coverpoint p.a {
        bins name[8] = {[0:15]};  // name[0] = {0,1}, name[1] = {2,3},........, name[7] = {14,15} ;
    }
  endgroup
  initial begin
    cg c = new();
    repeat( 5 )
    begin
      p = new();
      p.randomize();
      c.sample();
      $display("a=%0d",p.a);
    end
  end
endmodule
////////////////////////////////////////////////////////// Array of bins example 2
class pkt01;
  randc bit [2:0] a;
endclass
module top4;
  pkt01 p;
  covergroup cg;
    A1: coverpoint p.a {
        bins name[2] = {0,2,3,4,5};
    }
  endgroup
  initial begin
    cg c = new();
    repeat( 2 )
    begin
      p = new();
      p.randomize();
      c.sample();
      $display("a=%0d", p.a);
    end
  end
endmodule
//////////////////////////////////////////////////////////////// Array of bins example 3
class pkt02;
  rand bit [3:0] a;
endclass
module top5;
  pkt02 p;
  covergroup cg;
    A1: coverpoint p.a {
        bins name[] = {1, 2, [3:10]};
    }
  endgroup
  initial begin
    cg c = new();
    repeat( 10 )
    begin
      p = new();
      p.randomize();
      c.sample();
      $display("a=%0d", p.a);
    end
  end
endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////************************************************/////////////////////////////////////////////
// How to execute coverage conditionality
// there are 2 ways
// 1) iff constuct
// 2) start, stop function

// Example 1 using iff
class pkt;
  rand bit [3:0] a;
  rand bit [3:0] b;
  constraint c1 { b==5; }
endclass

module top;
  pkt p;
  covergroup cg;
    // A1: coverpoint p.a iff ( p.b == 6 ); 
       A1: coverpoint p.a iff ( p.b == 5 ); 
  endgroup
  initial begin
    cg c = new();
    repeat( 10 )
    begin
      p = new();
      assert( p.randomize() );
      c.sample();
      $display("a=%0d and b=%0d", p.a, p.b);
    end
  end
endmodule
// stop and start function.
class pkt0;
  rand bit a;
endclass

module top1;
  bit reset;
  pkt0 p;
  covergroup cg;
    A1: coverpoint p.a { 
      bins name[1] = {1};
    }  
  endgroup
  initial begin
    cg c = new();
    p = new();
    #1 reset = 0;
    c.stop();
    #10 reset = 1;
    c.start();
    repeat( 2 )
    begin
      p.randomize();
      c.sample();
      $display("%t :: a=%0d", $time, p.a);
    end
  end
endmodule
