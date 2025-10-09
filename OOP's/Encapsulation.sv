class parent;
	local logic [1:0] a;
	protected logic [1:0] b;

	protected function void display();
		$display("A=%0d and B=%0d",a,b);
	endfunction

	function void update( logic [1:0] a, b );
		this.a = a;
		this.b = b;
	endfunction
endclass

class child extends parent;
	logic [1:0] c;
	
	function void calc();
		super.display();
		super.a = 2; // error bcz of the local
		super.b = 1;
	endfunction
endclass

module top;
  initial begin
	parent p;
	child c;
	
	p = new();
	p.a = 3;	// error bcc of local 
	p.b = 3;	// error bcz of protected in initial ( procedural blocks ) block.
	
	p.update(1,2);

	c = new();

	c.update(6,7);
	c.display(); // we cannot call the protected inside the procedural block but we can access the extended class.
	c.calc();
  end
endmodule
