%%%% CSci 117, Lab 3 %%%%
%%%Tyler Gillette%%%%

% 1. If a function body has an 'if' statement with a missing 'else' clause, then an exception
%    is raised if the 'if' condition is false. Explain why this behavior is correct. This 
%    situation does not occur for procedures. Explain why not.

/*

Functions return values and procedures do not have to return an value.

*/


% 2. Using the following:
%    (1) - if X then S1 else S2 end
%    (2) - case X of Lab(F1: X1 ... Fn: Xn) then S1 else S2 end
% (a) Define (1) in terms of the 'case' statement. 
/*

declare 
case X of true then S1
   else S2
end

*/

% (b) Define (2) in terms of the 'if' statement, using the operations
%     Label, Arity, and '.' (feature selection). 
%     Note - Don't forget to make assignment before S1. You should use ... when ranging from F1 to Fn.
/*

declare
local X in
    if {Label X} == Lab then 
       if {Arity X} == [F1...Fn] then
	  local X1...Xn in
	     X1 = X.F1
	     Xn = X.Fn
	     S1
	  else S2
	  end
       else S2
       end

*/

% (c) Rewrite the following 'case' statement using 'if' statements

declare L
L = lab(f1:5 f2:7 f3:'jim')

case L of lab(f1:X f2:Y f3:Z) then
   case L.f1 of 5 then
      {Browse Y}
   else
      {Browse a}
   end
else
   {Browse b}
end

% Program Code

declare L
L = lab(f1:5 f2:7 f3:'jim')

if {Label L} == lab then
   if {Arity L} == [f1 f2 f3] then
      local X Y Z in
	 X = L.f1
	 Y = L.f2
	 Z = L.f3
      if L.f1 == 5 then {Browse Y}
      else {Browse a} end
      end
    else {Browse b} end
else {Browse b} end 




% 3. Given the following procedure:

declare
proc {Test X} 
  case X
  of a|Z then {Browse  'case (1)'}
  [] f(a) then {Browse  'case (2)'}
  [] Y|Z andthen Y==Z then {Browse  'case (3)'} 
  [] Y|Z then {Browse  'case (4)'}
  [] f(Y) then {Browse  'case (5)'}
  else {Browse  'case (6)'} end
end

% Without executing any code, predict what will happen when you feed
% {Test [b c a]}, {Test f(b(3))}, {Test f(a)}, {Test f(a(3))}, {Test f(d)}, {Test [a b c]},
% {Test [c a b]}, {Test a|a}, and {Test  ́| ́(a b c)}
% Run the code to verify your predictions.
/*
   
I think it will be 

{Test [b c a]}       %case 4 (Correct)
{Test f(b(3))}       %case 5 (Correct)  
{Test f(a)}          %case 2 (Correct)
{Test f(a(3))}       %case 5 (Correct)
{Test f(d)}          %case 5 (Correct)
{Test [a b c]}       %case 1 (Correct)
{Test [c a b]}       %case 4 (Correct)
{Test a|a}           %case 1 (Correct)
{Test  ́| ́(a b c)}    %case 1 (this one won't run)
*/


% 4. Given the following procedure:

declare
proc {Test X}
  case X of f(a Y c) then {Browse 'case (1)'} 
  else {Browse  'case (2)'} end
end

% (a) Without executing any code, predict what will happen when you feed
% declare X Y {Test f(X b Y)}
% declare X Y {Test f(a Y d)}
% declare X Y {Test f(X Y d)}
% Run the code to verify your predictions.
/*
   
declare X Y
{Test f(X b Y)} %case 6 (Correct)

declare X Y
{Test f(a Y d)} %case 6 (Correct)

declare X Y
{Test f(X Y d)} %case 6 (Correct)

*/

% (b) Run the following example:

declare X Y
if f(X Y d)==f(a Y c) then {Browse 'case (1)'} 
else {Browse 'case (2)'} end

% Is the result different from the previous example? Explain.
% Run the code to verify your predictions. 
/*
   
It will be case 2 because the f(X Y d) does not match f(a Y c) because a is an atom and X is 
Unbound, Y is unbound and will match with Y, d does not equal c.

*/


% 5. Given the following code:

declare Max3 Max5
  proc {SpecialMax Value ?SMax}
    fun {SMax X}
      if X>Value then X else Value end
  end 
end
{SpecialMax 3 Max3} 
{SpecialMax 5 Max5}

% Without executing any code, predict what will happen when you feed
% {Browse [{Max3 4} {Max5 4}]}
% Run the code to verify your predictions.
/*

The ? Should let you pass in any function.
It looks like the max3 and max5 are testing if the value X passed in is greater than 
The number in the function name.
If the number 4 is greater than 3 then it will print 4 else 3.
If the number 4 is greater than 5 it will print 4 else 5.

So I believe it will print [4 5], because it is wrapped in a list.

    
*/





% 6. Expand the following function SMerge into the kernel syntax.
% Note - X#Y is a tuple of two arguments that can be written '#'(X Y). 
%        The resulting procedure should be tail recursive if the rules from
%        section 2.5.2 are followed correctly.

declare
fun {SMerge Xs Ys} 
  case Xs#Ys
  of nil#Ys then Ys
  [] Xs#nil then Xs
  [] (X|Xr)#(Y|Yr) then
    if X=<Y then 
      X|{SMerge Xr Ys}
    else
      Y|{SMerge Xs Yr}
    end 
  end
end

% e.g.
{Browse {SMerge [1 2 3] [1 2 3]}}

% Program Code

/*

declare SMerge
SMerge = proc {$ Xs Ys ?S}
	    case Xs of nil then S = Ys
	    else
	       case Ys of nil then S = Xs
	       else case Xs of X|Xr then
		       case Ys of Y|Yr then
			  if X=<Y then
			     local Mid in
				S = X|Mid
				{SMerge Xr Ys Mid}
			     end
			  else
			     local Mid in
				S = Y|Mid
				{SMerge Xs Yr Mid}
			     end
			  end
		       end
		    end
	       end
	    end
	 end

*/



