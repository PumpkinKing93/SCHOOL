%%%% CSci 117, Lab 7 %%%%
%%%% Tyler Gillette %%%%

% Answer written questions within block comments, i.e. /* */
% Answer program related questions with executable code (executable from within the Mozart UI) 

% Note: While many of these questions are based on questions from the book, there are some
% differences; namely, extensions and clarifications. 


% Part 1: Conceptual

% Q1 Thread semantics. 
% Consider the following variation of the statement used in Section 4.1.3 to illustrate thread semantics:

local B in           
  thread         % S1
    B=true       % T1
  end
  thread         % S2
    B=false      % T2
  end
  if B then      % S3
    {Browse yes} % S3.1
  end
end

% For this exercise, do the following:
%  (a) Enumerate all possible executions of this statement.
%  (b) Some of these executions cause the program to terminate abnormally. 
%      Make a small change to the program to avoid these abnormal terminations.

%% How many possibilities for a?
% Total = 5 

/* a
% 1 - [S1, T1, S2, T2]
% 2 - [S1, T1, S2, S3, S3.1]
% 3 - [S1, T1, S3, S3.1]
% 4 - [S1, S2, T1, S3, S3.1]
% 5 - [S1, S2, T1, T2]
% 6 - [S1, S2, T2, S3]
% 7 - [S1, S2, T2, T1]
% 8 - [S1, S2, T1, S3, T2]
*/

/* b - Change
local B in           
  thread         % S1
  {Browse abc}
    B=true       % T1
  end
  if B then      % S3
    {Browse yes} % S3.1
  end
end

Abnormal Cases:
% 1 - [S1, T1, S2, T2]
% 3 - [S1, T1, S3, S3.1]
% 5 - [S1, S2, T1, T2]
% 6 - [S1, S2, T2, S3]
% 7 - [S1, S2, T2, T1]

If you get rid of one of the threads then it fixes the issue.
*/

% Q2 Concurrent Fibonacci. 
% Consider the following sequential definition of the Fibonacci function:

fun {Fib X}
  if X=<2 then 1 
  else
    {Fib X-1}+{Fib X-2}
  end 
end


% and compare it with the concurrent definition given in Section 4.2.3. 
% Run both on the Mozart system and compare their performance. How much faster is the sequential definition? 
%    Use the following inputs - 3,5,10,15,20,25,26,27,28
%    (Give your inputs, run time, and thread count in your experimentation)   
%    Note - Page 255 describes how to use the Oz Panel to view the number of threads created!
% How many threads are created by the concurrent call {Fib N} as a function of N?

/*
declare
fun {Fib X}
if X=<2 then 1 
else
{Fib X-1}+{Fib X-2}
end 
end
{Browse {Fib 28}}
 

%{Fib 3} : 9 threads in 0.00 sec 
%{Fib 5} : 9 threads in 0.00 sec
%{Fib 10} : 9 threads in 0.00 sec
%{Fib 15} : 9 threads in 0.00 sec
%{Fib 20} : 9 threads in 0.01 sec
%{Fib 25} : 9 threads in 0.04 sec
%{Fib 26} : 9 threads in 0.06 sec
%{Fib 27} : 9 threads in 0.07 sec
%{Fib 28} : 9 threads in 0.09 sec
----------------------------------------------------------------
% Book 4.2.3
declare
fun {Fib X}
if X=<2 then 1
else thread {Fib X-1} end + {Fib X-2} end
end
{Browse {Fib 28}}
 

%{Fib 3} : 12 threads in 0.00 sec 
%{Fib 5} : 15 threads in 0.01 sec
%{Fib 10} : 65 threads in 0.01 sec
%{Fib 15} : 618 threads in 0.01 sec
%{Fib 20} : 6773 threads in 0.04 sec
%{Fib 25} : 75033 threads in 0.15 sec
%{Fib 26} : 121402 threads in 0.23 sec
%{Fib 27} : 196427 threads in 0.34 sec
%{Fib 28} : 317820 threads in 0.53 sec



----------------------------------------------------------------
The number of threads created are relative to the number passed in to the function for the second one.
The first function that is not threade will always only create one thread.

*/




% Q3 Order-determining concurrency. 
% Explain what happens when executing the following:

declare A B C D in 
thread D=C+1 end 
thread C=B+1 end 
thread A=1 end 
thread B=A+1 end 
{Browse D}

% In what order are the threads created? 
/*
 the threads will be created in the same order as the function below.
 A=1
 B=A+1
 C=B+1
 D=C+1
*/
% In what order are the additions done? 
/*
The additions can only be done in one order.
A=1
B=A+1
C=B+1
D=C+1
*/
% What is the final result? 
/*
The result will always be 4 based on threads and execution.
*/
% Compare with the following:

declare A B C D in 
A=1
B=A+1
C=B+1
D=C+1
{Browse D}

% Here there is only one thread. In what order are the additions done? What is the final result? 
% What do you conclude?

/*
The additions are done one at a time from top to bottom.
The final result should be 4.


Both of the threaded and non threaded executions will always terminate to 4 becuase they are 
executed the same exact way by each. 
The threaded one will pause until the value it needs is defined. 
This forces it to terminate the same way as the non threaded version.
*/




% Q4 Thread Effeciency.
% Take the nested flatten question from lab 5 (which is a non-iterative function)

fun {Flatten Xs}
  proc {FlattenD Xs ?Ds}
    case Xs
    of nil then Y in Ds=Y#Y
    [] X|Xr andthen {IsList X} then Y1 Y2 Y4 in
      Ds=Y1#Y4 
      {FlattenD X Y1#Y2}   % ***************** A *********************
      {FlattenD Xr Y2#Y4}
    [] X|Xr then Y1 Y2 in
      Ds=(X|Y1)#Y2 
      {FlattenD Xr Y1#Y2}
    end 
  end Ys
  in {FlattenD Xs Ys#nil} Ys
end

% If we replace statement A with 
% thread {FlattenD X Y1#Y2} end
% what will happen to the stack size as the program executes?
% Would you consider this function iterative?
% Do you think threading will make this function more effecient?





% Part 2: Streams 

% Q1 Producers, Filters, and Consumers

fun {Generate N Limit} 
  if N<Limit then
    N|{Generate N+1 Limit} 
  else nil 
  end
end

% (a) Using the above generator on a list from [0 1 2 ... 100] and threading, write functions that 
%        filter out all odd numbers
%        filter out all multiples of 4 
%        filter out all numbers greater than 7 and less than 77
%%     [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25
%%     26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48
%%     49 50 51 52 53 54 55 56 57 58 59 60 62 63 64 65 66 67 68 69 70 71 72
%%     73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
%%     96 97 98 99 100]

/*


declare 
fun {NotOdd X}
   (X mod 2) == 0
end

declare
fun {NotMultFour X}
   if X == 0 then true
   else (X mod 4) \= 0
   end
end

declare
fun {BetweenNumber X}
   {Or (X < 7) (X > 77)}
end 

% (a') Place the generator, three filters, and reader all in separate threads (where the reader simply displays elements
%      one at a time)
%      The stream will look like the following:
%      [Generator]->[remove odds]->[remove multiples of 4]->[remove numbers (7...77)]->[Display element]

fun {Generate N Limit} 
  if N<Limit then
    {Delay 100}
    N|{Generate N+1 Limit} 
  else nil 
  end
end

local Xs Ys Zs S in
   thread Xs = {Generate 0 150000} end
   thread Ys = {Filter Xs NotOdd} end
   thread Zs = {Filter Ys NotMultFour} end
   thread S  = {Filter Zs BetweenNumber} end
   {Browse S}
end
 */


% (a') Place the generator, three filters, and reader all in separate threads (where the reader simply displays elements
%      one at a time)
%      The stream will look like the following:
%      [Generator]->[remove odds]->[remove multiples of 4]->[remove numbers (7...77)]->[Display element]
/*
The threads depend on each other, in this case the B starts A when bounded and C is starts when B is bounded and D is awaken when C is bounded. 
The flow of the would run such as ABCD ABCD ABCD from 0 to 100, there was a gap from 6 to 78 there was a delay of 100.
 */

fun {Generate N Limit} 
  if N<Limit then
    {Delay 100}
    N|{Generate N+1 Limit} 
  else nil 
  end
end
% Use the above generator so there is a pause between elements being created
% Describe the flow of the first 9 elements as they move through the chain. What threads are awakened, and when?

/*

declare 
fun {NotOdd X}
   (X mod 2) == 0
end

declare
fun {NotMultFour X}
   if X == 0 then true
   else (X mod 4) \= 0
   end
end

declare
fun {BetweenNumber X}
   {Or (X < 7) (X > 77)}
end 

% (a') Place the generator, three filters, and reader all in separate threads (where the reader simply displays elements
%      one at a time)
%      The stream will look like the following:
%      [Generator]->[remove odds]->[remove multiples of 4]->[remove numbers (7...77)]->[Display element]

fun {Generate N Limit} 
  if N<Limit then
    {Delay 100}
    N|{Generate N+1 Limit} 
  else nil 
  end
end

local Xs Ys Zs S in
   thread Xs = {Generate 0 150000} end
   thread Ys = {Filter Xs NotOdd} end
   thread Zs = {Filter Ys NotMultFour} end
   thread S  = {Filter Zs BetweenNumber} end
   {Browse S}
end
 */





% (b) Using the above generator on a list from [0 1 2 ... 100] and threading, write consumers that  
%        return the list of sums of every pair of consecutive integers, i.e. [0+1 2+3 4+5 ...] = [1 5 9 ...]
%        return the sum of all odd numbers (you will need a filter and fold operation)






% Q2 Prime number filter
% Using the above generator on a list from [0 1 2 ... 1000] filter out all prime numbers
% The filter works as follows:
%     Maintain a list of primes, with the inital singleton list [2]
%     At each value n, check if n is divisible by any of the primes in your list
%     from [2 .. m] (where m^2 < n)
%      - if n is divisible by at least one of these primes, keep it in the stream
%      - otherwise, n is prime, so it will be added to the list of primes, and removed from the stream

/*
declare
fun {Prime Xs M}
   case Xs
   of nil then nil
   [] X|Xr then Ys in
      if X=<M then
     thread Ys={Filter Xr fun {$ Y} Y mod X = 0 end} end
      else Ys=Xr end
      X|{Prime Ys M}
   end
end

{Browse {Prime ({Generate 2 100}) 100}}
 */



% Q3 Digital logic simulation. 
/*
In this exercise we will design a circuit to add n-bit numbers and simulate it using the technique of Section 4.3.5. Given two n-bit binary numbers, 
(xn−1...x0)2 and (yn−1...y0)2. 
We will build a circuit to add these numbers by using a chain of full adders, similar to doing long addition by hand. 
The idea is to add each pair of bits separately, passing the carry to the next pair. We start with the low-order bits x0 and y0. Feed them to a full adder with the third input z = 0. 
This gives a sum bit s0 and a carry c0. Now feed x1, y1, and c0 to a second full adder. This gives a new sum s1 and carry c1. Continue this for all n bits. The final sum is (sn−1...s0)2. 
For this exercise, program the addition circuit using full adders. Verify that it works correctly by feeding it several additions.
*/
% GateMaker, FullAdder, and all the accompanying binary operatins can be found on pages 273,274 as well as a diagram of the full adder
% You will need to update your FullAdder procedure, because your carry values are determined after each step in the adder
% Remark - since you have an initial value of Z, namely 0, you would like your Z to look like [ _ _ _ _ ... 0] where the first few
%          elements are filled in as you proceed in the algoirthm, however, the natural way to write Z would be to declare an unbound
%          variable Zf and have Z = 0|Zf. The trick here is appropriate using reverse!

/*

declare
local
   fun {NotLoop Xs}
      case Xs of X|Xr then (1-X)|{NotLoop Xr} end
   end
in
   fun {NotG Xs}
      thread {NotLoop Xs} end
   end
end
fun {GateMaker F}
   fun{$ Xs Ys}
      fun {FLoop Xs Ys}
	 case Xs#Ys of (X|Xr)#(Y|Yr) then {F X Y}|{FLoop Xr Yr} end
      end
   in
      thread {FLoop Xs Ys} end
   end
end
AndG={GateMaker fun {$ X Y} X*Y end}
OrG ={GateMaker fun{$ X Y} X+Y-X*Y end}
XOrG ={GateMaker fun{$ X Y} X+Y-2*X*Y end}


proc {FullAdder X Y Z ?C ?S}
   K L M
in
   K={AndG X Y}
   L={AndG Y Z}
   M={AndG Z X}
   C={OrG {OrG K L} M}
   S={XOrG {XOrG X Y} Z}
end


Z0=0|0|0|_
X0=1|1|0|_ Y0=0|1|0|_ C0 S0
X1=0|0|1|_ Y1=1|1|1|_ C1 S1
X2=0|0|0|_ Y2=0|0|0|_ C2 S2
in
{FullAdder X0 Y0 Z0 C0 S0}
{FullAdder X1 Y1 C0 C1 S1}
{FullAdder X2 Y2 C1 C2 S2}

{Browse input}
{Browse X0#Y0}
{Browse X1#Y1}
{Browse X2#Y2}
{Browse output}
{Browse S0}
{Browse S1}
{Browse S0}
{Browse {FullAdder X0 Y0 Z0 C0 S0}}
 */




