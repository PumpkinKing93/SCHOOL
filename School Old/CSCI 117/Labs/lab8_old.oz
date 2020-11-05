%%%% CSci 117, Lab 8 %%%%
%%%% Tyler Gillette %%%%%


% Part 1: Conceptual

% Q1 Laziness and concurrency
% This exercise looks closer at the concurrent behavior of lazy execution. Execute the following:

fun lazy {MakeX} {Browse x} {Delay 3000} 1 end
fun lazy {MakeY} {Browse y} {Delay 6000} 2 end
fun lazy {MakeZ} {Browse z} {Delay 9000} 3 end
X={MakeX}
Y={MakeY}
Z={MakeZ}
{Browse (X+Y)+Z}
  
% This displays x and y immediately, z after 6 seconds, and the result 6 after 15 seconds. 
% Explain this behavior. What happens if (X+Y)+Z is replaced by X+(Y+Z) or by thread X+Y end + Z? 

/*
The program will wait a certain amount of time before executing each step.
Because X and Y are executed together they will wait 3 seconds and 6 seconds. Since 6 seconds
is longer than 3 we will wait 6 seconds and then execute the next step which we will wait another 
9 seconds before executing. This will give us the 15 seconds before we get our answer.
if you have X+(Y+Z) then it will take 9 seconds for the (Y+Z) and then another 3 seconds to do
the X + (Y+Z) this will cost 12 seconds to execute. which is faster than the original setup.

if we did
thread
X+Y
end
+Z

then this could take anywhere from 15 seconds to 18 seconds depending on how this executes.

*/

% Which form gives the final result the quickest?

/*
X+Y+Z 
Because X+Y+Z will cost a total of 9 seconds to execute all of them.
*/

% How would you program the addition of n integers i1, ..., in, given that integer ij only 
% appears after tj milliseconds, so that the final result appears the quickest?

/*
i would do i1 +...+ in.
this would give you the quickest time regardless of what each element had to wait.
{FoldL Ls fun{$ X Y} thread X+Y end end 0}
*/



% Q2 Laziness and monolithic functions. 
% Consider the following two definitions of lazy list reversal:

fun lazy {Reverse1 S} 
  fun {Rev S R}
    case S of nil then R
    [] X|S2 then {Rev S2 X|R} end 
    end
in {Rev S nil} end 

fun lazy {Reverse2 S} 
  fun lazy {Rev S R}
    case S of nil then R
    [] X|S2 then {Rev S2 X|R} end 
  end
in {Rev S nil} end

% What is the difference in behavior between {Reverse1 [a b c]} and {Reverse2 [a b c]}? 

/* 
It took Revers2 much longer to return an answer than Reverse1.
Reverse2 has a lazy on the function call and on the nested function call. so they are constantly
waiting on eachother.

Reverse1 only has a lazy on the outer function so the inner is constantly working.

this makes the Reverse1 function much faster.
*/

% Do the two definitions calculate the same result? Do they have the same lazy behavior? Explain your answer in each case. 

/*
Yes,
they generate the same result but Reverse1 is much faster than Reverse2 becuase reverse2
has a lazy on the outer and inner function. this means that they are constantly waiting until the other requests something.

*/

% Finally, compare the execution efficiency of the two definitions. Which definition would you use in a lazy program?
% (Generate a very long list e.g. size 10000 and run both reverse fucntions on the two lists, timing with your phone)

/*
it takes reverse 1 roughly 51 seconds to do a list of 500
it takes reverse 2 roughly 52 seconds to do a list of 500

they are roughly the same amount of time to execute with Reverse1 inching out in the lead with
only one lazy on the outer of the function.
*/





% Q3 Concurrency and exceptions. CH.2 maybe
% Consider the following control abstraction that implements try–finally:

proc {TryFinally S1 S2} 
  B Y in
    try {S1} B=false catch X then B=true Y=X end 
    {S2}
    if B then raise Y end end
end

% Using the abstract machine semantics as a guide, determine the different possible results of the following program:

local U=1 V=2 in 
  {TryFinally
   proc {$} 
    thread
      {TryFinally proc {$} U=V end
                  proc {$} {Browse bing} end}
    end 
   end
   proc {$} {Browse bong} end} 
end

% How many different results are possible? 

/*
I believe there are 4 different possible outcomes.
shown below.

- proc {$} U=V end
  proc {$} {Browse bing} end
  proc {$} {Browse bong} end

- proc {$} {Browse bing} end}
  proc {$} U=V end
  proc {$} {Browse bong} end

- proc {$} {Browse bong} end
  proc {$} U=V end
  proc {$} {Browse bing} end

- proc {$} {Browse bong} end
  proc {$} {Browse bing} end
  proc {$} U=V end
*/


% How many different executions are possible?

/*
4 as listed above.
*/





% Part 2: A new way to write streams

% Q1 Programmed triggers using higher-order programming. Programmed triggers can be implemented by using higher-order programming 
% instead of concurrency and dataflow variables. The producer passes a zero-argument function F to the consumer. 
% Whenever the consumer needs an element, it calls the function. This returns a pair X#F2 where X is the next stream element 
% and F2 is a function that has the same behavior as F. 
% A key concept for this question is how to return 0 argument functions. For example, the functin that returns the value 3
% can be written as   F = fun {$} 3 end   such that {F} will return the value 3. 

% (a) write a generator for the numbers 0 1 2 3 ..., where the generator returns a pair V#F, V being the next value in the 
% stream and F being the function that returns the next V1#F1 pair. 
% exmaple with generator G1...    {G1} -> 0#G2      {G2} -> 1#G3     {G3} -> 2#G4

/*
declare
fun {Generate N}
  fun {$} N#{Generate N+1} 
  end
end


X = {Generate 0}
*/

% (b) write a function that displays the first N values from the stream in part a

/*
declare
fun {FirstValue X N}
   if (N == 0) then {X}.1|nil
   else {X}.1 | {FirstValue {X}.2 N-1}
   end
end

*/

% (c) write a function that takes the stream from a as input, and returns a stream with the numbers multiplied by some number N
%     e.g. N = 3 ... the stream would be 0 3 6 9 ...

/*
decalre
fun {MulN X N}
  fun {$} N*{X}.1#{MulN {X}.2 N} end
end
*/

% (d) write a function that takes a stream as input, and adds the number N to the front of the stream.
%  e.g. the stream 1 2 3 4 ... with N = 5 would return 5 1 2 3 4 ...

/*
declare
fun{FrontStream X N} 
  fun {$} N#{FrontStream {X}.2 {X}.1} end
end
*/

% (e) write a function that merges two streams into a single stream, where the output is the zip of the two streams
%    e.g.   S1 = 1 2 3 4 ...   S2 = a b c d ..    output = 1 a 2 b 3 c ...

/*
declare
fun {MergeStream X Y B}
   if (B)
      fun {$} {X}.1#{MergeStream {X}.2 Y false} end
   else
      fun {$} {Y}.1#{MergeStream X {Y}.2 true} end
   end
end

Z = {MergeStream X Y true}
*/





% Q2 Hamming Problem
% Convert the solution of the hamming problem for primes 2,3,5 given in the book section 4.5.6 from an implementation using 
% lazy generators, to an implementation using the generators described in part two that produce value function pairs. 
% Note that you will still be needing data flow variables.
% Hint  -> Merge will take in generators, and return a generator (function that returns a value function pair)
% Hint  -> H will be a generator, where the first call {H} will return the pair 1#(some function)

%% you will need to put together the merge and some H from the book.

/*
declare
fun lazy {Times N H}
   fun{$}
      case {H} of X#H2 then N*X#{Times N H2} end
   end
end

declare
fun lazy {Merge Xs Ys}
   fun{$}
      case {Xs}#{Ys} of (X#Xr)#(Y#Yr) then
     if X<Y then X#{Merge Xr Ys} elseif X>Y then Y#{Merge Xs Yr} else X#{Merge Xr Yr}
     end
      end
   end
end

local H C in
   thread H = fun {$} 1#{Merge {Times 2 H} {Merge {Times 3 H} {Times 5 H}}} end end
   thread C = {DisplayElements 20 H} end
   {Browse C}
end
    
   
 */




