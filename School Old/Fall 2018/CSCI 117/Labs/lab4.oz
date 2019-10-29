%%%% CSci 117, Lab 4 %%%%

%%%Tyler Gillette%%%

% 1. Section 2.4 explains how a procedure call is executed. Consider the following procedure MulByN:

declare MulByN N in 
N=3
proc {MulByN X ?Y}
    Y=N*X
end

% together with the call {MulByN A B}. Assume that the environment at the call contains {A → 10, B → x1}. When the
% procedure body is executed, the mapping N → 3 is added to the environment. Why is this a necessary step? In 
% particular, would not N → 3 already exist somewhere in the environment at the call? Would not this be enough to  
% ensure that the identifier N already maps to 3? Give an example where N does not exist in the environment at the 
% call. Then give a second example where N does exist there, but is bound to a different value than 3.

/*
--When the
--procedure body is executed, the mapping N → 3 is added to the environment. Why is this a necessary step? 
This defines N in the environment that the function is defined so when it gets pushed to the store it will have
the statement and the environment so N will always be defined.


--In particular, would not N → 3 already exist somewhere in the environment at the call?
It wouldnt matter if N was deffined before or after the declare because it creates a local variable N that is defined
in that scope.


--Give an example where N does not exist in the environment at the call.

local MulByN in
 local N in 
N=3
proc {MulByN X ?Y}
    Y=N*X
end 
{MulByn X Y}
end

The N would not be defined in this scope because the N scope stopped at the first end before the munction call.
this doesnt matter that N is not defined in the scope that the function is called because it was defined in the
environment that the function was defined in. 
The store will have {<s1><e>} so it will still have N defined.

--Then give a second example where N does exist there, but is bound to a different value than 3.

local MulByN in
 local N in 
N=3
proc {MulByN X ?Y}
    Y=N*X
end 
end

local N in
N = 99
{MulByn X Y}
end

Here N is defined in the original environment and then again in the environment where its called. 
again, it will not matter because the store has the original s1 and e defined. 

*/





% 2. This exercise examines the importance of tail recursion, in the light of the semantics given in the chapter.
% Consider the following two functions:

fun {Sum1 N}
  if N==0 then 0 else N+{Sum1 N-1} end
end

fun {Sum2 N S}
  if N==0 then S else {Sum2 N-1 N+S} end
end

% (a) Expand the two definitions into kernel syntax. It should be clear that Sum2 is tail recursive and Sum1 is not.

/*

 local Sum1 in 
Sum1 = proc{$ N ?A}
  local C in
  C = (N==0)
        if C then A = 0
            else
                local Ans in
                    local N1 in
                        N1 = N - 1
                        {Sum1 N1 Ans}
                        A = N1 + Ans
                    end
                end
            end
        end
   end
end

local Sum2 in
Sum2 = proc($ N S ?A)
    local D in
    D = (N == 0)
         if D then D = S
              else
                   local B1 in    
                     local B2 in 
                        B1 = N - 1
                        B2 = N + S
                        {Sum2 B1 B2 A}
                    end
                end
            end
        end
   end
end 

 A0 = {Sum1 3}
    A1 = {Sum1 2}, A0 = 3 + A1
    A2 = {Sum1 1}, A1 = 2 + A2, A0 = 3 + A1
    A3 = {Sum1 0}, A2 = 1 + A3, A1 = 2 + A2, A0 = 3 + A1

    {Sum2 3 0}
    {Sum2 2 3}
    {Sum2 1 5}
    {Sum2 0 6} 
 */

% (b) Execute the two calls {Sum1 3} and {Sum2 3 0} by hand, using the semantics of this chapter to follow what 
%  happens to the stack and the store. 
%  Specifically, for the first iteration through the procedure definition, show the affect of each statement on the
%  stack, environemnt, and store similar to Dr. Wilson's Piazza post @85. Iteration two and three will be similar
%  so only show the environemnt, store, and stack right before the recursive call. Then, for iteration 4 (Base Case)
%  go through each statement, and finish popping statements off of the stack from the previous procedure calls.

/*
local Sum1 in 
Sum1 = proc{$ N ?A}
  local C in
  C = (N==0)
        if C then A = 0
            else
                local Ans in
                    local N1 in
                        N1 = N - 1
                        {Sum1 N1 Ans}
                        A = N1 + Ans
                    end
                end
            end
        end
   end
end

{Sum1 3}


When first executing, the environment is saved.
environment = {S1, E}
Then the variables will be saved in the store as unbound.
N will be bound to whatever number is passed into the function.
lets say we pass 3 into N. N = 3
store = {{Sum1 N1}{N}}
the stack will be utilzed passing on 3 for the initial call.
stack = {3}
next the stack gets 2 and 5 pushed on.
stack = {3 5 2}
the 2 is used in the next call
the stack now gets 1 and 6 passed on.
stack = {3 5 2 1 6}
when it runs through the function again it will hit the base case of 0 and pop off 
the top of the stack returning 6.



local Sum2 in
Sum2 = proc($ N S ?A)
    local D in
    D = (N == 0)
         if D then D = S
              else
                   local B1 in    
                     local B2 in 
                        B1 = N - 1
                        B2 = N + S
                        {Sum2 B1 B2 A}
                    end
                end
            end
        end
   end
end 

{Sum2 3 0}


this will execute very similar to the first one {Sum1 3} because S = 0.

When first executing, the environment is saved.
environment = {(S1, E) (S2, E1)}
the variables will be saved in the store as unbound.
N and S will be bound to whatever number is passed into the function.
lets say we pass 3 into N. N = 3
and we pass 0 in for S. S = 0.
store = {{Sum1 N1 Sum2}{N S}}
the stack will be utilzed passing on 3 and 0 for the initial call.
stack = {3 0}
next the stack gets 2, 0 and 5 pushed on.
stack = {3 0 5 2}
the 2 and 0 are used in the next call
the stack now gets 1, 0 and 6 passed on.
stack = {3 0 5 2 0 1 6}
when it runs through the function again it will hit the base case of 0 and pop off 
the top of the stack returning 6.


*/

% (c) What would happen in the Mozart system if you would call {Sum1 100000000} or {Sum2 100000000 0}? Which one 
% is likely to work? Which one is not? Try both on Mozart to verify your reasoning.

/*
   The Sum2 would most likely run because the 
*/






% 3. Given the following program code:

fun {Eval E}
  if {IsNumber E} then E 
    else
    case E
    of plus(X Y) then {Eval X}+{Eval Y} 
    [] times(X Y) then {Eval X}*{Eval Y} 
    else raise illFormedExpr(E) end
    end
  end 
end

try
  {Browse {Eval plus(plus(5 5) 10)}} 
  {Browse {Eval times(6 11)}} 
  {Browse {Eval minus(7 10)}}
catch illFormedExpr(E) then
  {Browse  ́*** Illegal expression  ́#E# ́ *** ́}
end

%exmaple of catch with multiple cases on page 96 and 97

% Include the Records divide(X Y), list(L) which returns the list L, and append(H T) which takes an integer and appends it to a list
% such that the function Eval will return either an integer, a list, or an error.
% Change the catch into a pattern matching catch (Page 96) with the following exceptions
%     illFormedExpr(E)   -- same as the already existsing error
%     illFormedList(E)   -- if list(L) is evaluated and L is not a list (using a helper function IsList that you define)
%                             IsList checks if the head of the input is an integer, then recursively checks the rest of 
%                             the list. Base case is nil which returns true. 
%     illFormedAppend(E) -- if append(H T) is passed to Eval and H is not an integer (using the IsNumber function)

% Include another exception for dividing by 0, such that the exception will then execute the division, by changing the 
% denominator to 1, and output the result to the browser. This exception will not be in the pattern matching catch 
% described above, but will be on the outside (You will need a nested try, catch statement to achieve this)

% Program Code
/*
fun {isList F} 
case F of H|T then 
    if {IsNumber H} then {isList T}
        else false
    end
    []nil then true 
    else false 
    end
end


fun {Eval E}
  if {IsNumber E} then E
    else
    case E
    of plus(X Y) then {Eval X}+{Eval Y}
    [] times(X Y) then {Eval X}*{Eval Y}
    [] div(X Y) then if Y == 0 then illFormDivide(X)
                     else {Eval X} div {Eval Y}
    [] list(L) then {isList L}
    [] append(H T) then
        if {IsNumber H} then H|T
        else raise illFormedAppend(E) end
    else raise illFormedExpr(E) end
    end
  end
end

try
  {Browse {Eval plus(plus(5 5) 10)}}
  {Browse {Eval times(6 11)}}
  {Browse {Eval minus(7 10)}}
catch illFormedExpr(E) then 
  {Browse  '*** Illegal expression  '#E#'  ***'}
  [] illFormedAppend(E) then
  {Browse  '*** Illegal expression  '#E#' ***'}
  [] illFormedList(E) then
  {Browse  '*** Illegal expression  '#E#' ***'}
  [] illFormDivide(X) then
  {Browse  '*** Illegal expression  '#X#' ***'}
end

*/


% Describe the process, in terms of the stack, from the moment a division by 0 exception is raised, 
% to the moment the division 
% division is executed with a new denominator. (Ignore Environment and Store)

/*
    it will go through and execute the function it will try the catch statements if it fails on them,
    they will be skipped and the exception will be thrown.

1.

    Stack:  [ (s1, E), (s2, E), (s3, E), (s4, E) ]
    E = {Sum1 -> sum1, N -> n}
    Store: {{sum1,o}}
2.  
    Store: {sum1 = s = proc{$ N ?A}S1.1 end, {})

    
    (proc{$ N ?A}S1.1 end, {}). 

    Stack: Contains S3 and s4, S1 is popped off.
3.
    We have I = 3, bind (E[i], three)
    Store: {n = three = 3}
    Stack: S4 
4.
    E' = CE + {N -> i},{}
        Stack: S1.1 

5.
    E'' = E' + {C->c}
    Store' = Store + {c}

6.     
    Stack = if and assignment statement
    {C = bool = False}

7.  
    E'' Stack pops off the assignment
8. 
    E''' = E'' + {Ans -> ans, N1 -> n1}
        Store + {{ans},{n1}}
9. 
    Stack
    Store is then updated
    {n1 = N }
10. 
    E''' and the stack 

    Store: O 

*/







% 4. Based on the unification algoirthm on page 103, describe the unification process for the following example
%    Describe the Stack, Environment, and Store as each statement is executed, similar to Q2(b), and show the output store
%    Remark: Describe each step in the unification when it occurs, using the syntax unify(X,Y), bind(ESx,ESy), etc.
%            as shown on page 103



declare X Y A B C D E F G H I J K L M N
L = D
M = D
N = F
A = birthday(day:3 month:C year:1986)
B = birthday(day:D month:D year:F)
I = J
J = 19
K = D
X = person(age:I name:"Stan" birthday:A)
Y = person(age:G name:H birthday:B)
X = Y

/*
1. The first thing that is done, is to stoer the environment.
   environment = {X->x, Y->y, A->a, B->b, C->c, D->d, E->e, F->f, G->g, H->h, 
   I->i, J->j, K->k, L->l, M->m, N->n}

2. when first call it will store  the variables  X Y A B C D E F G H I J K L M N in the store.  
   store = {{x}, {y}, {a}, {b}, {c}, {d}, {e}, {f}, {g}, {h}, {i}, {j}, {k}, {l}, {m}, {n}}

3. next it will bind L D
store = {{x}, {y}, {a}, {b}, {c}, {e}, {f}, {g}, {h}, {i}, {j}, {k}, {l, d}, {m}, {n}}

4. next it will bind M and D.
   store = {{x}, {y}, {a}, {b}, {c}, {e}, {f}, {g}, {h}, {i}, {j}, {k}, {l, d, m}, {n}}

5. next it will bind N and F.
   store = {{x}, {y}, {a}, {b}, {c}, {e}, {g}, {h}, {i}, {j}, {k}, {l, d, m}, {n, f}}

6. next it will bind The values to A.
   store = {{x}, {y}, {a = x1 = birthday(day:three, month:c, year:year)}, {three = 3}, {year = 1986}, {b}, {c}, {e}, 
   {g}, {h}, {i}, {j}, {k}, {l, d, m}, {n, f}}

7. next it will bind B to the label.
   store = {{x}, {y}, {a = x1 = birthday(day:three, month:c, year:year)}, {three = 3}, {year = 1986}, {b}, {e}, 
   {g}, {h}, {i}, {j}, {k}, {d = 3}, {l, d, m, c}, {f = 1986}, {n, f}, {b = x2 = birthday(day:d, month:d, year:f)}}

8. next we will bind I to J.
   store = {{x}, {y}, {a = x1 = birthday(day:three, month:c, year:year)}, {three = 3}, {year = 1986}, {b}, {e}, 
   {g}, {h}, {i, j}, {k}, {d = 3}, {l, d, m, c}, {f = 1986}, {n, f}, {b = x2 = birthday(day:d, month:d, year:f)}}

9. now we will bind J to 19.
   store = {{x}, {y}, {a = x1 = birthday(day:three, month:c, year:year)}, {three = 3}, {year = 1986}, {b}, {e}, 
   {g}, {h}, {j = 19}, {i, j}, {k}, {d = 3}, {l, d, m, c}, {f = 1986}, {n, f}, 
   {b = x2 = birthday(day:d, month:d, year:f)}}

10. now we will bind K to D
    store = {{x}, {y}, {a = x1 = birthday(day:three, month:c, year:year)}, {three = 3}, {year = 1986}, {b}, {e}, 
    {g}, {h}, {j = 19}, {i, j}, {d = 3}, {l, d, m, c, k}, {f = 1986}, {n, f}, 
    {b = x2 = birthday(day:d, month:d, year:f)}}

11. now we will bind x to person
    store = {{x = x3 = person(age:i name:"Stan" birthday:a)}, {y}, 
    {a = x1 = birthday(day:three, month:c, year:year)}, {three = 3}, {year = 1986}, {b}, {e}, 
    {g}, {h}, {j = 19}, {i, j}, {d = 3}, {l, d, m, c, k}, {f = 1986}, {n, f}, 
    {b = x2 = birthday(day:d, month:d, year:f)}}

12. now we will bind y to person
    store = {{x = x3 = person(age:i name:"Stan" birthday:a)}, {y = x4 = person(age:g , name:h, birthday:b )}, 
    {a = x1 = birthday(day:three, month:c, year:year)}, {three = 3}, {year = 1986}, {a, b}, {e}, 
    {h = "Stan"}, {j = 19}, {i, j, g}, {d = 3}, {l, d, m, c, k}, {f = 1986}, {n, f}, 
    {b = x2 = birthday(day:d, month:d, year:f)}}

13. now we bind x to y
    store = {{x, y}, {x = x3 = person(age:i name:"Stan" birthday:a)}, {y = x4 = person(age:g , name:h, birthday:b )}, 
    {a = x1 = birthday(day:three, month:c, year:year)}, {three = 3}, {year = 1986}, {a, b}, {e}, 
    {h = "Stan"}, {j = 19}, {i, j, g}, {d = 3}, {l, d, m, c, k}, {f = 1986}, {n, f}, 
    {b = x2 = birthday(day:d, month:d, year:f)}}

14. DONE!    
*/

