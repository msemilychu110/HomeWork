# ReferenceVsValueTypes Assignment

-What each is (reference and value type)
     Reference type share one copy while value type makes a copy each time. Modifiying data in reference type affect all variable pointing to the same value while modifying data in value type doesn't affect the other variables. Example of value types are Enum, struct, tuple, example of reference type is Class. 
    
-how are they different 

Reference type has inheritance while value type doesn't. Value type has its own initialization while reference type doesn't.

-how they are utilized in iOS, Swift, and ObjC

reference types are stored in heap, and value types are stored in stack. stack is used for static memory allocation and heap for dynamic memory allocation, both stored in computer' RAM. stack is LIFO. stack is very efficient and fast. stack automatically destroy it's object when it exists. but heap doesn't and it needs external work to do the job like ARC. heap is slower compared to stack, hence value types are faster than reference type. 

-pros and cons to either 

pros of value types: value types are faster at runtime than reference types. value type can enforce immutability. if you declare a let you can't change it's properties, while class  you can change immutability. multithreading is safe for value types than reference type

cons of value types: no inheritance. can't conform to a class protocol such as NSObjectProtocol. no identity (===) comparison while reference type can.
