// Example 1 fork_join example.
/*
module ex1;
    initial begin
        fork
            begin
                #10 $display("[%0t] P", $time);
            end
            begin
                #5 $display("[%0t] Q", $time);
            end // THESE WORKS PARALLELY.
        join
    end
endmodule
*/

// Example 2 fork_join.
/*
module ex1;
    initial begin
        fork
            begin
                #10 $display("[%0t] P", $time);
                #20 $display("[%0t] s", $time);
            end
            begin
                #5 $display("[%0t] Q", $time);
                #20 $display("[%0t] R", $time);
            end 
        join
    end
endmodule
*/
// Example 3 fork_join
/*
module ex1;
    initial begin
        fork
            #10 $display("[%0t] A", $time);
            #15 $display("[%0t] B", $time);
            begin
                #5 $display("[%0t] Q", $time);
                #12 $display("[%0t] R", $time);
            end 
        join
    end
endmodule
*/
// Example 4 fork_join_any + wait fork
/*
module ex1;
    initial begin
        fork
            #40 $display("[%0t] A", $time);
        begin
            #20 $display("[%0t] B", $time);
            #50 $display("[%0t] C", $time);
        end
            #60 $display("[%0t] TIMEOUT", $time);
        join_any
        $display("[%0t] Fork_join_any done.", $time);
        wait fork;
        $display("[%0t] Fork completely done.", $time);
    end
endmodule
*/
// Example 5 join_none + disablf fork
/*
module ex1;
    initial begin
    fork
        #15 $display("[%0t] L", $time);
        #40 $display("[%0t] M", $time);
    join_none
    $display("[%0t] Started", $time);
    #20 disable fork;
    $display("[%0t] Disabled", $time);
 end
endmodule
*/
// Example 5 Nested Forks
/*
module ex1;
    
initial begin
  fork
    begin
      #12 $display("[%0t] A1", $time);
      #8  $display("[%0t] A2", $time);
    end
    fork
      #5  $display("[%0t] B1", $time);
      #25 $display("[%0t] B2", $time);
    join
  join
    $display("[%0t] Outer join done", $time);
 end
endmodule
*/

// Example 6 blocking vs non-blocking prints
/*
module ex1;
    integer x = 0;
    initial begin
    #10 x = 1;
    #0  $display("[%0t] D1 x=%0d", $time, x);
    #0  x <= 2;
    #0  $display("[%0t] D2 x=%0d", $time, x);
    #0  $strobe("[%0t] D3(strobe) x=%0d", $time, x);
 end
endmodule
*/
// Example 7 multiple $display statement at same time.
/*
module ex1;
    initial begin
  #20 $display("[%0t] E1", $time);
  #0  $display("[%0t] E2", $time);
  #0  $display("[%0t] E3", $time);
 end
endmodule
*/

// Example 8 event ordering
/*
module ex1;
    event ev;
     initial begin
  fork
    begin
      #15 -> ev;
      $display("[%0t] fired ev", $time);
    end
    begin
      #0  @(ev) $display("[%0t] got ev path1", $time);
    end
    begin
      #5  @(ev) $display("[%0t] got ev path2", $time);
    end
  join
 end
endmodule
*/

// Example 9 wait vs @(posedge)
/*
module ex1;
reg clk = 0;
 initial forever #5 clk = ~clk;
 initial begin
  #3  wait (clk==1); $display("[%0t] wait(clk==1)", $time);
  #2  @(posedge clk); $display("[%0t] posedge", $time);
 end
endmodule
*/

// Example 10 repeat with delays.
/*
module ex1;
     integer i;
 initial begin
  repeat (3) begin
    #7  $display("[%0t] tick", $time);
  end
  $display("[%0t] done", $time);
 end
endmodule
*/

// Example 11 race with 0.
/*
module ex1;
integer a = 0;
initial begin
  fork
    begin
      a = 1;
      #0 $display("[%0t] F1 a=%0d", $time, a);
    end
    begin
      #0 a = 2;
      #0 $display("[%0t] F2 a=%0d", $time, a);
    end
  join
 end
endmodule
*/

// Example 12 — join_any with longest branch last
/*
module ex1;
initial begin
  fork
    #2  $display("[%0t] G1", $time);
    #10 $display("[%0t] G2", $time);
    #6  $display("[%0t] G3", $time);
  join_any
  $display("[%0t] join_any exit", $time);
  wait fork;
  $display("[%0t] all done", $time);
 end
endmodule
*/

// Example 13 sequential begin......end
/*
module ex1;
initial begin
  begin
    #4  $display("[%0t] H1", $time);
    #4  $display("[%0t] H2", $time);
  end
  #2 $display("[%0t] H3", $time);
 end
endmodule
*/

// Example 14  fork…join_any inside fork…join
/*
module ex1;
 initial begin
  fork
    begin
      fork
        #3  $display("[%0t] P1", $time);
        #8  $display("[%0t] P2", $time);
      join_any
      $display("[%0t] Inner join_any done", $time);
      #5 $display("[%0t] After inner delay", $time);
    end
    #6 $display("[%0t] Outer task", $time);
  join
  $display("[%0t] Outer join complete", $time);
 end
endmodule
*/

// Example 15  join_none without wait
/*
module ex1;
initial begin
  fork
    #4 $display("[%0t] A", $time);
    #7 $display("[%0t] B", $time);
  join_none
  $display("[%0t] Exited immediately", $time);
 end
endmodule
*/

// Example 16  Multiple join_any with wait fork
/*
module ex1;
initial begin
  fork
    #10 $display("[%0t] T1", $time);
    #5  $display("[%0t] T2", $time);
    #15 $display("[%0t] T3", $time);
  join_any
  $display("[%0t] First join_any done", $time);
  wait fork;
  $display("[%0t] All finished", $time);
 end
endmodule
*/

// Example 17 Nested join_none with disable
/*
module ex1;
initial begin
  fork
    begin
      fork
        #6 $display("[%0t] N1", $time);
        #12 $display("[%0t] N2", $time);
      join_none
      $display("[%0t] Inner join_none exit", $time);
      #5 disable fork;
      $display("[%0t] Inner disable fork", $time);
    end
    #20 $display("[%0t] Outer", $time);
  join
  $display("[%0t] Done", $time);
 end
endmodule
*/

// Example 18 Race with blocking vs non-blocking
/*
module ex1;
integer a=0;
 initial begin
  fork
    begin
      a = 1;
      #0 $display("[%0t] B1 a=%0d", $time, a);
    end
    begin
      #0 a <= 5;
      #0 $display("[%0t] NB1 a=%0d", $time, a);
    end
  join
 end
endmodule
*/

// Example 19  Parallel sequential blocks
/*
module ex1;
initial begin
  fork
    begin
      #2 $display("[%0t] S1", $time);
      #3 $display("[%0t] S2", $time);
    end
    begin
      #1 $display("[%0t] P1", $time);
      #6 $display("[%0t] P2", $time);
    end
  join
  $display("[%0t] Completed", $time);
 end
endmodule
*/

// Example 20 join_any with longest thread finishing first
/*
module ex1;
 initial begin
  fork
    #12 $display("[%0t] X", $time);
    #3  $display("[%0t] Y", $time);
    #6  $display("[%0t] Z", $time);
  join_any
  $display("[%0t] join_any done", $time);
  wait fork;
  $display("[%0t] All threads done", $time);
 end
endmodule
*/

// Example 21 Event + fork
/*
module ex1;
event ev;
 initial begin
  fork
    begin
      #5 -> ev;
      $display("[%0t] fired ev", $time);
    end
    begin
      @(ev) $display("[%0t] caught ev A", $time);
    end
    begin
      #2 @(ev) $display("[%0t] caught ev B", $time);
    end
  join
 end
endmodule
*/

// Example 22  join_none with forever loop
/*
module ex1;
initial begin
  fork
    forever begin
      #4 $display("[%0t] Tick", $time);
    end
    #12 $display("[%0t] One-time", $time);
  join_none
  $display("[%0t] join_none exit", $time);
 end
endmodule
*/

// Example 23 Delays + nested forks
/*
module ex1;
initial begin
  fork
    #2 $display("[%0t] M1", $time);
    begin
      fork
        #5  $display("[%0t] M2a", $time);
        #9  $display("[%0t] M2b", $time);
      join
      $display("[%0t] Inner fork done", $time);
    end
  join
  $display("[%0t] Outer join done", $time);
 end
endmodule
*/
//////////////////////////////////////////////////////////////////////////////////////////////////////////
// Example 24 How to implement fork.....join_none using fork.....join_any
/*
module ex1;
initial begin
    fork
        #10 $display("[%0t] A1", $time);
        #20 $display("[%0t] A2", $time);
    begin   // INSERTING NULL STATEMENT WHICH EXECUTES AT 0 SIMULATION TIME.
    end
    join_any
    $display("fork....Join_none");
end
endmodule
*/
//////////////////////////////////////////////////////////////////////////////////////////////////////////
// Example 25 How to Implement fork.....join_any using fork....join_none.
/*
module ex1;
    event ev;
    initial begin
        fork
        begin
            #10 $display("[%0t] A1", $time);
            -> ev;
        end
        begin
            #20 $display("[%0t] A2", $time);
        end
        join_none
        @(ev);
        $display("Done fork");
    end
endmodule
*/
//////////////////////////////////////////////////////////////////////////////////////////////////////////

// Example 26 How to implement fork......join using fork.....join_any
/*
module ex1;
    int done = 0;
    initial begin
        fork
        begin
            #10 $display("[%0t] A1", $time);
            done++;
        end
        begin
            #5 $display("[%0t] A2", $time);
            done++;
        end
        begin
            #15 $display("[%0t] A3", $time);
            done++;
        end
        join_any
        wait( done == 3 );
        $display("fork...join");
    end
endmodule
*/
//////// O/P
// # [5] A2
// # [10] A1
// # [15] A3
// # fork...join

//////////////////////////////////////////////////////////////////////////////////////////////////////

// Example 27 How to implement fork......join using fork.....join_none
/*
module ex1;
    int done = 0;
    initial begin
        fork
        begin
            #10 $display("[%0t] A1", $time);
            done++;
        end
        begin
            #5 $display("[%0t] A2", $time);
            done++;
        end
        begin
            #15 $display("[%0t] A3", $time);
            done++;
        end
    join_none
        wait( done == 3 );
        $display("fork...join");
    end
endmodule
*/
//////// O/P
// # [5] A2
// # [10] A1
// # [15] A3
// # fork...join
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//Example 28 what is the output of the following code? why?
/*
module ex1; 
  initial begin 
    for(int i=0;i<3;i++) begin 
      fork 
        $display(i); 
      join_none 
    end 
  end 
endmodule 
*/
///////////// O/P::
// 3
// 3
// 3
// Why?
// Because all forked processes are created quickly before they get a chance to execute.
// When they finally run, i has already reached 3 (the final loop value).
// $display evaluates i when the process executes, not when the fork was created.
//////////////////////////////////////////////////////////////////////////////////////////////////////////
