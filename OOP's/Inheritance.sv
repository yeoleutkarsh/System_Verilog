// Example 1 ::
class parent;
	int i;
endclass

class child extends parent;
	int j;
endclass

parent p;
child c;

module test;
	initial begin
		p = new();
		p.i = 3;
		$display("Value of i = %0d",p.i);
		c = new();
		c.i = 2;
		c.j = 4;
		$display("Value of i =%0d and j=%0d", c.i, c.j);
	end
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Example 2 ::
class parent;
	int balance = 100;
endclass

class child extends parent;
	int balance;
	
	function int summery;
		return ( balance + super.balance);
	endfunction
endclass

child c;

module test1;
	initial begin
		c = new();
		c.balance = 10;
		$display("Total Balance = %0d",c.summery);
	end
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Example 3 ::
class parent;
	int balance;
	function new(int pay);
		balance = pay;
	endfunction
endclass

class child extends parent;
	
	function new(int value);
		super.new(value);
	endfunction
endclass

child c;

module test2;
	initial begin
		c = new(500);
		$display("Balance = %0d",c.balance);
	end
endmodule
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Example 4 ::
class parent;
	task show();
		$display("This is parent class.");
	endtask
endclass

class child extends parent;
	task show();
		$display("This is child class.");
		super.show();	// caaling parent show() 
	endtask
endclass

child c;

module test3;
	initial begin
		c = new();
		c.show();
	end
endmodule

