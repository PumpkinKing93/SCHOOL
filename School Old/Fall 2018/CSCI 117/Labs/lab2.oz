%%%% CSci 117, Lab 2 %%%%
%%%%Tyler Gillette %%%%

% Answer written questions within block comments, i.e. /* */
% Answer program related questions with executable code (executable from within the Mozart UI) 

% Note: While many of these questions are based on questions from the book, there are some
% differences; namely, extensions and clarifications. 




% 1. Write a more efficient version of the function Comb from section 1.3
%% (a) use the definition   n choose r = n x (n-1) x ... x (n-r+1) / r x (r-1) x ... x 1
%% calculate the numerator and denominator separately, then divide the results
%% note: the solution is 1 when r = 0

% /*
declare

fun {Helper N X}
   if X == 0 then 1
     else N*{Helper N-1 X-1}
      end
   end


fun {Den R}
   if R == 0 then  1
      else R * {Den  R - 1}
   end
end

fun {Answer N R}
   if R == 1 then 1
   else {Helper N ( N - (N- R))} div {Den R}
   end
end

{Browse {Answer 10 2}} %=45
{Browse {Answer 10 0}} %=1
*/


%% (b) use the identity   n choose r = n choose (n-r) to further increase efficiency 
%% So, if r > n/2 then do the calculation with n-r instead of r

% P
/*
declare

fun {Helper N X}
   if X == 0 then 1
     else N*{Helper N-1 X-1}
      end
   end


fun {Den R}
   if R == 0 then  1
      else R * {Den  R - 1}
   end
end

fun {Answer N R}
   if R == 1 then 1
   else {Helper N ( N - (N- R))} div {Den R}
   end
end

%Answer 1B

fun {Answerb N R}
   if R > ( N div 2) then {Answer N (N-R)}
   else {Answer N R}
   end
end
*/








% 2. Based on the example of a correctness proof from section 1.6, write a correctness
% proof for the function Pascal from section 1.5. 

% Example correctness proof for Fact from section 1.6
/* 
  Proof of correctness for Fact N by induction on N:
    Base case (N = 0), {Fact 0} returns the correct answer, namely 1

    Inductive Hypothesis: {Fact K-1} is correct
    Inductive case (N=K): the 'if' instruction takes the 'else' case, and calculates
      K*{Fact K-1}. By the IH, {Fact K-1} is correct. Therefore, {Fact N} also returns 
      the correct solution.
*/
 
%% (a) Write the correctness proof for the function Pascal from section 1.5, assuming 
%% both the ShiftLeft and ShiftRight functions are correct.

/*
 Proof of correctness for Pascal N by induction on N:

   Base Case: 
	(N = 1), {Pascal 1} Returns the correct list of numbers.
   
   Inductive Hypothesis:
	Assuming ShiftLeft {Pascal N-1} and {ShiftRight {Pascal N-1}} is correct then we can show that AddList L1 L2 will 
Take the head of each list and append them to a new list and continue until L1 and L2 are empty. Based on the Inductive hypothesis when L1 >0 and L2 >0 Pascal will return the correct list.

   Inductive case (N=K):
The 'if' instruction checks to make sure that N is not equal to 1, the else case takes the Addlist which takes the ShiftLeft and ShiftRight functions which by the IH we know are true. The 'else' returns the heads of the two lists and appends them to 
A new list, and recursively calls on the tails of each lists until they are empty.
So we know that when N=K as long as N or K is greater than 0 they will return the correct list.


declare Pascal AddList ShiftLeft ShiftRight fun {Pascal N}
if N==1 then [1] else
{AddList {ShiftLeft {Pascal N-1}} {ShiftRight {Pascal N-1}}}
end end

fun {ShiftLeft L} case L of H|T then H|{ShiftLeft T}
else [0] end end
fun {ShiftRight L} 0|L end

	fun {AddList L1 L2} case L1 of H1|T1 then
case L2 of H2|T2 then H1+H2|{AddList T1 T2}
end
else nil end
end

*/







% 3. Write a lazy function (section 1.8) that generates the list 
%        N | N-1 | N-2 | ... | 1 | 2 | 3 | ...    where N is a positive number
% Hint: you cannot do this with only one argument

% Program code
/*
declare
fun lazy {G2 N C}
   if N==1 then N|{G2 N+1 1}
      elseif C==0 then N|{G2 N-1 0}
   else N|{G2 N+1 1}
   end
   end

*/





% 4. Write a procedure (proc) that displays ({Browse}) the first N elements of a List
% and run this procedure on the list created in Q3

% Program Code

/*
L = {G2 5 0}

local
   proc{Show N G2}
      if N \= 0 then
	 case G2 of H|T then ({Browse H} {Show (N-1) T})
	 end
      end
   end
in {Show 9 L}
end


*/









% 5. Using the function Pascal from section 1.9, explore the possibilities of higher-order
% programming by using the following functions as input: multiplication, subtraction, XOR,
% adjusted multiplication: Adjmult X Y = (X+1)*(Y+1), and an operation of your own.
% Display the first 5 rows using   for I in 1..10 do {Browse {GenericPascal Op I}} end
% where Op is the operation you have defined, e.g. multiplication.

% Program Code (for your own operation)

fun {Mine X Y}
    (X-1) * (Y+1)
  end

/*
    Describe the Browser output for the 5 operations, and give some insight as to why they
    outputed the values they did.

*Multiplication displays the tree starting with 1 and then the following rows are all 0 because it gets multiplied by the outer tree.

*Subtraction displays a tree with negative numbers. It displays the same numbers as the normal pascal, except they are negatives.

*XOR displays a tree with 
[1]
[11]
[101]
[1111]
[10001]
[110011]
[1010101]
[11111111]

This basically chooses every other one and makes it a 1.


*Adjmult displays a tree that grows at a fast rate. Because the two values are added together and then multiplied together, They grow quickly.I actually did not expect that.

*Mine: 
fun {Mine X Y}
    (X-1) *(Y+1)
  end
Displays a tree with both negative and positive numbers, the largest number I got was 3 and the smallest was -24. The tree is not symmetrical.

*/








% 6. local X in 				local X in
%       X=23						  X={NewCell 23}
%       local X in 				  X:=44
%          X=44					  {Browse @X}
%       end						end
%        {Browse X}				
%       end
% What does Browse display in each fragment? Explain.

/*
    local X in
   X=23
   local X in
      X=44
   end
   {Browse X}
end

- The code listed above outputs a 23 in the Browser, the 
Reason that it displays the 23 instead of the 44 is because of 
Of the scope. The 23 is set first and the 44 is set second in the
Same scope. This is a single define variable. So X is bound to 23.



local X in
X={NewCell 23}
X:=44
{Browse @X}
end

- The code listed above outputs a 44 in the Browser, The reason 
That 44 is displayed and not the 23 is because its set in a bound 
Cell, and cells allow changes to the variables in the store.


*/








% 7. Define functions {Accumulate N} and {Unaccumulate N} such that the output of 
% {Browse {Accumulate 5}} {Browse {Accumulate 100}} {Browse {Unaccumulate 45}}
% is 5, 105, and 60. This will be implemeted using memory cells (section 1.12).

% Program Code 

declare
C={NewCell 0}
fun {Accumulate N}
   C:=@C+N
end

fun {Unaccumulate N}
   C:=@C-N
end

{Browse {Accumulate 5}}
{Browse {Unaccumulate 5}}
{Browse @C}
% Program Code 















