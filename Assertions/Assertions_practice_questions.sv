
// Why do we need assertions?
// It is nothing but a more concise representation of a functional checker. 
// TYPES OF ASSERTION STATEMENT::
// 1) assert    -> To specify that the given property of the design is true in simulation.
// 2) assume    -> To specify that the given property is an assumption and used by formal tools to generate input stimulus.
// 3) cover     -> To evaluate the property for functional coverage.
// 4) restrict  -> To specify the property as a constraint an formal verification computations and is ignored by the simulators.
//
// BUILDING BLOCKS OF ASSERTIONS ::
// 1) sequence: A sequence of multiple logical events typically form the functionality of any design.
// 2) property: These events can be represented as a sequence and a number of sequences can be combined to create more complex sequences or properties.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// IMMEDIATE ASSERTIONS //
// Immediate assertions are executed like a statement in a procedural block and follow simulation event semantics. These are used to verify an immediate property during simulation.
/*
module top;
    bit clk, a, b;
    logic check;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        a = 0;
        b = 0;
        @( posedge clk ) a = 1; b = 1;
        @( posedge clk ) a = 0; b = 1;
        @( posedge clk ) a = 1; b = 0;
        @( posedge clk ) a = 1; b = 1;
        #20;
        $finish();
    end
    always @( posedge clk )
    begin
        assert( a && b )
        begin
            $monitor($time, "a = %0d b = %0d -> check = %0d", a, b, check);
            check   = 1;
        end
        else
        begin
            $monitor($time, "a = %0d b = %0d -> check = %0d", a, b, check);
            check  = 0;
        end
    end
endmodule
*/
////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////
// CONCURRENT ASSERTION //
// 1) The concurrent assertion is evaluated only at the occurrence of a clock tick
// 2) The test expression is evaluated at clock edges based on the sampled values of the variables involved
// 3) It can be placed in a procedural block, a module, an interface or a program definition
// syntax ::    c_assert:  assert property(@(posedge clk) not(a && b));
// The Keyword differentiates the immediate assertion from the concurrent assertion is “property.”
/*
module top;
    bit clk, a;
    logic check;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        a = 0;
        @( posedge clk ) a = 1;
        @( posedge clk ) a = 0;
        @( posedge clk ) a = 1;
        @( posedge clk ) a = 0;
        @( posedge clk ) a = 1;
        #10;
        $finish();
    end
    property ppt;
        @( posedge clk) a == 1;
    endproperty

    a1: assert property ( ppt )
        begin
            $monitor($time," a = %0d -> check = %0d", a, check);
            check = 1;
        end
    else
        begin
            $monitor($time, " a = %0d -> check = %0d", a, check);
            check = 0;
        end
endmodule
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  3)	A sequence with a logical relationship:
/*
module top;
    bit clk, a, b;
    logic check;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        a = 0;
        @( posedge clk ) a = 1; b = 0;
        @( posedge clk ) a = 0; b = 0;
        @( posedge clk ) a = 1; b = 0;
        @( posedge clk ) a = 0; b = 1;
        @( posedge clk ) a = 1; b = 0;
        #30;
        $finish();
    end
    property ppt;
        @( posedge clk) ( a || b );
    endproperty

    a1: assert property ( ppt )
        begin
            $monitor($time," a = %0d b = %0d -> check = %0d", a, b, check);
            check = 1;
        end
    else
        begin
            $monitor($time, " a = %0d b = %0d -> check = %0d", a, b, check);
            check = 0;
        end
endmodule
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Sequence with Arguments: //
/*
module top;
    bit clk, a, b;
    logic check;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        a = 0;
        @( posedge clk ) a = 1; b = 0;
        @( posedge clk ) a = 0; b = 0;
        @( posedge clk ) a = 1; b = 0;
        @( posedge clk ) a = 0; b = 1;
        @( posedge clk ) a = 1; b = 0;
        #30;
        $finish();
    end
    sequence seq_lib ( req1, req2 );
       ( req1 || req2 );
    endsequence
    property ppt;
        @( posedge clk ) seq_lib( a, b );
    endproperty
    a1: assert property ( ppt )
        begin
            $monitor($time," a = %0d b = %0d -> check = %0d", a, b, check);
            check = 1;
        end
    else
        begin
            $monitor($time, " a = %0d b = %0d -> check = %0d", a, b, check);
            check = 0;
        end
endmodule
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Sequences with timing relationship ::
/*
module top;
    bit clk, a, b;
    logic check;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        a = 0;
        b = 0;
        @( posedge clk ) a = 1; b = 1;
        @( posedge clk ) a = 0; b = 0;
        @( posedge clk ) a = 1; b = 1;
        @( posedge clk ) a = 0; b = 0;
        @( posedge clk ) a = 0; b = 1;
        #30;
        $finish();
    end
    sequence seq1;
        a ##2 b;
    endsequence
    property ppt;
        @(posedge clk ) seq1;
    endproperty;
    acc : assert property ( ppt ) begin
        $monitor($time," a = %0d b = %0d -> check = %0d", a, b, check);
        check = 1;
    end
    else
    begin
         $monitor($time," a = %0d b = %0d -> check = %0d", a, b, check);
        check = 0;
    end
endmodule
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Forbidden a property :: In all the examples shown so far, the property is checking for a true condition. we expect the property to be false always. If the property is true, the assertion fails.
// a_3: assert property(@(posedge clk) p) ; //Not allowed
/*
module top;
    bit clk, a, b;
    logic check;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        a = 0;
        b = 0;
        @( posedge clk ) a = 1; b = 1;
        @( posedge clk ) a = 0; b = 0;
        @( posedge clk ) a = 1; b = 1;
        @( posedge clk ) a = 0; b = 0;
        @( posedge clk ) a = 0; b = 1;
        #30;
        $finish();
    end
    sequence seq1;
        @( posedge clk) (a ##2 b);
    endsequence
    property ppt;
        not seq1;   // forbidden a property
    endproperty
    acc: assert property ( ppt ) begin
        $monitor($time, " a = %0d b = %0d -> check = %0d", a, b, check);
        check = 1;
    end
    else
    begin
        $monitor($time, " a = %0d b = %0d -> check = %0d", a, b, check);
        check = 0;
    end
endmodule
*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// IMplication OPerator :: in the previous you are observing that sequence starts at the every posedge of the clk.
//                         And it looks for 'a' to be high on every posedge of clk edge;
//                         if the signal 'a' is not high on given posedgem clock edge, an error is issued by the checker.
// If we want to sequence to be checked only after the 'a'is high, this can be achieved by using 'implication operator'.
// The implication is equivalent to an if-then structure. 
// The left-hand side of the implication is called the “antecedent” and the right-hand side is called the “consequent.” 
// The antecedent is the gating condition. If the antecedent succeeds, then the consequent is evaluated.
// The implication construct can be used only with property definitions. It cannot be used in sequences.
// following are the 2 types ::
//
// 1) OVERLAPPED IMPICATION :: ( |-> )
/*
module top;
    bit clk, a, b;
    logic check;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        a = 0; b = 0;
        @( posedge clk ) a = 1; b = 0;
        @( posedge clk ) a = 1; b = 1;
        @( posedge clk ) a = 0; b = 1;
        @( posedge clk ) a = 1; b = 0;
        @( posedge clk ) a = 1; b = 1;
        #20;
        $finish();
    end
    property ppt;
        @( posedge clk ) ( a |-> b );
    endproperty
    acc: assert property ( ppt ) begin
        $monitor($time, " a = %0d b = %0d -> check = %0d", a, b, check);
        check = 1;
    end
    else
    begin
        $monitor($time, " a = %0d b = %0d -> check = %0d", a, b, check);
        check = 0;
    end
endmodule
*/

/*
`timescale 1ns/1ps
module top;
    bit clk;
    bit a, b, c, d;
    logic check;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;   // 10ns period
    end
    initial begin
        a = 0; b = 0; c = 0; d = 0;
        @(posedge clk) a = 1; b = 0; c = 1; d = 0;
        @(posedge clk) a = 1; b = 1; c = 0; d = 1;
        @(posedge clk) a = 0; b = 1; c = 1; d = 0;
        @(posedge clk) a = 1; b = 0; c = 1; d = 1;
        @(posedge clk) a = 1; b = 1; c = 1; d = 0;
        @(posedge clk) a = 0; b = 0; c = 0; d = 1;
        #50;
        $finish;
    end
    sequence seq1;
        (a && b) ##1 c;
    endsequence
    sequence seq2;
        ##2 !d;
    endsequence
    property ppt;
        @(posedge clk) (seq1 |-> seq2);
    endproperty
    acc: assert property (ppt)
    begin
        check <= 1; 
    end
    else begin
        check <= 0;
    end
    always @(posedge clk) begin
        $display($time, " a=%0d b=%0d c=%0d d=%0d -> check=%0d", a, b, c, d, check);
    end
endmodule
*/

// 2) NON - OVERLAPPED IMPLICATION :: ( |=> )
/*
module top;
    bit clk, a, b;
    logic check;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        a = 0; b = 0;
        @( posedge clk ) a = 1; b = 0;
        @( posedge clk ) a = 1; b = 1;
        @( posedge clk ) a = 0; b = 1;
        @( posedge clk ) a = 1; b = 0;
        @( posedge clk ) a = 1; b = 1;
        #20;
        $finish();
    end
    property ppt;
        @( posedge clk ) ( a |=> b );
    endproperty
    acc: assert property ( ppt ) begin
        $monitor($time, " a = %0d b = %0d -> check = %0d", a, b, check);
        check = 1;
    end
    else
    begin
        $monitor($time, " a = %0d b = %0d -> check = %0d", a, b, check);
        check = 0;
    end
endmodule
*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Timing windows in SVA Checkers :: ////
/*
module top;
    bit clk, a, b;
    logic check;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        a = 1; b = 1;
        @( posedge clk ) a = 0; b = 0;
        @( posedge clk ) a = 0; b = 0;
        @( posedge clk ) a = 0; b = 0;
        @( posedge clk ) a = 0; b = 1;
        @( posedge clk ) a = 0; b = 0;
        #20;
        $finish();
    end
    property ppt;
        @( posedge clk ) ( a |-> ##[1:4]b );
    endproperty
    acc : assert property ( ppt ) begin
        check   <= 1;
    end
    else
    begin
        check   <= 0;
    end
    always @(posedge clk) begin
        $display($time, " a=%0d b=%0d -> check=%0d", a, b, check);
    end
endmodule
*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Overlapping timing window :: //
/*
module top;
    bit clk, a, b;
    logic check;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        a = 1; b = 1;
        @( posedge clk ) a = 0; b = 0;
        @( posedge clk ) a = 0; b = 0;
        @( posedge clk ) a = 0; b = 0;
        @( posedge clk ) a = 0; b = 1;
        @( posedge clk ) a = 0; b = 0;
        #20;
        $finish();
    end
    property ppt;
        @( posedge clk ) ( a |-> ##[0:4]b );
    endproperty
    acc : assert property ( ppt ) begin
        check   <= 1;
    end
    else
    begin
        check   <= 0;
    end
    always @(posedge clk) begin
        $display($time, " a=%0d b=%0d -> check=%0d", a, b, check);
    end
endmodule
*/
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Go To Repetition :: //
/*
module top;
    bit clk, a, b, c;
    logic check;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        // -------- Pass case --------
        @(posedge clk) a = 1; b = 0; c = 0;   // t0: trigger (a=1)
        @(posedge clk) a = 0; b = 1; c = 0;   // t1: b=1 (1st cycle)
        @(posedge clk) a = 0; b = 1; c = 0;   // t2: b=1 (2nd cycle)
        @(posedge clk) a = 0; b = 1; c = 0;   // t3: b=1 (3rd cycle)
        @(posedge clk) a = 0; b = 0; c = 1;   // t4: c=1 → PASS
        // -------- Fail case --------
        @(posedge clk) a = 1; b = 0; c = 0;   // t5: trigger again
        @(posedge clk) a = 0; b = 1; c = 0;   // t6: b=1
        @(posedge clk) a = 0; b = 0; c = 0;   // t7: b fails early
        @(posedge clk) a = 0; b = 0; c = 1;   // t8: c=1 but property FAILS
        @(posedge clk);   // wait 1 more clock
        $finish;    
    end
    property ppt;
        @( posedge clk ) ( a |-> ##1 b[->3] ##1 c );
    endproperty
    acc : assert property ( ppt ) begin
        check   <= 1;
    end
    else
    begin
        check   <= 0;
    end
    always @(posedge clk) begin
        $display($time, " a=%0d b=%0d -> check=%0d", a, b, check);
    end
endmodule
*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Built In Methods ::
// 1) $rose()   -> returns true if the least significant bit of the expression changed to 1. Otherwise, it returns false.
/*
module top;
    bit clk, a;
    logic check;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        a = 0;
        @( posedge clk ) a = 0;
        @( posedge clk ) a = 1;
        @( posedge clk ) a = 0;
        @( posedge clk ) a = 0;
        @( posedge clk ) a = 1;
        @( posedge clk ) a = 0;
        @( posedge clk ) a = 1;
        @( posedge clk ) a = 0;
        @( posedge clk ) ;
        #20;
        $finish();
    end
    property ppt;
        @( posedge clk ) $rose( a );
    endproperty
    acc : assert property ( ppt ) begin
        check   <= 1;
    end
    else
    begin
        check   <= 0;
    end
    always @(posedge clk) begin
        $display($time, " a=%0d -> check=%0d", a, check);
    end
endmodule
*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 2) $fell()   -> returns true if the least significant bit of the expression changed to 0. Otherwise, it returns false.
/*
module top;
    bit clk, a;
    logic check;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        a = 1;
        @( posedge clk ) a = 1;
        @( posedge clk ) a = 0;
        @( posedge clk ) a = 1;
        @( posedge clk ) a = 1;
        @( posedge clk ) a = 0;
        @( posedge clk ) a = 1;
        @( posedge clk ) a = 0;
        @( posedge clk ) a = 1;
        @( posedge clk ) ;
        #20;
        $finish();
    end
    property ppt;
        @( posedge clk ) $fell( a );
    endproperty
    acc : assert property ( ppt ) begin
        check   <= 1;
    end
    else
    begin
        check   <= 0;
    end
    always @(posedge clk) begin
        $display($time, " a=%0d -> check=%0d", a, check);
    end
endmodule
*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 3) $stable `-> returns true if the value of the expression did not change. Otherwise, it returns false.
/*
module top;
    bit clk, a;
    logic check;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        a = 1;
        @( posedge clk ) a = 1;
        @( posedge clk ) a = 0;
        @( posedge clk ) a = 1;
        @( posedge clk ) a = 1;
        @( posedge clk ) a = 0;
        @( posedge clk ) a = 1;
        @( posedge clk ) a = 0;
        @( posedge clk ) a = 1;
        @( posedge clk ) ;
        #20;
        $finish();
    end
    property ppt;
        @( posedge clk ) $stable( a );
    endproperty
    acc : assert property ( ppt ) begin
        check   <= 1;
    end
    else
    begin
        check   <= 0;
    end
    always @(posedge clk) begin
        $display($time, " a=%0d -> check=%0d", a, check);
    end
endmodule
*/
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 4) $past()   -> provides the value of the signal from the previous clock cycle.
//                 SYNTAX :: $past(signal_name, number of clock cycles)
/*
module top;
    bit clk, a;
    logic check;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        a = 1;
        @( posedge clk ) a = 1;
        @( posedge clk ) a = 0;
        @( posedge clk ) a = 1;
        @( posedge clk ) a = 1;
        @( posedge clk ) a = 0;
        @( posedge clk ) a = 1;
        @( posedge clk ) a = 0;
        @( posedge clk ) a = 1;
        @( posedge clk ) ;
        #20;
        $finish();
    end
    property ppt;
        @( posedge clk ) $past( a,1 ) == 1;
    endproperty
    acc : assert property ( ppt ) begin
        check   <= 1;
    end
    else
    begin
        check   <= 0;
    end
    always @(posedge clk) begin
        $display($time, " a=%0d -> check=%0d", a, check);
    end
endmodule
*/
/*
module top;
    bit clk, a, b, c;
    logic check;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        a = 0; b = 0; c = 0;
        @(posedge clk) a = 1; b = 0; c = 1;   
        @(posedge clk) a = 0; b = 0; c = 0;   
        @(posedge clk) a = 0; b = 0; c = 0;   
        @(posedge clk) a = 0; b = 1; c = 0;   
        @(posedge clk) a = 0; b = 0; c = 0;   
        @(posedge clk) a = 0; b = 1; c = 0;   
        @(posedge clk) a = 1; b = 0; c = 1;   
        @(posedge clk) a = 0; b = 1; c = 0;   
        @(posedge clk);   
        #10 $finish;    
    end
    property ppt;
        @( posedge clk ) b |-> ( $past( a,2,c ) == 1 );
    endproperty
    acc : assert property ( ppt ) begin
        check   <= 1;
    end
    else
    begin
        check   <= 0;
    end
    always @(posedge clk) begin
        $display($time, " a=%0d b=%0d c=%0d -> check=%0d", a, b, c, check);
    end
endmodule
*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ### Built-in system functions
// 1) $onehot(expression)
//              checks that only one bit of the expression can be high on any given clock edge.
// 2) $onehot0(expression)
//              checks only one bit of the expression can be high or none of the bits can be high on any given clock edge.
// 3) $isunknown(expression)
//              checks if any bit of the expression is X or Z.
// 4) $countones(expression)
//              counts the number of bits that are high in a vector.
//
//      a_1: assert property( @(posedge clk) $onehot(state) );
//      a_2: assert property( @(posedge clk) $onehot0(state) );
//      a_3: assert property( @(posedge clk) $isunknown(bus) ) ;
//      a_4: assert property( @(posedge clk) $countones(bus)> 1 );
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 5) disable iff :: In certain design conditions, we don’t want to proceed with the check if some condition is true. 
//                   this can be achieved by using disable iff.
module top;
    bit clk, a, b, c, reset;
    logic check;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        a=0; b=0; c=0; reset=0;

        // -------- PASS case --------
        @(posedge clk) a=1; b=0; c=0; reset=0;   // t0: trigger
        @(posedge clk) a=0; b=1; c=0; reset=0;   // t1: b=1 (1st cycle)
        @(posedge clk) a=0; b=1; c=0; reset=0;   // t2: b=1 (2nd cycle)
        @(posedge clk) a=0; b=0; c=1; reset=0;   // t3: c=1 → PASS

        // -------- FAIL case (b not held 2 cycles) --------
        @(posedge clk) a=1; b=0; c=0; reset=0;   // t4: trigger
        @(posedge clk) a=0; b=1; c=0; reset=0;   // t5: b=1
        @(posedge clk) a=0; b=0; c=0; reset=0;   // t6: b fails early
        @(posedge clk) a=0; b=0; c=1; reset=0;   // t7: c=1 but property FAILS

        // -------- Reset case (disables property) --------
        @(posedge clk) a=1; b=0; c=0; reset=1;   // t8: trigger but reset active → property ignored
        @(posedge clk) a=0; b=1; c=0; reset=0;   // t9: no checking due to reset

        @(posedge clk);
        #10 $finish;  
    end
    property ppt;
        @( posedge clk ) 
        disable iff ( reset ) a |-> ##1 b[->2] ##1 c; 
    endproperty
    acc : assert property ( ppt ) begin
        check   <= 1;
    end
    else
    begin
        check   <= 0;
    end
    always @(posedge clk) begin
        $display($time, " a=%0d b=%0d c=%0d -> check=%0d", a, b, c, check);
    end
endmodule

