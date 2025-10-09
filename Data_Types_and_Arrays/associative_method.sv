module top;
    int arr[int];
    int index;
    int n;

    initial begin
        repeat(10)
        begin
            index = $urandom_range(1, 20);
            arr[index] = $urandom_range(100, 300);
        end
        $display("arr = %p", arr);
        $display("------------------------------------------------------------------------");

        // num method
        n = arr.num();
        $display("num = %0d", n);
        $display("------------------------------------------------------------------------");

        // exists method
        if( arr.exists(13))
            $display("Index 13 is Existed.");
        else
            $display("Index 13 is not Existed.");
        if( arr.exists(50))
            $display("Index 50 is Existed.");
        else
            $display("Index 50 is not Existed.");
        $display("------------------------------------------------------------------------");

        // First Method
        arr.first( index );
        $display("Fisrt Index and value %0d = arr[%0d]", index, arr[index]);
        $display("------------------------------------------------------------------------");

        // Next Method
        arr.next( index );
        $display("Next Index and value %0d = arr[%0d]", index, arr[index]);
        $display("------------------------------------------------------------------------");

        // last Method
        arr.last( index );
        $display("Last Index and value %0d = arr[%0d]", index, arr[index]);
        $display("------------------------------------------------------------------------");

        // prev Method
        arr.prev( index );
        $display("Prev Index and value %0d = arr[%0d]", index, arr[index]);
        $display("------------------------------------------------------------------------");

        // delete Method
        arr.delete( 13 );
        $display(" arr = %p", arr);
        $display("------------------------------------------------------------------------");

        // delete Method
        arr.delete( );
        $display(" arr = %p", arr);
        $display("------------------------------------------------------------------------");

    end
endmodule
