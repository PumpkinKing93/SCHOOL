%%%% CSci 117, Lab 9 %%%%
%%%% Tyler Gillette %%%%

%============================================================================================================%
%============================================================================================================%
%============================================================================================================%

/* Question 1: Rewrite the function SumList, and the function ScanL, 
where the state is stored in a memory cell when the function is called, 
and a helper function performs the recursive algorithm. */

declare
fun {SumList L}
  A = {NewCell 0}
  fun {SumListH L}
      case L of nil then @A
      [] L|Lr then A:=@A+L {SumListH Lr}
      end
   end
in
  {SumListH L}
end

/* ScanL will be handled similarly, 
except the initial value of your memory cell A will be the Z value passed into the function */

declare
fun {ScanL L F Z}
  A = {NewCell Z}
  fun {ScanUp L}
    local C in
    C = @A
    case L of nil then C|nil
    [] X|Ls then
      A:= {F C X}
       C|{ScanUp Ls}
    end
    end
  end
in
  {ScanUp L}
end



fun {Sum L D}
 L + D
   end


{Browse {ScanL [1 2 3] Sum 0}}

%============================================================================================================%

/* Question 2: Assuming a memory cell A points to a list of integers, 
write a procedure that sums this list and assigns the sum to A. 
You are only allowed to use a single memory cell in your procedure. */

declare
A = {NewCell [0 2 4 6 1 3]}
proc {SumL A}
  B = {NewCell @A#0} % Initialize B with some value
  proc {SumLHelp}
      case @B of nil#Z then B := Z
      [] (X|Xr)#Z then
         B := Xr#X+Z
         {SumLHelp}
      end 
  end
  % SumList algorithm code, which only has access to memory cell B, you cannot use A in this procedure
in
 {SumLHelp} % B is now pointing to the sum of @A
 A := @B    % @A is now the value of its former list, summed
end

{SumL A}
{Browse @A} % will print 16

%============================================================================================================%


/* Question 3: Assuming a memory cell A points to a list of integers, 
write a procedure that reverses this list and assigns the reversed list to A. 
You are only allowed to use a single memory cell in your procedure. 
This will be handled similarly to Question 2, except your initialization of B will be different. */

declare
A = {NewCell [0 1 2 3 4 5]}
proc {RevL A}
   B = {NewCell @A#nil}
   proc {RevLH}
      case @B of nil#Z then B := Z
      [] (X|Xr)#Z then
	 B := Xr#(X|Z)
	 {RevLH}
      end
   end
in
   {RevLH}
   A := @B
end

{RevL A}
{Browse @A}

%============================================================================================================%


/* Question 4: Rewrite the functional stream that generates the numbers
starting form 0 then adding one up to infinity, (0 1 2 3 …), 
but instead use a local memory cell, such that {Generate} will return a zero argument function, 
and executing that zero argument function gives the next value in the stream. */

declare
fun {Generate}
  local A = {NewCell 0} in 
     proc {$} {Browse @A} % points to 0 
	    A := @A+1
     end
  end
end

% For example,
GenF = {Generate}
{GenF} % outputs 0
{GenF} % outputs 1
{GenF} % outputs 2

%============================================================================================================%

/* Question 5: Return to Nested List Flattening. */
/* (a) Use a memory cell to count the number of list creation operations i.e. when ‘|’ is used, 
within the two versions of flattening a nested list from lab 5. */

%%%% 1)
declare
local A = {NewCell 0}
   fun {Append L1 L2 A}
      case L1 of X|T then
	 A := @A + 1
	 X|{Append T L2 A} [] nil then L2
      end
   end

fun {Flatten Xs}
      case Xs
      of nil then nil
      [] X|Xr andthen {IsList X} then
	 {Append {Flatten X} {Flatten Xr} A}
      [] X|Xr then
	 A := @A+1
	 X|{Flatten Xr}
      end 
   end
   in
   {Browse {Flatten [[1 2 3] [1 2] [1 2 [2 3 4]] 3 4]}}
   {Browse @A}
end

%%%% 2)
local A = {NewCell 0}
   fun {Flatten Xs}
      proc {FlattenD Xs ?Ds}
	 case Xs
	 of nil then Y in Ds=Y#Y
	 [] X|Xr andthen {IsList X} then Y1 Y2 Y4 in
	    Ds=Y1#Y4 
	    {FlattenD X Y1#Y2}
	    {FlattenD Xr Y2#Y4}
	 [] X|Xr then Y1 Y2 in
	    A := @A+1
	    Ds=(X|Y1)#Y2 {FlattenD Xr Y1#Y2}
	 end 
      end Ys
   in {FlattenD Xs Ys#nil} Ys
   end
   in
    {Browse {Flatten [[3 5] [6 4] 3 [1 2] 5 [1 3 4] 3 4]}}
   {Browse @A}
   end

/* (b) Verify that your program is correct by running the example [[1 2 3] [1 2] [1 2 [2 3 4]] 3 4] from lab 5, 
along with three other examples of your choosing. */

%  1) {Browse {Flatten [[9 4 3] [1 2] 5 [1 3 4] 3 4]}} = [9 4 3 1 2 3 1 3 4 3 4], 19 times 
%  2) {Browse {Flatten [[1 2 3] [1 2] [1 2 [2 3 4]] 3 4]}}[1 2 3 1 2 1 2 2 3 4 3 4], 11 times 

%  1) {Browse {Flatten [[1 2 3] [1 2] [1 2 [2 3 4]] 3 4]}} = [ 1 2 3 1 2 6 5 1 2 2 3 4 3 4 24], 42 times
%  2) {Browse {Flatten [[1 2 3] [1 2] [1 2 [2 3 4]] 3 4]}} [ 1 2 3 1 2 6 5 1 2 2 3 4 3 4 24],15 times

%  1) {Browse {Flatten [[3 5] [6 4] 3 [1 2] 5 [1 3 4] 3 4]}} = [3 5 6 4 3 1 2 5 1 3 4 3 4], 22 times
%  2) {Browse {Flatten [[3 5] [6 4] 3 [1 2] 5 [1 3 4] 3 4]}} = [3 5 6 4 3 1 2 5 1 3 4 3 4], 13 times


/* (c) Create a function that takes in a list of nested lists, 
and returns the average for both flatting function of list creation operations for these nested lists. 
Test this on the list containing all possible nested lists of 3 elements with nesting depth 2,
 i.e., [[1 2 3]  [[1] 2 3]  [[1] [2] 3] … and give the average for both of the flattening functions. */


%%%Part 1

declare
A = {NewCell 0}
fun {Append L1 L2 A}
   case L1 of X|T then
      A := @A + 1
      X|{Append T L2 A} [] nil then L2
   end
end
 
declare    
fun {Flatten Xs}
   case Xs
   of nil then nil
   [] X|Xr andthen {IsList X} then
      {Append {Flatten X} {Flatten Xr} A}
   [] X|Xr then
      A := @A+1
      X|{Flatten Xr}
   end 
end
   
declare
G = {NewCell 0}
C = {NewCell 0}
fun {Average L}
   case L of nil then @G div @C
   [] X|Xr then D in
      C := @C + 1
      D = {Flatten X}
      G := @G + @A
      A := 0
      {Average Xr}
   end
end

{Browse {Average [[1 2 3]  [[1] 2 3]  [[1] [2] 3] [1 [2] 3] [1 2 [3]] [[1] 2 [3]] [1 [2] [3]] [[1 2] 3] [[1] [2 3]] [[1 2] [3]] [1 [2 3]] [[1] [2] [3]] [[1 2 3]]]}}


%%%Part 2
declare
A = {NewCell 0}
fun {Flatten Xs}
      proc {FlattenD Xs ?Ds}
	 case Xs
	 of nil then Y in Ds=Y#Y
	 [] X|Xr andthen {IsList X} then Y1 Y2 Y4 in
	    Ds=Y1#Y4 
	    {FlattenD X Y1#Y2}
	    {FlattenD Xr Y2#Y4}
	 [] X|Xr then Y1 Y2 in
	    A := @A+1
	    Ds=(X|Y1)#Y2 {FlattenD Xr Y1#Y2}
	 end 
      end Ys
in {FlattenD Xs Ys#nil} Ys
end

   
declare
G = {NewCell 0}
C = {NewCell 0}
fun {Average L}
   case L of nil then (@G div @C) 
   [] X|Xr then D in
      C := @C + 1
      D = {Flatten X}
      G := @G + @A
      A := 0
      {Average Xr}
   end
end
  
{Browse {Average [[1 2 3]  [[1] 2 3]  [[1] [2] 3] [1 [2] 3] [1 2 [3]] [[1] 2 [3]] [1 [2] [3]] [[1 2] 3] [[1] [2 3]] [[1 2] [3]] [1 [2 3]] [[1] [2] [3]] [[1 2 3]]]}}


%============================================================================================================%
%============================================================================================================%
%============================================================================================================%






