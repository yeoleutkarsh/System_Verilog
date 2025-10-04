
class transaction;
    rand bit [3:0] in1, in2;
    bit [4:0] out;

    constraint c1 {
        in1 inside {[0:15]}; 
        in2 inside {[0:15]};
    }

    function void display( string name );
        $display("%s\t:: in1=%0d in2=%0d -> out=%0d",name, in1, in2, out);
    endfunction

endclass
