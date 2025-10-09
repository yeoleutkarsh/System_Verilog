module top;
    int que[$];
    int i;
    int n;
    int val;

    initial begin
        repeat( 10 )
        begin
            i = $urandom_range(1, 45);
            que.push_back(i);   // PUSH FROM BACK
            $display("que = %p", que);
        end
        $display("---------------------------------------------");

        n = que.size();         // SIZE OF AN QUEUE
        $display("Size of an queue = %0d", n);
        $display("---------------------------------------------");

       repeat( 10 )
        begin
            i = $urandom_range(1, 45);
            que.pop_back();     // POP FROM BACK
            $display("que = %p", que);
        end
        $display("---------------------------------------------");

        repeat( 10 )
        begin
            i = $urandom_range(1, 45);
            que.push_front(i);     // PUSH FROM FRONT
            $display("que = %p", que);
        end
        $display("---------------------------------------------");

        repeat( 10 )
        begin
            i = $urandom_range(1, 45);
            que.pop_front();     // POP FROM FRONT
            $display("que = %p", que);
        end
        $display("---------------------------------------------");
    
        for( int i=0; i<10; i++)
        begin
            val = $urandom_range(10, 50);
            que.insert(i, val);
            $display("que = %p", que);
        end
        $display("---------------------------------------------");

        que.shuffle();
        $display("shuffled que = %p", que);
        $display("----------------------------------------------");
        
        que.reverse();
        $display("reversed que = %p", que);
        $display("----------------------------------------------");
        

        que.delete(5);  // deleting data at the 5th position.
		$display("delete  the data at 5 th location que=%p",que);
		$display("---------------------------------------------");


        que.delete();   // deleting entire queue.
		$display("delete que=%p",que);
		$display("-----------------------------------------------");
    end
endmodule
