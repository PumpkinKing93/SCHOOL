%%%% CSci 117, Lab 5 %%%%
%%% Tyler Gillette %%%

% Answer written questions within block comments, i.e. /* */
% Answer program related questions with executable code (executable from within the Mozart UI) 

% Note: While many of these questions are based on questions from the book, there are some
% differences; namely, extensions and clarifications. 

% Part 1 (Invariants and Proofs)
% For this section, you will state the invariant, and write an inductive proof (base case and inductive case
% similar to the Fact example from class)
declare

% (a)
local
  fun {IterLength I Ys}
    case Ys
    of nil then I
    [] _|Yr then {IterLength I+1 Yr} end
    end
  in
    fun {Length Xs}
      {IterLength 0 Xs}
    end 
  end

/* 
% Base: ItterLength 0 []
% Invariant: Sol = I + Length(Ys)
% IH - Sol = I+1 + Length(yr)
% sol = (I+1)-1 + (Length(yr)+1)
% sol = (I) + (Length(yr)+1)
% ys = Length(yr) + 1
% Sol = I + Length(Ys)
*/


% (b)
local
  fun {IterReverse Rs Ys}
    case Ys
    of nil then Rs
    [] Y|Yr then {IterReverse Y|Rs Yr} end
    end 
  in
    fun {Reverse Xs} 
      {IterReverse nil Xs}
    end 
  end

/*
Invariant: Rev(Ys) + Rs
Base: IterReverse = Rs nil 
Ys = Yr
Rs = Y|Rs
IH = Rev(Ys) + Y|Rs
Sol = Rev(Ys)Y + Rs
Sol = Rev(Ys) + Rs

 */



% (c) - write an iterative version of SumList, then find the invariant and create an inductive proof

%******* Non-iterative version of SumList ************
fun {SumList L} 
  case L
  of nil then 0
  [] X|L1 then X+{SumList L1} 
  end
end
%******* Non-iterative version of SumList ************
/*
declare
fun {SumList Xs}
   fun {IterSum Ys A}
      case Ys
      of nil then A
      [] Y|Yr then {IterSum Yr A+Y}
      end
   end
in
   {IterSum Xs 0}
end

 */



/*
Invariant: X|Xs =  X + Xs
Base: Xs = []
IH = IterSum(Yr A+Y)
Sol = X + Sum (L1)


start state: (0, Xs)
Intermediate state: (current result, remaining list) = (A, Ys)
Relationship with the next state: (A, Ys) => (A + Y, Yr)

 */




% (d)
% Already written out.
% need the invariance.
% inductive and recursive.

fun {Merge Xs Ys} 
  case Xs # Ys
  of nil # Ys then Ys
  [] Xs # nil then Xs
  [] (X|Xr) # (Y|Yr) then
     if X<Y then X|{Merge Xr Ys} 
     else Y|{Merge Xs Yr}
     end
  end
end

/*
Invariant: List = For all natural numbers n, if length(Xs) + length(Ys) = n and both Xs and Ys are sorted, then {Merge Xs Ys} is a sorted list of length n.
base case: Xs = nil
base case: Ys = nil
IH: if X < Y then Append(X {Merge Xr Ys})
Sol: Merge([1 2] [3 4])
Sol: 1 < 3 then [1 3 4]
Sol: 2 < 1 then [1 2 3 4]

 */


fun {MergeSort Xs}
  fun {MergeSortAcc L1 N}
    if N==0 then 
      nil # L1
    elseif N==1 then 
      [L1.1] # L1.2
    elseif N>1 then
      NL=N div 2
      NR=N-NL
      Ys # L2 = {MergeSortAcc L1 NL} 
      Zs # L3 = {MergeSortAcc L2 NR}
    in
      {Merge Ys Zs} # L3
    end 
  end
in
  {MergeSortAcc Xs {Length Xs}}.1
end


/*
Invariant:  For all natural numbers n, if {MergeSortAcc L n} == L1 # L2, then {MergeSortAcc L N} will return a sorted merged list of N length.
base case: N == 0
base case: N == 1
difference lists:
IH:

 */


% Part 2

% 1. Section 3.4.2 defines the Append function by doing recursion on the first argument. 
%    What happens if we try to do recursion on the second argument? Here is a possible solution:

fun {Append Ls Ms} 
  case Ms
  of nil then Ls
  [] X|Mr then {Append {Append Ls [X]} Mr} 
  end
end

% Is this program correct? Does it terminate? Why or why not?
/*  run on an example and exaplain.
no you cannot append on a second list.
you cannot append recursivly.
*/

/*
the list doesnt get smaller in the inner call.
this will create an infinite loop.
in order to have a proper recursion, you need the recursive call to be atleast n-1 smaller than the original call.


*/



% 2. This exercise explores the expressive power of dataflow variables. 
%    In the declarative model, the following definition of append is iterative:

fun {Append Xs Ys} 
  case Xs
  of nil then Ys
  [] X|Xr then X|{Append Xr Ys} 
  end
end

% We can see this by looking at the expansion:

proc {Append Xs Ys ?Zs} 
  case Xs
  of nil then Zs=Ys 
  [] X|Xr then Zr in
    Zs=X|Zr
    {Append Xr Ys Zr}
  end 
end

% This can do a last call optimization because the unbound variable Zr can be put in the list 
% Zs and bound later. Now let us restrict the computation model to calculate with values only. 
% How can we write an iterative append? One approach is to define two functions: (1) an 
% iterative list reversal and (2) an iterative function that appends the reverse of a list to 
% another. Write an iterative append using this approach.

% Note - by values only, we mean that every identifier must be bound to a value upon declaration

/* 
write an append function that is itterative and using only values that are bound at time of creation.
when identifiers are created, they must be bound. reversal will be thr trick to doing it.

declare L M 
L = [1 2 3 4 5 6 7 8 9]
M = [10 11 12 13 14 15]

declare
fun {Append Xs Ys}
   fun {RevAI Xs Ys}
      case Xs
      of nil then Ys
      [] X|Xr then {RevAI Xr X|Ys} end
   end
   fun {Reverse Xs}
      fun {ReverseIter Xs A}
     case Xs
     of nil then A
     [] X|Xr then {ReverseIter Xr X|A} end
      end
   in
      {ReverseIter Xs nil}
   end
in
   {RevAI {Reverse Xs} Ys}
end

{Browse {Append L M}}

 */



% 3. Calculate the number of operations needed by the two versions of the Flatten function given 
%    in Section 3.4.4. With n elements and maximal nesting depth k, what is the worst-case complexity 
%    of each version? 
%    Note - Assume IsList uses constant time to check if an input is a list and the append in the 
%           first function works in O(n) time

%  First, run the functions on the example [[1 2 3] [1 2] [1 2 [2 3 4]] 3 4] and give the exact number
%  of operations for execution.

fun {Flatten Xs} 
  case Xs
  of nil then nil
  [] X|Xr andthen {IsList X} then
    {Append {Flatten X} {Flatten Xr}} 
  [] X|Xr then
    X|{Flatten Xr}
  end 
end

/*
41 times

*/

fun {Flatten Xs}
  proc {FlattenD Xs ?Ds}
    case Xs
    of nil then Y in Ds=Y#Y
    [] X|Xr andthen {IsList X} then Y1 Y2 Y4 in
      Ds=Y1#Y4 
      {FlattenD X Y1#Y2}
      {FlattenD Xr Y2#Y4}
    [] X|Xr then Y1 Y2 in
      Ds=(X|Y1)#Y2 {FlattenD Xr Y1#y2}
    end 
  end Ys
  in {FlattenD Xs Ys#nil} Ys
end


/*
7 times


*/



% 4. The following is a possible algorithm for sorting lists. Its inventor, C.A.R. Hoare, called it 
%    quicksort, because it was the fastest known general-purpose sorting algorithm at the time it 
%    was invented. It uses a divide and conquer strategy to give an average time complexity of O(n log n).
%    Here is an informal description of the algorithm for the declarative model. 
%    Given an input list L. 
%    Then do the following operations:
%      (a) Pick L’s first element, X, to use as a pivot.
%      (b) Partition L into two lists, L1 and L2, such that all elements in L1 are less than X and 
%          all elements in L2 are greater or equal than X.
%      (c) Use quicksort to sort L1 giving S1 and to sort L2 giving S2.
%      (d) Append the lists S1 and S2 to get the answer.
%    Write this program with difference lists to avoid the linear cost of append.



/*
figure out the invariable and prove.
using difference lists.
write quick sort, and then figure out how to use difference lists.
read the section.
 */

 /*
declare
fun {QuickSort Ls}
   fun {QuickSortItter Ls E}
      case Ls
      of nil then E
      [] L|Lr then Ys Zs in
     {Divide L Lr Ys Zs}
     {QuickSortItter Ys L|{QuickSortItter Zs E}}
      end
   end
   proc {Divide Ls P ?Ys ?Zs}
      case Ls
      of nil then Ys=nil Zs=nil
      [] L|Lr then
     if L < P then Ys = L|{Divide Lr P $ Zs}
     else Zs = L|{Divide Lr P Ys $} end
      end
   end
in
   {QuickSortItter Ls nil}
end

{Browse {QuickSort [9 3 7 2 6 6 4 3 1 3 2 1 0]}} 

 */



