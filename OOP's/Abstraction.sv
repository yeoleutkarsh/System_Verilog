// Example 1 ::
virtual class parent;
	bit [3:0] data;
	
	function new();
		data = 4'b1010;
	endfunction
endclass

class child extends parent;
	function new();
		data = 4'b1111;
	endfunction
endclass

module testa;
	child c;
	initial begin
		c = new();
		$display("Data = %0b",c.data);
	end
endmodule
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Example 2 ::
virtual class base_class;
	bit [3:0] data;
	int id;
	
	function void display();
		$display("Base: Value of Data=%0h and Id=%0h",data,id);
	endfunction
endclass

class extended_class extends base_class;
	function void display();
		$display("Child: Value of Data=%0h and Id=%0h",data, id);
	endfunction
endclass

module testa1;
	extended_class c1;
	initial begin
		c1 = new();
		c1.data = 10;
		c1.id   = 2;
		c1.display();
	end
endmodule
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Exaample 3 ::
virtual class bike;
	int tyre;
	int mirror;
	pure virtual function void display();
endclass

class hero extends bike;
	function void display();
		$display("Hero: Tyre=%0d and Mirror=%0d",tyre,mirror);
	endfunction
endclass

module testa2;
	hero a;
	initial begin
		a = new();
		a.tyre = 2;
		a.mirror = 3;
		a.display();
	end
endmodule

