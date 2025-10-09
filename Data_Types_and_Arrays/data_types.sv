//////////////////////////////////////////////////////////////////// DATA TYPES /////////////////////////////////////////////////////////////////////
//
/////////////// 2 state Data Types ////////
// Supports only 2 vales that is '0' and '1' and not the 'x' and 'z'.
// 1) Signed    ::  Byte        --> it is of 8 bit and range -128 to 127. 
//                  int         --> it is of 32 bit and range (-2147483648 to 2147483647).
//                  shortint    --> it is of 16 bit and range (-32768 to 32767).
//                  longint     --> it is of 64 bit and range ( -9223372036854775808 to 9223372036854775807 ).
// 2) Unsigned  ::  bit         --> it is of 1 bit only ( 0 and 1 );
// Default value of 2 states data types "0".
//
///////////////////  4 state Data Types ////////
//supports 4 states / values '0', '1', 'x' and 'z'.
//logic data types can be used inside and outside of procedural block.
//we can make signed data types to unsigend using 'unsigend' keyord before variable.
// 1) Signed    :: integer      --> it is of 32 bit.
// 2) Unsigned  :: reg          --> 
//                 wire         -->
//                 real         --> 
//                 realtime     -->  
//                 time         --> 
//                 sortreal     --> 
//                 logic        --> 
//
////////////// USER DEFINED DATA TYPES /////
// Event, String, Typedef, Enum, struct, union
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// A] ENUM ::
// mainly used to declare or convert integer kind of values to named variables.
// It improves the readiability.
// Enum is the ordered list of the named constants.
// enumeation name cannot start with number e.g. 1_RED, 2_GREEN, Etc.
// By default values started from '0' and keeps on incrementing.
// Eg. typedef enum {BLACK[4]} color3; --> BLACK[0] = 0, BLACK[1] = 1, BLACK[2] = 2, BLACK[3] = 3.
// Eg. typedef enum {RED[3]=5} color4; --> RED[0] = 5, RED[1] = 6, RED[2] = 7.
// Eg. typedef enum {YELLOW[3:5]} color5; --> YELLOW[3] = 0, YELLOW[4] = 1, YELLOW[5] = 2.
// Eg. typedef enum {WHITE[3:5]=4} color6; --> WHITE[3] = 4, WHITE[4] = 5, WHITE[5] = 6.
// NOTE: Default enum supports maximum 2^32 combinations because default data type of enumeration is int.
// Example 1.

class pkt;
  typedef enum {RED, GREEN, BLUE, YELLOW} color_e;
  // RED = 0, GREEN = 1, BLUE = 2, YELLOW = 3
endclass

module top;
  pkt::color_e c;  // use class-scoped enum

  initial begin
    c = c.first();   // start from first enum
    do begin
      $display("Enum = %s (%0d)", c.name(), c);
      c = c.next();
    end while (c != c.first());  // stop after wrap
  end
endmodule

// Example 2.

class pkt;
  typedef enum {RED=1, GREEN, BLUE, YELLOW} color_e;
  // RED = 1, GREEN = 2, BLUE = 3, YELLOW = 4
endclass

module top;
  pkt::color_e c;  // use class-scoped enum

  initial begin
    c = c.first();   // start from first enum
    do begin
      $display("Enum = %s (%0d)", c.name(), c);
      c = c.next();
    end while (c != c.first());  // stop after wrap
  end
endmodule
// Example 3
class pkt;
  typedef enum {RED=5, GREEN, BLUE=10, YELLOW} color_e;
  // RED = 5, GREEN = 6, BLUE = 10, YELLOW = 11
endclass

module top;
  pkt::color_e c;  // use class-scoped enum

  initial begin
    c = c.first();   // start from first enum
    do begin
      $display("Enum = %s (%0d)", c.name(), c);
      c = c.next();
    end while (c != c.first());  // stop after wrap
  end
endmodule
// Example 4 
class pkt;
   typedef enum {RED=4, GREEN, YELLOW} light;
   rand light l;
   constraint c1 { l==5;}
   function void print();
       $display("Light=%b , light=%s",l,l);
   endfunction
endclass

module top;
  pkt p;

  initial begin
      p = new();
      p.randomize();
      p.print();
      // Light=00000000000000000000000000000101 , light=GREEN
  end
endmodule
// Example 5

class pkt;
   typedef enum {RED=4, GREEN, YELLOW=5} light;
   rand light l;
   constraint c1 { l==5;}
   function void print();
       $display("Light=%b , light=%s",l,l);
   endfunction
endclass

module top;
  pkt p;

  initial begin
      p = new();
      p.randomize();
      p.print();
      // ** Error: data_types.sv(118): (vlog-13002) Enum member 'YELLOW' does not have unique value.
    end
endmodule
// Example 6
// typedef enum bit[2:0] {red=7, green, yellow} light
// Green value is 8 But our enum range is[2:0] So we can’t store.
// ** Error:enum.sv(2):(vlog-13003)Enum member 'green' has value that is outside the representable range of the enum.
//

// Example 7 Methods in enumeration.
class pkt;
    enum {red, green, yellow, blue} light;
    function void print();
        light = yellow;     // currently at position 2.
        $display("First     = %s (%0d)", light.first(), light.first() );
        $display("last      = %s (%0d)", light.last(), light.last() );
        $display("Preve     = %s (%0d)", light.prev(), light.prev() );
        $display("Next      = %s (%0d)", light.next(), light.next() );
        $display("Num       = (%0d)",    light.num() );
        $display("name      = (%0s)",    light.name());
    endfunction
endclass
module top;
    pkt p;
    initial begin
        p = new();
        p.print();
    end
endmodule
// Example 8 enum method prev(N) and next(N).
class pkt;
    enum {red, green, yellow, blue} light;
    function void print();
        light = yellow;
        $display("First     = %s (%0d)", light.first(), light.first() );
        $display("last      = %s (%0d)", light.last(), light.last() );
        $display("Preve     = %s (%0d)", light.prev(2), light.prev(2) );
        $display("Next      = %s (%0d)", light.next(1), light.next(1) );
        $display("Num       = (%0d)",    light.num() );
        $display("name      = (%0s)",    light.name());
    endfunction
endclass
module top;
    pkt p;
    initial begin
        p = new();
        p.print();
    end
endmodule
// Example 9 Displaying all enum variable using single $display.

typedef enum {white[1:5] = 3} set2;
module top;
    typedef enum {green, yellow, red, blue} set1;
    set1 s1;
    set2 s2;
    initial begin
        s1 = red;
        $display("FIRST = %0d", s1.first());
        $display("LAST = %0d", s1.last());
        $display("NEXT = %0d", s1.next());
        $display("PREV = %0d", s1.prev());
        $display("NAME = %0d", s1.name());

        s2 = s2.first();
        for( int i=0; i<5; i++)
        begin
            $display("set2::value of %s is %0d", s2.name(), s2);
            s2 = s2.next();
        end
    end
endmodule
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 2] EVENT DATA-TYPE:
// Used to handle synchronization between two or more active process.
// waiting for an event can achieved by (wait or @).
// We can using both ( .triggered and ->> ).
// Example 1.

module top;
    event ev;
    initial begin
        #20;
        -> ev;  // trigger the event.
        $display("@%0t ::: Event is triggered", $time);
    end
    initial begin
        $display("@%0t ::: Waiting for the event to be triggered", $time);
        @(ev);  // waiting for the triggering event.
        $display("@%0t ::: Over Event Triggered", $time);
    end
endmodule
// Example 2.
module top;
    event ev;
    initial begin
        -> ev;  // trigger the event.
        $display("@%0t ::: Event is triggered", $time);
    end
    initial begin
        $display("@%0t ::: Waiting for the event to be triggered", $time);
        @(ev);  // waiting for the triggering event.
        $display("@%0t ::: Over Event Triggered", $time);
    end
endmodule
//  Here triggering an event and waiting for an event is done at same 0ns (RACE CONDITION).This can solved by (.triggered)
//  "$display("@%0t ::: Over Event Triggered", $time);" This display statement not executed because of race condition.
//  This RACE CONDITION is solved by using .triggered.
module top;
    event ev;
    initial begin
        -> ev;  // Trigger the event.
        $display("@%0t :: Event is triggered.", $time);
    end
    initial begin
        $display("@%0t :: Waiting for the event to be triggered.", $time);
        wait( ev.triggered ); // Waiting for the triggering event.
        $display("@%0t :: Over Event Triggered.", $time);
    end
endmodule
// OR BY USING NON-BLOCKING TRIGGERING OPERATOR ( ->> ) ALSO WE CAN OVERCOME THIS RACE CONDITION.
module top;
    event ev;
    initial begin
        ->> ev;  // trigger the event.
        $display("@%0t ::: Event is triggered", $time);
    end
    initial begin
        $display("@%0t ::: Waiting for the event to be triggered", $time);
        wait(ev);  // waiting for the triggering event.
       // wait(ev);  // waiting for the triggering event.
        $display("@%0t ::: Over Event Triggered", $time);
    end
endmodule
// Example 4 Merging of 2 events.
module top;
    event e1, e2;
    initial begin
        fork
        begin
            wait( e1.triggered );
            $display("%0t :: Process1 :: Wait for the e1 is over", $time);
        end
        begin
            wait( e2.triggered );
            $display("%0t :: Process2 :: Wait for event e2 is over", $time);
        end
        #20 -> e1;
        #30 -> e2;
        begin
            #10 e2 = e1; // merging of event.
        end
        join
    end
endmodule
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 3] STRUCT DATA-TYPE:
// Collection of different datatype variable, which can be referred by a common name.
// Types of Structure: i). UNPACKED DATA-TYPE.
//                     ii). PACKED DATA-TYPE -> This is achieved by using keyword packed.
// Packed struct only supports packed datatype and int datatype.
// Struct by default unpacked in nature.
//
// Example 1.
module top;
    struct{
        string fruit;
        int fruit_count;
        byte fruit_expiry;
    } st_fruit;

    initial begin
        st_fruit='{"apple",4,15};
        $display("fruit1=%p",st_fruit);
    end
    initial begin
        st_fruit.fruit="bannana";
        st_fruit.fruit_count=5;
        st_fruit.fruit_expiry=10;
        $display("fruit1=%p",st_fruit);
    end
endmodule
// Example 2. 
typedef struct{
    string fruit;
    int fruit_count;
    byte fruit_expiry;
} st_fruit;

module top;
    st_fruit fruit1;//here st_fruit act as datatype bcoz of typedef.
    st_fruit fruit2;//st_fruit is datatype and fruit1 / fruit2 is variable.
   initial begin
        fruit1='{"apple",4,15};
        fruit2='{"banana",5,10};
        $display("fruit1=%pfruit2=%p",fruit1,fruit2);
    end
 endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 4] UNION  DATATYPE:
// Same as structure but the only difference is memory allocation of union variable varies.( size of union is largest size of data type inside union).
// TYPES OF UNOIN : 1.PACKED UNION 
//                  2.UNPACKED UNION
// Union by default is UNPACKED.
// user defined data types is not supported in union non-tagged type.
// We can achieve this user-defined data types (string) using tagged type.
// All members in packed union must be same size.
// Packed union not support unpacked datatype.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 5] STRING DATA-TYPE::
// String data type is an ordered collection of characters.
// equality(==) and non-equality (!=) checking.
// concatinating and replicationthe string.
// String index wise accesss :: We can iterate through each index of string by using for loop or foreach.
// String Method ::
// i.) str.len() --> to fing out the length of the string.
// ii.) str.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 6] TYPEDEF DATA-TYPE ::
// Typedef mainly used to create a new datatypes and also used for forward declaration purpose.


