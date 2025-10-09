/*
class parent;
	virtual task send();
		$display("This is parent class.");
	endtask
endclass

class child extends parent;
	task send();
		$display("This is child class.");
	endtask
endclass

parent p;
child c;

module ptest;
	initial begin
		c = new();
		p = c;
		p.send();
	end
endmodule
*/

class car;
	int door = 4;
	int mirror = 6;

	virtual function void print();
		$display("Door=%0d Mirror=%0d",door, mirror);
	endfunction
endclass

class my_car extends car;
	int tyre = 5;

	function void print();
		super.print();
		$display("Tyre=%0d",tyre);
	endfunction
endclass

car c1;
my_car c2;

module ptest1;
	initial begin
		c1 = new();
		c2 = new(); 

		c1 = c2;

		c1.print();
	end
endmodule
