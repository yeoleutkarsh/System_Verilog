class pkt;
  	bit [3:0] a;
 	 bit [3:0] b;

  	function new(bit [3:0] e, f);
    		a = e;
    		b = f;
 	endfunction

	// deep copy method for pkt;
	function pkt deep_copy();
		deep_copy = new( this.a, this.b );		
	endfunction
endclass

class my_pkt;
  	bit [3:0] c;
  	bit [3:0] d;
  	pkt p;

  	function new();
    		p = new(5,6);
    		c = 0;
    		d = 0;
  	endfunction

  	// Deep copy method for my_pkt
  	function my_pkt deep_copy();
		deep_copy = new();
		deep_copy.c = this.c;
		deep_copy.d = this.d;
		deep_copy.p = this.p.deep_copy;
	endfunction

  	// Print function
  	function void print(string name);
    		$display("----- %s -----", name);
    		$display("a=%0d b=%0d c=%0d d=%0d", p.a, p.b, c, d);
    	endfunction

endclass

module d_copy;
	my_pkt p1, p2;

	initial begin
		p1 = new();
		p1.print("before copy p1");

		p2 = p1.deep_copy();  // deep copy
	
		p1.print("after copy p1");
		p2.print("after copy p1");
		
		p1.p.a = 10;
		p1.p.b = 9;
		p1.d   = 1;
		p1.c   = 2;

		p1.print("after modification p1");
		p2.print("after modification p2");


	end
	
endmodule
