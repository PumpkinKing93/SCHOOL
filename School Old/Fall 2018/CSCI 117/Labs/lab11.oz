%%%% Tyler Gillette %%%%%
%%%% 11/8/18 %%%%
%%%% Due: Wed 21st %%%%

%%===========================================================================================================================================================%%

% Part 1: Graph Generation
% (a) Convert the above graph into an adjacency list

/*
0#[2]
1#[4 7]
2#[5 6]
3#[2 5 6]
4#[nil]
5#[6]
6#[5]
7#[nil]
8#[1]
*/

% (b) Write a function that can generate an adjacency list based on an input condition that takes
% two vertices i,j and returns True if the edge i,j is in the graph. This function also takes in the
% bound of vertices in the graph, Low .. High as integers.

declare

fun {Add O T}
O+T==5 
end 

fun {GraphGen Cond L H}
   for I in L..H collect:C do
      {C I#for J in L..H collect:D do
	      if {Cond I J} then {D J} end
	   end}
    end
end

{Browse {GraphGen Add 0 9}}

Graph = {GraphGen fun {$ X Y} {Or (X + 3 == Y) (X + 5 == Y)} end 0 15}
{Inspect Graph}
Graph2 = {GraphGen fun {$ X Y} ({OS.rand} mod 100) > 95 end 0 15}
{Inspect Graph2}

{Browse {OS.rand} mod 10}

fun{GraphP P L H}
    {GraphGen fun {$ X Y} ({OS.rand} mod 100) < P end L H}
end  

 
% (c) Write a function that can generate a graph using the OS.rand function, which takes as input
% a percentage value (integer from 0 to 100) and returns the graph where the probability of an
% edge between any two vertices is the input percentage.


{Browse {OS.rand} mod 10}

fun{GraphP P L H}
    {GraphGen fun {$ X Y} ({OS.rand} mod 100) < P end L H}
end  
%%===========================================================================================================================================================%%





%%===========================================================================================================================================================%%

% Part 2: Adapt transitive closure algorithms
% (a) Read through the section 6.8.1, and describe the first two transitive closure algorithms in
% your own words. What role does the FoldL play in the declarative algorithm? Then step through
% the algorithms with the graph from Part 1, (a). Is the return value the exact same in both
% algorithms?

/**
 * FoldL is joings the one after and the one before.
 */

% (b) For the Declarative algorithm, use memory cells to track (1) number of edges added to the
% adjacency list (you will need to go into the code for Union), (2) number of times SY is returned
% instead of {Union SY SX}, and (3) largest increase in size of SY when {Union SY SX} is called.

declare DeclTrans Succ Union Max Length NEdges NSYreturn LargestSize
NEdges = {NewCell 0}
NSYreturn = {NewCell 0}
LargestSize = {NewCell 0}
fun {DeclTrans G}
  Xs={Map G fun {$ X#_} X end}
in
    {FoldL Xs
        fun {$ InG X}
            SX = {Succ X InG}
        in
            {Map InG
                fun{$ Y#SY}
                    Y#if {Member X SY} then LargestSize:={Max {Length SY} @LargestSize} {Union SY SX} 
                    else NSYreturn:=(@NSYreturn+1) SY 
                    end 
                end}
        end G}
end

fun {Succ X G}
  case G of Y#SY|G2 then
    if X==Y then SY else {Succ X G2} end 
  end
end

fun {Union A B} 
  case A#B
  of nil#B then B
  [] A#nil then A
  [] (X|A2)#(Y|B2) then
    if X==Y then NEdges:=(@NEdges + 1) X|{Union A2 B2} 
    elseif X<Y then NEdges:=(@NEdges + 1) X|{Union A2 B} 
    elseif X>Y then NEdges:=(@NEdges + 1) Y|{Union A B2} 
    end
  end 
end

fun {Max X Y}
    if X > Y then
        X
    else
        Y
    end
end

fun {Length Xs}
    case Xs
    of nil then 0
    [] _|Xr then 1+{Length Xr}
    end
end

% (c) For the Stateful algorithm, use memory cells to track (1) number of edges added and (2)
% number of times GM is accessed (including updates).

declare StateTrans CountEdge CountGM
CountEdge = {NewCell 0}
CountGM = {NewCell 0}
proc {StateTrans GM} 
  L={Array.low GM} 
  H={Array.high GM}
in
    CountGM := @CountGM + 2
  for K in L..H do
    for I in L..H do
        CountGM := @CountGM + 1
      if GM.I.K then
        for J in L..H do
            CountGM := @CountGM + 1
          if GM.K.J then
            CountGM := @CountGM + 1
            CountEdge := @CountEdge + 1
            GM.I.J:=true 
          end
        end 
     end
    end 
  end
end

%Statful Transitive Closure:

proc {StateTrans GM}
    L={Array.low GM}
    H={Array.high GM}
    in
        for K in L..H do
            for I in L..H do
                if GM.I.K then
                for J in L..H do
                    if GM.K.J then GM.I.J:=true
                    end
                end
            end
        end
    end
end
%%===========================================================================================================================================================%%




%%===========================================================================================================================================================%%

% Part 3: Comparisons
% (a) Write a function that takes in two adjacency lists, and checks that they are equal (assuming
% the indices are in order).

declare
fun {IsSame Xs Ys}
    case Xs#Ys
    of nil#nil then true
    [] ((X#V1)|Xr)#((Y#V2)|Yr) 
    andthen X == Y then if {IsSame V1 V2} then {IsSame Xr Yr} 
    else false 
    end
    [] (X|Xr)#(Y|Yr) 
    andthen X == Y then {IsSame Xr Yr}
    else false 
    end
end

% (b) Write a procedure that takes a graph as input, and runs both the declarative and stateful
% algorithms, displaying the accumulated values for both algorithms, and checking to make sure
% that both algorithms return the same adjacency lists using the function from (a). Include
% Browse statements before and after each algorithm is ran, so that you can time the algorithms.

declare
proc {GraphCheck G}
   L1 L2
in
    NEdges = {NewCell 0}
    NSYreturn = {NewCell 0}
    LargestSize = {NewCell 0}
    CountEdge = {NewCell 0}
    CountGM = {NewCell 0}
    
    {Browse alg1start}
    L1 = {DeclTrans G}
    {Browse alg1finished}

    L2 = {L2M G} 
    {Browse alg2start}
    {StateTrans L2}
    {Browse alg2finished}
    
    {Browse {IsSame L1 {M2L L2}}}
   
    {Browse @NEdges}
    {Browse @NSYreturn}
    {Browse @LargestSize}
    {Browse @CountEdge}
    {Browse @CountGM}
end

% (c) Using the procedure from (b), run tests on graphs of different sparsity (from part 1 (c))
% where the input probability is varied. Also, calculate the runtime of these algorithms a
% stopwatch. Describe the results. What did you find?


/*
%  For a size of 0-500
%  The program took about 2-3 minutes.
%  I changed the size from 0-1000 to see how it would effect the time. 
%  It changed the the time to 4 minutes.
%     A1 : 11.03s
%     Algorithm 2 : 17.35s
%     Is the same : True
%     Algorithm 1 Counts : {
%        Number of Edge counts : 144842859
%        Times SY was returned : 317
%        The Largest SY size   : 600
%     }
%     Algorithm 2 Counts : {
%        Number of Edge counts : 65085114
%        Times GM was accessed : 310336966
%    }
%   
%     Using 0-1000 took much longer than the 500, not surprising.
%     A1 is faster by a little, but A2 uses less edges.
*/

%%===========================================================================================================================================================%%




%%===========================================================================================================================================================%%

% Part 4: Follow-up Questions
% (a) What can you say about the dependency of components within a stateful versus declarative
% program? Would it be trivial to make the stateful approach concurrent with threading? If so,
% how could you disentangle the components?

/*
%  Stateful must be passed a matrix as input, The final product will need to be converted to whatever form you want to receive. 
%  Declarative only relys on FoldL, and Union. Its a bad idea to make threaded statefull statements because it will cause issues
%  if the statements get out of order.
 */

% (b) Do the above algorithms work for graphs with disconnected components?

/*
%  Yes, They do work for disconnected components.
 */

% (c) Is there a lazy approach that can save work? In other words, is every computation within the
% algorithms necessary?

/*
%  Only Succ and Union can be changed to lazy functions.
 */
%%===========================================================================================================================================================%%




%%*Code from the book*%%
% 1st Declarative Transitive Closure:
fun {DeclTrans G} 
Xs={Map G fun {$ X#_} X end}
in
{Fold LXs
fun {$ InG X}
SX = {Succ X InG} in
{Map InG fun{$ Y#SY}
Y#if {Member X SY} then
{Union SY SX} else SY end
end}
end G}
end

fun {Succ X G}
case G of Y#SY|G2 then
if X==Y then SY else {Succ X G2} end
end
end

fun {Union A B}
case A#B
of nil#B then B
[] A#nil then A
[] (X|A2)#(Y|B2) then
if X==Y then X|{Union A2 B2}
elseif X<Y then X|{Union A2 B}
elseif X>Y then Y|{Union A B2}
end
end
end


Stateful Transitive Closure:
proc {StateTrans GM}
L={Array.low GM}
H={Array.high GM}
in
for K in L..H do
for I in L..H do
if GM.I.K then
for J in L..H do
if GM.K.J then GM.I.J:=true
end
end
end
end
end
end


List to Martix:
fun {L2M GL}
M={Map GL fun {$ I#_} I end}
L={FoldL M Min M.1}
H={FoldL M Max M.1}
GM={NewArray L H unit}
in
for I#Ns in GL do
GM.I:={NewArray L H false}
for J in Ns do GM.I.J:=true end end
GM
end


Matrix to List:
fun {M2L GM}
L={Array.low GM}
H={Array.high GM}
in
for I in L..H collect:C do
{C I#for J in L..H collect:D do
if GM.I.J then {D J} end
end}
end
end







%%===========================================================================================================================================================%%

% Question 6: 

declare A Temp Left Right

proc {Merge A Temp Left Right Mid}
   local I1 = {NewCell Left}
   I2 = {NewCell Mid+1} in
   for Curr in Left..Right do
		%*****1******
      if @I1 == Mid+1 then             % Left Sublist exhausted
         A.Curr := Temp.@I2
         I2:=@I2+1
      elseif @I2 > Right then          % Right sublist exhausted
         A.Curr := Temp.@I1
         I1:=@I1+1
      elseif Temp.@I1 =< Temp.@I2 then % Get smaller value
         A.Curr := Temp.@I1
         I1:=@I1+1
      else
         A.Curr := Temp.@I2
         I2:=@I2+1
      end
   end
   end
end

proc {MergeSort A Temp Left Right}
   if (Left == Right) then skip        % List has one record
   else
   local Mid = (Left + Right) div 2 in % Select midpoint
      {MergeSort A Temp Left Mid}      % MergeSort First Half
      {MergeSort A Temp Mid+1 Right}   % MergeSort Second Half
      for I in Left..Right do 	    % Copy subarray
	   Temp.I := A.I end 
      {Merge A Temp Left Right Mid}    % Merge back to A
   end
   end
end

Left = 0
Right = 9
A = {NewArray Left Right 0}
for I in Left..Right do A.I := (I mod 3) end
Temp = {NewArray Left Right 0}
{MergeSort A Temp Left Right}
for I in Left..Right do {Browse A.I} end

/*
Here is the general invariant for MergeSort: 

1.	If left <= right, then mergesort(A, temp, left, right) terminates and A[left..right] is sorted.

Here are the invariants that are true each time we get to position *1* in the Merege function
1.	Both temp[left..mid] and temp[mid+1..right] are sorted
2.	A[left..curr-1] is sorted and contains the elements of temp[left..i1-1] and temp[mid+1..i2-1]
3.	temp[i1] >= temp[mid+1..i2-1]
4.	temp[i2] >= temp[left..i1-1].

This proof is done by strong induction on n = right - left
Complete the proof be verifying the following steps:


1.	The recursive calls are on lists smaller than size n

%  (Left = Left) - (Right = Mid) < N
%  mid+1 - Right < N


2.	The invariants are true in the base case when Merge is first called

%  I1 = {Cell} Left
%  I2 = {Cell} Mid+1
%  Curr = Left..Right
%         Left < Mid <= Right
%  case 1: @I1 == Mid+1
%  case 2: @I2 > Right
%  case 3: Temp[@I1] =< Temp[@I2]
%    Get smaller value
%    val∈Temp[Left..Mid+1]
%  case 4: else

3.	The invariants are maintained in the recursive case, showing that if the invariants are true, they will be true for the next iteration of the for loop

%  Curr = Left..Right
%  at each iteration Curr := @Curr + 1
%  if Curr == Right end loop
%  because Left < Right, Curr will always reach Right and end
%  also nothing in the for <s> modifies Curr


4.	The invariants imply the MergeSort invariant upon termination, when the loop exits 

%  base: Left == Right
%  Left < Right
%  Curr starts at Left
%  Curr increments each iteration
%  when Curr == Right it is finished

*/

%%===========================================================================================================================================================%%

