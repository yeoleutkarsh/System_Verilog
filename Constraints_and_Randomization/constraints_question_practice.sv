// Que 1. Write a constraint to generate the pattern 0101010101.
class sequence_gen;
	rand bit a[];
	
	constraint a_size { a.size == 20; }

	constraint seq {
		foreach( a[i] ) {
			if( i%2 == 0 )
				a[i] == 0;
			else
				a[i] == 1;  // at "ODD" index add 1.
		}		
	}
endclass

module top;
	sequence_gen s1;
	initial begin
		s1 = new();
		assert( s1.randomize() );
        $write("Sequense: ");
        foreach( s1.a[i] )
        begin
            $write("%0d", s1.a[i]);
        end
	end
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Que.2) Write a constraint to generate the pattern 1234554321.

class sequence_gen;
	rand int a[];
	constraint a_size { a.size == 10; }
	constraint gen {
		foreach( a[i] ) {
			if( i < 5 )
				a[i] == i + 1;
			else
				a[i] == 10 - i;
		}
	}
endclass : sequence_gen

module top;
	sequence_gen g1;
	initial begin
		g1 = new();
		assert( g1.randomize() );
        $write("Sequense: ");
        foreach( g1.a[i] )
        begin
            $write("%0d", g1.a[i]);
        end
    end
endmodule 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Que.3) Write a constraint to generate the pattern 9 19 29 39 49 59 69 79.

class seq_gen;
	rand int a[];
	constraint a_size { a.size == 8;}
	constraint gen {
		foreach ( a[i] ) {
			a[i] == (( i * 10) + 9 );
		}
	}
endclass: seq_gen

module top;
	seq_gen g1;
	initial begin
		g1 = new();
		assert( g1.randomize() );
		$display("Sequence: %0p",g1.a);
	end
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Que.4) write a constraint to generate the pa ern 5 -10 15 -20 25 -30.

class seq_gen;
	rand int a[];
	constraint a_size { a.size == 6;}
	constraint gen {
		foreach( a[i] ) {
			if( i%2 == 0)                   // even number
				a[i] == (( 5 * i ) + 5);
			else 		                    // odd number
				a[i] == ( ( - 5 * i) - 5);
		}
	}
endclass: seq_gen

module top;
	seq_gen g1;
	initial begin
		g1 = new();
		assert( g1.randomize() );
		$display("Sequence: %0p",g1.a);
	end
endmodule 

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Que 5) Write a constraint to generate the pattern 1122334455.

class seq_gen;
	rand int a[];
  constraint a_size { a.size == 10; }
	constraint gen {
		foreach( a[i] ) {
			a[i] == ( ( i/2 ) + 1 );
		}
	}
endclass: seq_gen

module top;
	seq_gen g1;
	initial begin
		g1 = new();
		assert( g1.randomize() );
        $write("Sequence: ");
        foreach( g1.a[i] )
        begin
		    $write("%0d",g1.a[i]);
        end
	end
endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Que.6) Write a code to generate a random number between 1.35 and 2.57.

class seq_gen;
	rand int data;
    real value;
	constraint a_size { data inside {[135:257]} ;}
  
  function void post_randomize();
    value = data / 100.0;
    $display("\t\t Unique value is %.2f",value);
  endfunction
endclass: seq_gen 

module top;
	seq_gen g1;
	initial begin
		g1 = new();
		repeat (10) 
			assert( g1.randomize() );
		end
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Que.7) Write a constraint to generate the pattern 0102030405.

class seq_gen;
	rand int a[];
	constraint a_size { a.size == 10;}
	constraint seq {
		foreach ( a[i] ) {
			if( i%2 != 0 )
				a[i] == (( i/2 ) + 1);
			else
				a[i] == 0; 
		}
	}
endclass: seq_gen 

module top;
	seq_gen g1;
	initial begin
		g1 = new();
		assert( g1.randomize() );
		//$display("Sequence: %p",g1.a);
        $write("\t\t\t The Required Pattern is: ");
        foreach( g1.a[i] )
            $write("%0d",g1.a[i]);
    end
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Que.8.1) Write a constraint to generate random values 25, 27, 30, 36, 40, 45 using "set membership."

class seq_gen;
	randc int value;
  constraint val { value inside { 25, 27, 30, 36, 40, 45};}
endclass: seq_gen

module top;
	seq_gen g1;
	initial begin
		g1 = new();
		repeat( 6 ) 
        begin
            assert( g1.randomize() );
            $display("Random Value: %0d", g1.value);
        end
	end
endmodule

// Que.8.2) Write a constraint to generate random values 25, 27, 30, 36, 40, 45 without using "set membership."

class seq_gen;
	randc int value;
	
	constraint val {
		(value == 25) ||
		(value == 27) ||
		(value == 30) ||
		(value == 36) ||
		(value == 40) ||
		(value == 45);
	}

endclass: seq_gen

module top;
	seq_gen g1;
	initial begin
		g1 = new();
		repeat( 6 )
			begin
				assert( g1.randomize() );
				$display("Random Value : %0d", g1.value);
			end
    	end
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Que.9) Write a constraint to generate a random even number between 50 and 100.

class seq_gen;
	rand int num;
	constraint num_range {
		num >= 50;
		num <= 100;
		num % 2 == 0;
	}
endclass: seq_gen
module top;
	seq_gen g1;
	initial begin
		g1 = new();
		repeat( 10 )
		begin
			assert ( g1.randomize() );
			$display("Even betweent 50 & 100: %0d",g1.num);
		end
    end
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// que 10 Write a constraint for a 32-bit random variable to have 12 number of 1's non-consecutively.

class pkt;
  rand bit [31:0] data;

  constraint c1 { $countones( data ) == 12; }

  constraint c2 {
    foreach( data[i] ){
      if( i>0 && data[i] == 1 )
         data[i] != data[i-1] ;
      }
  }
endclass
module top;
  pkt p;
  initial begin
    repeat( 5 )
    begin
      p = new();
      assert( p.randomize() );
      $display("Data=%b", p.data);
    end
  end
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 11. Write a constraint to generate the factorial of the first 5 even and odd numbers.

class seq;
    rand int even_num[5];
    rand int odd_num[5];
    int even_fact[5];
    int odd_fact[5];

    constraint c1 {
        foreach( even_num[i] ) 
            even_num[i] == (2 * ( i + 1 ));
        foreach ( odd_num[i] )
            odd_num[i] == (2 * ( i + 1 ) - 1);
    }

    function void post_randomize();
        foreach ( even_num[i] )
            even_fact[i] = factorial( even_num[i] );
        foreach ( odd_num[i] )
            odd_fact[i] = factorial( odd_num[i] );
    endfunction

    function int factorial( int n );
        int f = 1;
        for( int j=1; j<=n; j++ )
            f *= j;
        return f;
    endfunction

    function void display();
        $display("Even Numbers : %p", even_num);
        $display("Even Factorials : %p", even_fact);
        $display("Odd Numbers  : %p", odd_num);
        $display("Odd Factorials  : %p", odd_fact);
    endfunction

endclass

module top;
  initial begin
    seq s1 = new();
    if(s1.randomize())
      s1.display();
    else
      $display("Randomization failed!");
  end
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 12. Write a constraint such that even locations contain odd numbers and odd locations contain even numbers.

class seq;
	rand int arr[];
	
	constraint arr_size { arr.size == 10;}

	constraint seq_gen {
		foreach( arr[i] ) {
			if( i%2 == 0 )
					arr[i] == i + 1;
			else
					arr[i] == i - 1;
		}
	}
endclass: seq

module top;
	seq seq_1;
	initial begin
		seq_1 = new();
		seq_1.randomize();
		$display("Sequence: %p",seq_1.arr);
	end
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 13. Write a program to randomize a 32-bit variable but only randomize the 12th bit.

class seq;
	rand bit [31:0] data;

	constraint only12 {
			data[11] inside {0, 1};
	}	
endclass: seq

module top;
	seq g1;
	initial begin
		g1 = new();
		assert(g1.randomize());
		$display("Sequence: %b",g1.data);
	end
endmodule 

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//14. Write a constraint on a two-dimensional array to generate even numbers in the first 4 locations and odd numbers in the next 4 locations. 

class arr_2D;
	rand int arr[2][4];
	
	constraint ev_odd {
		foreach( arr[i,j] ){
			if( i==0 )
				arr[i][j] == ( ( j * 2 ) );
			else
				arr[i][j] == ( ( j * 2 ) + 1 );
		}
	}
endclass

module top;
	arr_2D a1;
	initial begin
		a1 = new();
		a1.randomize();
		$display("Sequence: %p",a1.arr);
	end
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 15. Write a constraint to generate an array with unique values and multiples of 3.

class arr_unique;
	rand bit [4:0]  arr[10];

	constraint unique_num { 
		unique {arr}; 
		
		foreach( arr[i] )
			arr[i] % 3 == 0;	
	}
endclass: arr_unique

module top;
	arr_unique a1;
	initial begin
		a1 = new();
		a1.randomize();
		$display("Sequence: %p",a1.arr);
	end
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 16. Write a constraint to generate unique numbers in an array without using the "unique" keyword.

class pkt;
  rand bit [4:0] data [15]; // 15 element each of 5 bit wide

  constraint c1 {
    foreach ( data[i] )
      data[i] inside {[0:15]};

    foreach( data[i] ){
      foreach ( data[j] ){
        if ( i != j )
          data[i] != data[j];
      }
    }
  }
endclass
module top;
  pkt p;
  initial begin
    p = new();
    assert( p.randomize() );
    $display("Data = %p", p.data);
  end
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 17. Write a constraint to generate prime numbers between the range of 1 to 100.

class prime_num;
	rand int arr;

	constraint arr_size { arr inside {[1:100]}; }

  function void post_randomize();
    bit flag = 0;
    
    if( arr <= 1)
    begin
      flag = 1;
    end
    else 
    begin
      for( int i=2; i<=arr/2; i++)
      begin
        if( arr % i == 0 )
        begin
          flag = 1;
          break;
        end
      end
    end

    if( flag == 0 )
      $display("\t\t\t Prime number is = %0d",arr);
  endfunction

endclass:prime_num 

module top;
  prime_num n1;
  initial begin
    n1 = new();
    repeat(25)
      n1.randomize();
  end
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 18. Write a constraint to generate a variable with 0-31 bits as 1 and 32-61 bits as 0.

class data_bit;
  rand bit [62:0] data;
  constraint data_logic{
    foreach ( data[i] ) {
      if( i < 32 )
        data[i] == 1;
      else
        data[i] == 0;
    }
  }
endclass: data_bit

module top;
  data_bit d1;
  initial begin
    d1 = new();
    d1.randomize();
    $display("Data = %b",d1.data);
  end
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 19. Write a constraint to generate consecutive and non-consecutive elements in a fixed-size array.

class pkt;
  rand int data1[10];
  rand int data2[10];
  constraint c1 {       // constraint to generate the consecutive elements in a fixed size-array.
    foreach( data1[i] )
      data1[i] inside {[0:9]};
    foreach( data1[i] )
      data1[i] == i;
  }
  constraint c2 {       // constraint to generate the non-consecutive elements in a fixed size-array.
    foreach( data2[i] )
      data2[i] inside {[0:9]};
    foreach( data2[i] )
        foreach( data2[j] )
            if( i!=j )
                data2[i] != data2[j];
    } 
endclass
module top;
  pkt p;
  initial begin
    p = new();
    assert( p.randomize() );
    $display("Consecutive element in F-array: %p", p.data1);
    $display("Non-Consecutive element in F-array: %p", p.data2);
  end
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 20. Write a constraint to randomly generate 10 unique numbers between 99 and 100.

class uniq_num;
  rand int num;
  real value;
  constraint num_range { num inside {[990:1000]}; };
    
  function void post_randomize();
    value = num / 10.0;
    $display("\t\t unique number is: %0.2f",value);
  endfunction

endclass: uniq_num

module top;
  uniq_num n1;
  initial begin
    n1 = new();
    repeat( 10 )
      n1.randomize();
  end
endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 21. Write a constraint such that the array size is between 5 to 10, and the values are in ascending order.

class asc;
  rand bit [4:0] arr [];
  constraint c1 { arr.size inside {[5:10]};
    foreach ( arr[i] )
      if ( i > 0 )
        arr[i] > arr[i-1];
  }

  function void display();
    $display("Size of array '%0d'",arr.size());
    $display("Index Value: ");
    foreach( arr[i] )
    begin
      $write("%0d = %0d, ", i, arr[i]);
    end
    $display("\nAscending array =%p",arr);
  endfunction
endclass: asc

module top;
  asc a1;
  initial begin
    a1 =new();
    repeat( 5 )
    begin
      a1.randomize();
      a1.display();
    end
  end
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 22. Write a constraint to generate even numbers between 10 to 30 using a fixed-size array, dynamic array, and queue.

class pkt;
  randc int arr1[11];     // Fixed-Size Array
  randc int arr2[];       // Dynamic Array
  randc int arr3[$];      // Queue

  constraint c1 {
    foreach ( arr1[i] ){
      arr1[i] inside {[10:30]};
      arr1[i] % 2 == 0;
    }
  }

  constraint c2 {
    arr2.size == 11;
    foreach( arr2[i] ){
      arr2[i] inside {[10:30]};
      arr2[2] % 2 == 0;
    }
  }

  constraint c3 {
      arr3.size == 11;
    foreach( arr3[i] ) {
      arr3[i] inside {[10:30]};
      arr3[i] % 2 == 0;
    }
  }
endclass
module top ;
  pkt p;
  initial begin
    p = new();
    assert( p.randomize() );
    $display("F-array:%p", p.arr1);
    $display("D-array:%p", p.arr2);
    $display("Queue  :%p", p.arr3);
  end
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 23. Write a constraint to generate a 10-bit variable with alternating values (e.g., 1010101010).

class num_10_bit;
  rand bit [9:0] value;
  constraint c1 {
    foreach( value[i] ) {
        value[9] == 1;
        if( i < 9 )
            value[i] != value[i+1];
    }
  }
endclass: num_10_bit

module top;
  num_10_bit n1;
  initial begin
    n1 = new();
    assert(n1.randomize());
    $display("10 Bit value: %b",n1.value);
  end
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 24. Write a constraint demonstra ng the use of the "solve before" constraint.

class seq;
    rand bit a;
    rand bit [3:0] b;
    constraint c1 {
        (a == 0) -> ( b == 1);
        solve a before b;
    }
    function void post_randomize();
        $display("a = %0d, b = %0d", a, b);
    endfunction
endclass
module top;
    seq s1;
    initial begin
        s1 = new();
        repeat( 10 )
            assert( s1.randomize() );
    end
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 25. Write a code to generate unique elements in an array without using the "unique" keyword or constraints.

class pkt;
  bit[4:0] a[10];

  function void pre_randomize();
    a.shuffle();
  endfunction

  function void post_randomize();
    $display("Value of a: %p", a);
  endfunction

  function new();
    for ( int i=0; i<20; i++)
      a[i] = i;
  endfunction

endclass
module top;
  pkt p;
  initial begin
    p = new();
    assert( p.randomize() );
  end
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 26. Write a constraint for a 2D dynamic array to print consecutive elements.

class arr_2d;
  rand int arr[][];

  constraint c1 { 
    arr.size() == 3;
    foreach( arr[i] ) {
      arr[i].size == 4;
    }
  }

  constraint c2 {
    foreach( arr[i] ) {
        foreach( arr[i,j] )
            arr[i][j] == (i+j);
    }
  }
  
endclass: arr_2d

module top;
  arr_2d a1;
  initial begin
    a1 = new();
    a1.randomize();
    $display("Array element: %p",a1.arr);
  end
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 27. Write a constraint to check whether the randomized number is a palindrome.

class pkt;
  randc int number;

  constraint c1 {
    number inside {101, 202, 303, 1001, 1221, 123321, 100, 200, 325}; 
  }

  function int check(int number);
    int num = 0;
    int temp = number;  // keep copy of number
    while( temp != 0 ) begin
      num = (temp % 10) + num * 10;
      temp = temp / 10;
    end
    
    if( num == number )
      $display("%0d is Palindrome.", number);
    else
      $display("%0d is NOT Palindrome.", number);
  endfunction
endclass

module top;
  pkt p;
  initial begin
    p = new();
    repeat( 5 )
    begin
      assert(p.randomize());
      p.check(p.number);
    end
  end
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 28. Write a constraint to generate the Fibonacci sequence.

class seq;
    rand int a[];
    constraint c1 { a.size == 10; }
    constraint c2 {
        foreach( a[i] )
            if( i == 0 )
                a[i] == 0;
            else if( i == 1 )
                a[i] == 1;
            else
                a[i] == a[i-1] + a[i-2];
    }
    function void post_randomize();
        $display("fibbonacci seq: %0p", a);
    endfunction
endclass
module top;
    seq s;
    initial begin
        s = new();
        assert( s.randomize() );
    end
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 29. Write a code to check whether the randomized number is an Armstrong number.

class pkt;
    rand bit [7:0] num;
    constraint c1 { num inside {[100:999]}; }
    
    function void post_randomize();
        int temp, sum, r;
        temp = num;
        for( int i=0; i<3; i++ )
        begin
            r = num % 10;
            sum = ( r**3 ) + sum ;
            num = num / 10;
        end
        if( temp == sum )
            $display("%0d is an armstrong number", temp);
        else
            $display("%0d is not an armstrong number", temp);
    endfunction
endclass

module top;
    initial begin
        pkt p = new();
        repeat( 20 )
            assert( p.randomize() );    
    end
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 30. Write a constraint so that the elements in two queues are different.

class pkt;
  rand int data[$];
  rand int data1[$];

  constraint c1 {
    data.size() == 5;
    data1.size() == 5;
    foreach (data[i])  data[i]  inside {[0:200]};
    foreach (data1[i]) data1[i] inside {[0:200]};
    foreach( data[i] )
      data1[i] != data[i];
  }

endclass
module top;
  pkt p;
  initial begin
    p = new();
    p.randomize();
    $display("Queue 1: %p", p.data);
    $display("Queue 2: %p", p.data1);
  end
endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 31. Write a constraint for a variable where the range 0-100 is 70% and 101-255 is 30%.

class pkt;
  rand bit [7:0]a;
  constraint c1 { a dist {[0:100] := 70, [101:255] := 30 }; }
endclass
module top;
  pkt p;
  initial begin
    repeat( 10 )
    begin
      p = new();
      assert (p.randomize());
      if( p.a < 100 )
        $display("\t\t a = %0d ( Under Dist. [0:100]", p.a);
      else
        $display("\t\t a = %0d ( Under Dist. [101:255]", p.a);
    end
  end
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 32. Write a constraint for a 16-bit variable such that no two consecu ve ones are generated.

class seq;
    rand bit [15:0] num;
    constraint c1 {
        foreach( num[i] )
            if( i > 0 && num[i] == 1 )
                num[i] != num[i-1];
    }
    function void post_randomize();
        $display("value = %0b", num);
    endfunction
endclass
module top;
    seq s;
    initial begin
        s = new();
        assert( s.randomize() );
    end
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 33. Write a constraint to generate a 32-bit number with exactly one-bit high using $onehot().

class pkt;
  rand bit [0:31] data;
  constraint c1 { $onehot(data); }
endclass
module top;
  pkt p;
  initial begin
    p = new();
    repeat( 10 )
    begin
      assert( p.randomize() );
      $display("Data: %b", p.data);
    end
  end
endmodule

class pkt;
  rand bit [31:0] number;
  rand bit [4:0] shift;
  constraint c1 { number == 1 << shift; }
endclass
module top;
  pkt p;
  initial begin
    p = new();
    repeat ( 6 ) begin
      assert( p.randomize() );
      $display("number = %b", p.number);
    end
  end
endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 34. Write a constraint to randomly generate unique prime numbers in an array between 1 and 200, with 7 in the number.

class pkt;
  rand int a[];
  rand int b[$];
  constraint c1 { a.size() == 200; }
  constraint c2 { foreach (a[i]) 
                  a[i] == prime(i); }

  function integer prime ( int val );
    if( val <= 1)
      return 2;

    for ( int i=2; i<val; i++)
    begin
      if( val%i == 0 )
        return 2;
    end
    prime = val;
  endfunction

  function void post_randomize();
    for ( int i=0; i<a.size(); i++)
    begin
      if( a[i] % 10 == 7 )
        b.push_back(a[i]);
    end
  endfunction
endclass
module top;
  pkt p;
  initial begin
    p = new();
    p.randomize();
    $display("Prime No.: %p", p.b);
  end
endmodule

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 35. Write a constraint on a 16-bit random vector to generate alternating pairs of 0's and 1's.

class pkt;
  rand bit [15:0] data;
  constraint c1 {
      foreach( data[i] ){
        if( i % 2 == 0 && i < 15 )
          data[i+1] == data[i];
        if( i >= 2 )
          data[i] != data[i-2];
      }
  }
endclass
module top;
  pkt p;
  initial begin
    p = new();
    repeat( 6 ) begin 
      assert ( p.randomize() );
      $display("Data:%b", p.data);
    end
  end
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 36. Write a constraint for a variable such that the number of ones depends on the value of another variable.

class pkt;
    rand bit [4:0] val1;
    rand bit [2:0] val2;
    constraint c1 { $countones(val2) == val1 + 1; }
    function void post_randomize();
        $display("value of a = %0d and b = %0d", val1, val2 );
    endfunction
endclass
module top;
    pkt p;
    initial begin
        p = new();
        repeat( 10 )
        begin
            assert( p.randomize() );
        end
    end
endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// 37. Write a constraint such that the sum of any three consecutive elements in an array is even.
class pkt;
  rand bit [3:0] data[10];
  constraint c1 {
      foreach( data[i] ){
        if( i <= 7 )
           ( data[i] + data[i+1] + data[i+2] ) % 2 == 0;
      }
  }
endclass
module top;
  pkt p;
  initial begin
    repeat( 6 )
    begin
      p = new();
      assert (p.randomize());
      $display("Data: %p", p.data);
    end
  end
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 38. Write a constraint for two random variables such that one variable does not match the other, and five bits are toggled.

class pkt;
  rand bit [7:0] data_in;
  rand bit [7:0] prev_data;

  constraint c1 { data_in != prev_data; }
  constraint c2 { $countones( data_in ) == 5; }
endclass
module top;
  pkt p;
  initial begin
    repeat( 6 )
    begin
      p = new();
      assert( p.randomize());
      $display("\t\tPrevios Data: %b", p.prev_data);
      $display("\t\tData        : %b", p.data_in);
    end
  end
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 39. Write a constraint such that a 4-bit variable is not the same as the last five occurrences.

class pkt;
    rand bit [3:0] a;
    int q[$];
    constraint c1 { !( a inside {q}); }

    function void post_randomize();
        q.push_front( a );
        if( q.size == 6 )
            q.pop_back;
        $display("a = %0d", a);
    endfunction
endclass
module top;
    pkt p;
    initial begin
        p = new();
        repeat( 7 )
            assert( p.randomize() );
    end
endmodule

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//40. Write a code to simulate cyclic randomization behavior without using the "randc" keyword. 
class pkt;
  bit [4:0] data[15];

  function new();
    foreach( data[i] )
    begin
      data[i] = i;
    end
  endfunction
 
  function void data_shuffle();
    data.shuffle();
  endfunction

endclass
module q40;
  pkt p;
  initial begin
    repeat( 5 )
    begin
      p = new();
      p.data_shuffle();
      $display("Unique values: %p", p.data);
    end
  end
endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 41. Write a constraint for payload generation, where the size is between 11 and 22, and each value is 2 greater than the previous.

class pkt;
    rand int payload[];
    constraint c1 { payload.size inside {[11:22]}; }
    constraint c2 { 
        foreach( payload[i] )
            payload[i] inside {[0:100]}; 
    }
    constraint c3 {
        foreach( payload[i] )
            if( i>0 )
                payload[i] == payload[i-1] + 2;
    }
    function void post_randomize();
        $display("Payload = %0p", payload);
    endfunction
endclass
module top;
    pkt p;
    initial begin
        p = new();
        assert( p.randomize() );
    end
endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 42. Write a constraint to print unique elements in a 2D array without using the "unique" keyword.

class pkt;
    rand bit [3:0] arr[][];
    constraint c1 { arr.size() == 3; }  // rows
    constraint c2 { 
        foreach( arr[i] )
            arr[i].size() == 4; // column
    }
    constraint c3 {
        foreach( arr[i,j] ){
            foreach(arr[x,y]) {
                if ((i != x) || (j != y)) 
                    arr[i][j] != arr[x][y];
            }        
        }
    }
endclass

module top;
    pkt p;
    initial begin
        p = new();
        assert(p.randomize()); // randomize once
        $display("arr=%p", p.arr); 
    end
endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//43. Write a constraint for sorting elements in a dynamic array using constraints.
class pkt;
  rand bit [4:0] data[];

  constraint c1 { data.size() == 15; }
  constraint c2 { 
      foreach( data[i] ){
        if( i < 14 )
          data[i] < data[i+1];
      }
  }
endclass
module q43;
  pkt p;
  initial begin
    repeat( 6 )
    begin
      p = new();
      assert( p.randomize());
      $display("Data: %p", p.data);
    end
  end
endmodule

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Q. 44)  Write a constraint to generate the pattern 1221122112211.

class pkt;
    rand bit [3:0] arr[];
    constraint c1 { arr.size == 13; }
    constraint c2 { 
        foreach( arr[i] )
            arr[i] == 1 + (((i+1) & 2) >> 1);
    }
endclass

module top;
    pkt p;
    initial begin
        p = new();
        assert(p.randomize()); // randomize once
        foreach( p.arr[i] )
            $write("%0d", p.arr[i]);
        $display; // newline
    end
endmodule
*/
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////






