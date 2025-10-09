class transcation;
	bit [3:0] data;
	bit [15:0] addr;
	bit [15:0] mem;	
	function void check();
		$display("\n Methods is accessed...! \n");
	endfunction
endclass
transcation t1, t2; // creating handles points to the same class
module s_copy;
	initial begin
		t1 = new();  // object creation for handle t1
		t1.data = 5;
		t1.addr = 10;
		t1.mem = 15;
		t2 = new t1;   // Creating Shallow Copy
		t1.check();   // accessing method from the class
		$display("Printing content in the object t1");
		$display("Data=%0d Addr=%0d Mem=%0d",t1.data, t1.addr, t1.mem);
		$display("----------------------------------------------------");
		t2.check();   // accessing method from the class
		$display("Printing content copied from object t1 to object t2");
		$display("Data=%0d Addr=%0d Mem=%0d",t2.data, t2.addr, t2.mem);
		$display("----------------------------------------------------");
		t2.data = 1;
//		t2.addr = 2;
//		t2.mem  = 3;
		$display("Printing modified data of object t2");
		$display("Data=%0d Addr=%0d Mem=%0d",t2.data, t2.addr, t2.mem);
	end
endmodule
