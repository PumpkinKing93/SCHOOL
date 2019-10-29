%%%% CSci 117, Lab 6 %%%%
%%%% Tyler Gillette %%%%



% Answer written questions within block comments, i.e. /* */
% Answer program related questions with executable code (executable from within the Mozart UI) 

% Note: While many of these questions are based on questions from the book, there are some
% differences; namely, extensions and clarifications. 

%%%% Page 210 
%%%%     Dictionary already written on pg 199

% Part 1: Control Flow

% For each question, come up with three operations, and test these operations on lists, displaying the input and output in a comment. 
/*
Q1 Binary Fold
The function BFold L F takes a list of integers L and a binary operation on integers F, and returns the binary fold of the F applied to L, where the binary fold is defined as follows:
• BFold where L contains a single element returns that element
• BFold where L contains two or more elements returns BFold of Bmap L F
  • Bmap applies F to successive pairs of a list as follows:
    • Bmap of a list with two or more elements, e.g.  case X|Y|Ls returns {F X Y} | {Bmap Ls F}
    • Bmap of a list with a single or no element, returns the list, i.e. Bmap [X] F returns [X] and Bmap nil F returns nil
*/


declare
fun {Bmap Xs F} 
case Xs of nil then nil 
[] [X] then [X] 
[] X|Y|Xr then {F X Y}|{Bmap Xr F}
end
end


fun {BFold L F} 
case L of [X] then X
[] nil then nil
[] L|Ls then {BFold {Bmap L|Ls F} F}
end
end

declare Z
Z = fun {$ X Y} X+Y
end

{Browse {BFold [1 3 2 7 9] Z}}

/*



Q2 Nested Fold
The function NFoldL L FZs takes a nested list L and a list of binary operators, value pairs. If FZs is ordered as   [ F1#ZF1 F2#ZF2 F3#ZF3 ... ], you will use the function Fi 
at the nested depth i, performing the right associative fold operation, with the second value of each pair being the initial value of the folds. 
e.g.)
{ NFold [ 1 2 [2 3] [1 [2 3] ] ] [ F#ZF G#ZG H#ZH ] }
F 1 (F 2 (F (G 2 (G 3 ZG)) (F (G 1 (G (H 2 (H 3 ZH)) ZG)) ZF)))

You will raise an error if the nesting depth d is greater than the length of FZs (i.e. There are not enough functions in FZs to match each level of nesting in L)
*/

declare Sum Sub Mul
fun {Sum F L}
   F+L
end

fun {Sub G L}
   G-L
end

fun {Mul H L}
   H*L
end

fun {NFold L B}
   case B of nil then raise illFormedZlength(L) end
      [] B1#D|B2 then  
      case L of nil then D
   [] H|T andthen {IsList H} then 
     {B1 {NFold H B2} {NFold T B}}
   [] H|T then
     {B1 H {NFold T B}}
      end
   end
end


try {Browse {NFold [[4]] [Sum#4 Sub#2 Mul#10]}} 
catch illFormedZlength(L) then {Browse '**Nope**'} end

try {Browse {NFold [2 [4]] [Sum#4 Sub#2 Mul#10]}} 
catch illFormedZlength(L) then {Browse '**Nope**'} end

try {Browse {NFold [4 [2 [2]]] [Sum#4 Sub#2 Mul#10]}} 
catch illFormedZlength(L) then {Browse '**Nope**'} end

try {Browse {NFold [[[[4]]]] [Sum#4 Sub#2 Mul#10]}} 
catch illFormedZlength(L) then {Browse '**Nope**'} end



/*
Q3 Scan
The function ScanL L Z F takes a list L, Initial value Z, and a binary function F. This will return a list with successive left folds. With L = [X1 X2 X3 X4 …] we will get the list
[ Z, F Z X1, F ( F Z X1) X2, ….] where the last element of the output is exactly the FoldL of L Z F. 
*/

/*
declare
fun {scanLA L Z F}
    case L
    of nil then nil
    [] X|Ls then
       {F Z X} | {scanLA Ls {F Z X} F}
    end
end


declare
fun {scanLs L Z F}
    Z|{ScanLA L Z F}
end

*/

% Part 2: Secure Data Types

/*
Secure Dictionary
Implement the list-based declarative dictionary as an ADT, as in Figure 3.27 on p. 199, but in a secure way, using wrap and unwrap, as outlined in Section 3.7.6 (Page 210). 
Each dictionary will come with two extra features, a binary function F on integers and an integer Z. Your dictionary will have integers as keys (aka features) and pairs of integer lists and atoms 
as values. The key for each list-atom pair will be calculated from the list by performing a left-associative fold on the list using F and Z. As a result, the Put function will not take a Key as 
argument but calculate it from the Value. Make sure the code for Put is updated appropriately.

After creating your dictionary, run several Put, CondGet, and Domain examples, displaying the inputs and outputs in a comment. Answer the following questions:
a) What happens when two distinct lists have the same Key value after the folding operation, based on the definition of Put from the book? Give an example.
b) Describe the NewWrapper function on page 207. How does the wrapper/unwrapper created by this function secure the dictionary?
c) Are the F and Z values associated with the dictionary secure? If not, how could you make these secure as well?
*/

declare

proc {NewWrapper ?Wrap ?Unwrap} Key={NewName}
in
fun {Wrap X}
fun {$ K} if K==Key then X end end end
fun {Unwrap W} {W Key}
end end

fun {FoldL L F U} case L
of nil then U [] X|L2 then
{FoldL L2 F {F U X}}
end end

local
   Wrap Unwrap
   {NewWrapper Wrap Unwrap}
   fun {NewDictionary2} nil end



   fun {Put2 Ds Key Value}
      case Ds of nil then [Key#Value]
      [] (K#V)|Dr andthen Key==K then
     (Key#Value) | Dr
      [] (K#V)|Dr andthen K>Key then
     (Key#Value)|(K#V)|Dr
      [] (K#V)|Dr andthen K<Key then
     (K#V)|{Put Dr Key Value}
      end
   end

   fun {CondGet2 Ds Key Default}
      case Ds of nil then Default
      [] (K#V)|Dr andthen Key==K then V
      [] (K#V)|Dr andthen K > Key then Default
      [] (K#V)|Dr andthen K < Key then
     {CondGet Dr Key Default}
      end
   end

   fun {Domain2 Ds} {Map Ds fun {$ K#_} K end} end
in
   fun {NewDictionary}
      {Wrap {NewDictionary2}}
   end
   fun {Put Ds K Value}
      {Wrap {Put2 {Unwrap Ds} K Value}}
   end
   fun {CondGet Ds K Default}
      {CondGet2 {Unwrap Ds} K Default}
   end
   fun {Domain Ds}
      {Domain2 {Unwrap Ds}}
   end

end
{Browse {NewDictionary}}


% Part 3: Declarative Concurrency

/*
Given the following program code:
local A B C in 
  thread A in
    A = 5  %%%%%%%%%%%%%%%%%%%%%%%%%% T1
  end
  thread B in
    B = 7  %%%%%%%%%%%%%%%%%%%%%%%%%% T2
  end
  thread C in
    C = 3  %%%%%%%%%%%%%%%%%%%%%%%%%% T3
  end
  if C > A then  %%%%%%%%%%%%%%%%%%%% S1
    {Browse “C is greater than A”} %% S2
  else
    if B > A then  %%%%%%%%%%%%%%%%%% S3
      {Browse “B is greater than A”}% S4
    end
  end
end

What are all the possible interleavings of the statements T1, T2, T3, S1..S4? How about when A = 2?

Should have
%19 When A=5
%22 When A=2







When A = 5
-----------------------------------------
1)  [A, B, C, T1, T2, T3, S1, S3, S4]
2)  [A, B, C, T1, T3, S1, T2, S3, S4]
3)  [A, B, C, T2, T1, T3, S1, S3, S4]
4)  [A, B, C, T2, T3, T1, S1, S3, S4]
5)  [A, B, C, T3, T1, S1, T2, S3, S4]
6)  [A, B, C, T3, T2, T1, S1, S3, S4]
7)  [A, T1, B, C, T2, T3, S1, S3, S4]
8)  [A, T1, B, T2, C, T3, S1, S3, S4] 
9)  [A, T1, B, C, T3, S1, T2, S3, S4]
10) [A, B, T1, C, T2, T3, S1, S3, S4]
11) [A, B, T1, C, T3, S1, T2, S3, S4]
12) [A, B, T2, T1, C, T3, S1, S3, S4]
13) [A, B, T1, T2, C, T3, S1, S3, S4]
14) [A, B, T2, C, T1, T3, S1, S3, S4]
15) [A, B, T2, C, T3, T1, S1, S3, S4]
16) [A, B, C, T1, T3, T2, S1, S3, S4]
17) [A, B, C, T3, T1, T2, S1, S3, S4]
18) [A, T1, B, C, T3, T2, S1, S3, S4]
19) [A, B, T1, C, T3, T2, S1, S3, S4]
 


When A = 2
-----------------------------------------
1 [A,B,C,T1,T2,T3,S1,S2,S3,S4]
2 [A,T1,B,C,T2,T3,S1,S2,S3,S4]
3 [A,B,T1,C,T2,T3,S1,S2,S3,S4]
4 [A,B,T2,C,T1,T3,S1,S2,S3,S4]
5 [A,B,C,T2,T1,T3,S1,S2,S3,S4]
6 [A,T1,B,T2,C,T3,S1,S2,S3,S4]
7 [A,B,T2,T1,C,T3,S1,S2,S3,S4]
8 [A,B,T1,T2,C,T3,S1,S2,S3,S4]
9 [A,B,C,T3,T1,T2,S1,S2,S3,S4]
10 [A,B,C,T1,T3,T2,S1,S2,S3,S4]
11 [A,T1,B,C,T3,T2,S1,S2,S3,S4]
12 [A,B,T1,C,T3,T2,S1,S2,S3,S4]
13 [A,B,T2,C,T3,T1,S1,S2,S3,S4]
14 [A,B,C,T3,T2,T1,S1,S2,S3,S4]
15 [A,B,C,T2,T3,T1,S1,S2,S3,S4]
16 [A,B,C,T3,T1,S1,T2,S2,S3,S4]
17 [A,B,C,T1,T3,S1,T2,S2,S3,S4]
18 [A,B,T1,C,T3,S1,T2,S2,S3,S4]
19 [A,T1,B,C,T3,S1,T2,S2,S3,S4]
20 [A,B,C,T3,T1,S1,S2,T2,S3,S4]
21 [A,B,C,T1,T3,S1,S2,T2,S3,S4]
22 [A,B,T1,C,T3,S1,S2,T2,S3,S4]
23 [A,T1,B,C,T3,S1,S2,T2,S3,S4]

*/
