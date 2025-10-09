// Example 1 simple code for semaphore.
module top;
  semaphore key;

  initial begin
    key = new(1);
    fork
      task1();
      task2();
    join_none
  end

  task task1();
    getkey(1);
    #20 putkey(1);
  endtask

  task task2();
    #5 getkey(2);
    #10 putkey(2);
  endtask

  task getkey(int id);
    $display("#%0t :: trying to get a key :: [%0d]", $time, id);
    key.get(1);
    $display("#%0t :: got a key :: [%0d]", $time, id);
  endtask

  task putkey( int id );
    $display("#%0t :: trying to put a key ::[%0d]", $time, id);
    key.put(1);
    $display("#%0t :: put a back key ::[%0d]", $time, id);
  endtask

endmodule

// Example 2 ( access with 4 keys ).
module top;
    semaphore key;
    initial begin
        key = new(4);
        fork
            display();
            display();
            display();
        join
    end
    task display();
        key.get(2);
        $display("%0t :: get method executed", $time);
        #30;
        key.put(2);
        $display("%0t :: put method executed", $time);
    endtask
endmodule

// Example 3 try_get method;
module top;
    semaphore key;
    initial begin
        key = new(4);
        fork
            display(4);
            display(4);
        join
    end
    task display( int k );
        if( key.try_get(4) )
            $display("%0t :: got %0d key", $time, k);
        else
            $display("%0t :: unable to get keys", $time);
        #30;
        key.put(k);
        $display("%0t :: put %0d key", $time, k);
    endtask
endmodule

// Example 4 trying to get more keys in a process.
module top;
    semaphore key;
    initial begin
        key = new(4);   // creating 4 keys
        fork
            display(2);
            display(3);
            display(2);
            display(1);
        join
    end
    task automatic display(int key1);
        key.get( key1 );
        $display($time,"Current Simulation Time, Got %0d keys", key1);
        #30;
        key.put( key1 );
    endtask
endmodule

