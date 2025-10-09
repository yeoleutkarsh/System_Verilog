// What is an array?
// An array is a collection of same type of variable.
// System verilog array offers much flexibility in building complicated / data structures through the different types of arrays.
// TYPES OF ARRAY ::
// 1] Static Array :
//              A static array is array whose size is known in compilation time.
//              It is also called as a fixed array.
// Static arrays can declared in two forms:
//      1. Packed type(1D,2D,3D) --> Dimensions declared before the variable name.
//      2. Unpackedtype(1D,2D,3D) --> Dimension declared after the variable name. 
//                                    Each data have unique (dedicative) memory location.
// Note: Packed type array only supports (bit and logic data types). Single dimension packed array is also called as vector.
// bit[3:0][7:0]fixed_2D_arr;      => 2D packed type.
// bit[2:0][3:0][7:0]fixed_3D_arr; => 3D packed type.
// Note : We can achieve bit select and part select in packed array.
// byte unpacked1[3:0]; => unpacked type verbose declaration.
// int unpacked2 [4];   => unpacked type compact declaration.
// byte data[2][4];     => 2D unpacked type.
// bit[3:0][7:0]data[1][2][3];  => 3D unpacked type.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 2] Dynamic Array ::
// Dynamic array is unpacked type, whose size can set / changed during runtime.
// Advantage of dynamic array :
//          In some application, size will vary based on behaviour. 
//          In this situation fixed type (static) array is not convenient to use, so we are usingd ynamic array.
// Memory creation during runtime:
//          The default size of dynamic array is zero until it is set by NEW.
//          SYNTAX => <datt_type> <variable_name> [];
// METHODS OF DYNAMIC ARRAY:
//       1.Size();      => returns the size of dynamic array.
//       2.Delete();    => delete entire array.
//  arr1=new[10](arr1);     =>  Arr1 is resized from 5 locations to 10 and it will retain old value.
//  arr1=new[10];           => This will completely create new memory locations.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 3] Associative Array ::
//                  Associative allocate storage only when it is used. 
//                  When size of memory is unknown then we will use associative array.
//                  Memory automatically assigned using a "key" while declaring.
//                  SYNTAX: <data_type>array_name[<key>];
//                  Associative array mainly used for large memory creation purpose.
// ##Specialsupport:
//          1. Index can be string type also.
//          2. We can delete particular index in associative array.
// METHODS IN DYNAMIC ARRAY:
// 1.num()          --> return the total no. of index in an array ::: similar to size().
//                      size() is also used in associative array.
// 2.delete()       --> delete the entire array.
// 3.delete(index)  --> delete the perticular index.
// 4.exists(index)  --> return '1' if index exists or '0' if not.
// 5.first(var)     --> return the first index to 'var'.
// 6.last(var)      --> return the last index to 'var'.
// 7.prev(var)      --> return the previous index.
// 8.next(var)      --> return the next index
// NOTE: [key]/[index]canbe:
//              1. Integer index.
//              2. String index.
//              3. Class index.
//              4. Wildcard index(*).
//              5. Single packed array as index.
//  NOTE: Some class type is also used in index of associative array, but it is rarely used.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 4] Queue Arrays::
// Queue array is follows first in first out scheme. 
// We can push or pop the data in queue array.
// This queue array is identified by '$' symbol inside the [].
// SYNTAX => Data_type queue_array_name[$];
// TYPES OF QUEUE ARRAY:
//              1. BOUNDED QUEUE ARRAY => Bounded queue array is limited with number of entries.
//              2. UNBOUNDED QUEUE ARRAY => Number of entries is not limited in unbounded queue array.
// METHODS IN QUEUE ARRAYS:
//          1.size()                    --> return the size of the array.
//          2.insert(index,value)       --> insert the 'value' at array['index']
//          3.delete(index) or delete() --> particular index or complete array will be deleted.
//          4.push_front(value)         --> push the 'value' to the front.
//          5.pop_front()               --> pop the data at front and return a value.
//          6.push_back(value)          --> push the 'value' to the back.
//          7.pop_back()                --> pop the data at back (at last) and return a value.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 5] ARRAY REDUCTION METHODS:
//          1.sum()         --> return the sum of all the element in an array.  a[0]+a[1]+...+a[n]
//          2.product()     --> return the product of all element in an array.  a[0]*a[1]*a[2]*...*a[n]
//          3.and()         --> return bit-wise AND of all the element.         ((a[0]&a[1])&a[2])...&a[n]
//          4.or()          --> return bitwise OR of all the element.
//          5.xor()         --> return bitwise XOR of all the element.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 6] ARRAY ORDERING METHODS:
// This helps to arrange the elements in the array.
// This supports all type of unpacked arrays.
// Array ordering method not supported for associative array.
//          1.reverse()     --> reverse the element in an array.
//          2.sort()        --> arrange the element in ascending order.
//          3.rsort()       --> arrange the element in descending order.
//          4.shuffle()     --> randomize the order of element in an array.
// NOTE: WITH keyword not supported.
