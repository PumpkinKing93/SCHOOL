declare
fun {Fact R}
   if R == 0 then 1
   else R*{Fact R-1}
   end
end

   
fun {Helper N X}
   if X == 0 then 1
     else N*{Helper (N-1) (X-1)}
      end
end


fun {Den R}
   if R == 0 then  1
      else R * {Den R - 1}
   end
end


fun {Answer N R}
   {Num N R} div {Fact R}
end

fun {Combine N R}
   if R == 0 then 1
   else {Helper N (N-(N-R+1))} div {Fact R}
      end
   
fun {Num N R}
   {Helper N (N - (N - R + 1))}
   end



{Browse {Answer 10 2}}
{Browse {Combine 10 2}}


% Base Case check
declare
fun {Fact N}
   if N==0 then 1 else N*{Fact N-1} end end

fun {Comb N R}
   {Fact N} div ({Fact R}*{Fact N-R}) end

{Browse {Comb 10 2}}

/*
􏰁 n choose r = n×(n−1)×···×(n−r+1) r = r × (r − 1) × · · · × 1

*/


/*
declare Pascal AddList ShiftLeft ShiftRight
fun {Pascal N}
   if N==1 then [1]
   else
      {AddList {ShiftLeft {Pascal N-1}} {ShiftRight {Pascal N-1}}}
   end
end*/



local X in
   X=23
   local X in
      X=44
   end
   {Browse X}
end


local X in
X={NewCell 23}
X:=44
{Browse @X}
end


Op = multiplication

declare Oplist
fun {GenericPascal Op N}
   if N==1 then [1]
   else L in
      L={GenericPascal Op N-1}
      {OpList Op {ShiftLeft L} {ShiftRight L}}
   end
end

fun {OpList Op L1 L2}
   case L1 of H1|T1 then
      case L2 of H2|T2 then
	 {Op H1 H2}|{OpList Op T1 T2}
      end

      fun {ShiftLeft L}
	 case L of H|T then
	    H|{ShiftLeft T}
	 else [0] end end

      fun {ShiftRight L} 0|L end


declare 
fun {Dec H}
   if H == 0 then H|0
   else [H-1|Symmlist H T]
   end
end
{Browse {Symmlist 10 10}}

%10 9 8 7...
declare
fun lazy {Dec P}
   if P==0 then 1
      else [P|{Dec P-1}]
   end
   {Browse {Dec 5}}

%0 1 2 3 4...
fun lazy {Inc M}
   M|{Inc M+1}
end

fun lazy {Crazylazylist M}
   if P==0 then M|{Inc P}
      else 
      {Browse {Dec 10}}



declare
fun lazy {Geez N C}
   if N==0 then N|{Geez N+1 1}
   else N|{Geez N-1 0}
   end
end

local L in
   L = {Geez 5 0} 
   case L of
      A|B|C|D|E|F|G|HI|J|K|_ then {Browse A|B|C|D|E|F|G|HI|J|K}
   end
end

declare
fun lazy {G2 N C}
   if N==1 then N|{G2 N+1 1}
      elseif C==0 then N|{G2 N-1 0}
   else N|{G2 N+1 1}
   end
   end

local L in
   L = {G2 1 0} 
   case L of
      A|B|C|D|E|F|G|HI|J|K|_ then {Browse A|B|C|D|E|F|G|HI|J|K}
   end
end

declare
L = {Geez 10}
{Browse L}



{Browse 5}

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

{Browse {Answer 10 2}}



declare

fun {Helper N X}
   if X == 0 then 1
     else N*{Helper N-1 X-1}
      end
   end

fun {Num N R}
   {Helper N (N - (N - R + 1))}
   end

fun {Den R}
   if R == 0 then  1
      else R * {Den R - 1}
   end
end


fun {Answer N R}
   {Num N R} div {Den N R}
end

{Browse {Answer 10 0}}

%% (b) use the identity   n choose r = n choose (n-r) to further increase efficiency 
%% So, if r > n/2 then do the calculation with n-r instead of r

/*
10 choose 2 = 10 choose (10-2)
If 2 > 10/2 then n-r
*/


declare Pascal AddList ShiftLeft ShiftRight 
fun {Pascal N}
    if N==1 then [1] 
    else
        {AddList {ShiftLeft {Pascal N-1}} {ShiftRight {Pascal N-1}}}
    end 
end



declare
L={List 5 5}


local
   proc{Show N List}
      if N\=0 then
     case List of H|T then {Browse H} {Show (N-1) T} end    
      end
   end
in {Show 9 L}
end



declare
fun lazy {G2 N C}
   if N==1 then N|{G2 N+1 1}
      elseif C==0 then N|{G2 N-1 0}
   else N|{G2 N+1 1}
   end
end

L = {G2 5 5}

local
   proc{Show N G2}
      if N == 0 then
	 case G2 of H|T then {Browse H} {Show (N-1) T}
	 end
      end
   end
in {Show 9 L}
end


{Browse {Show 5}}




local L in
   proc {Show N L}    
L={G2 10 0}
   if N > 0 then
      case L of H|({Show N-1} {G2 10 0}) then {Browse H} {Browse {Show N-1}}
   end
   end
   end







   
{Browse {Show 5}}
      
   
{Show 5}
{Browse {Show 10}}

   

      
   case L of
      A|B|C|D|E|F|G|HI|J|K|_ then {Browse A|B|C|D|E|F|G|HI|J|K}
   end
end



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

{Browse {Answerb 10 2}} %=45
{Browse {Answerb 10 0}} %=1

{Browse {Answerb 10 6}} %=45



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

1A*
1B*
2A
3*
4
5*
6*
7*

declare
fun {GenericPascal Op N}
   if N==1 then [1]
   else L in
      L={GenericPascal Op N-1}
      {OpList Op {ShiftLeft L} {ShiftRight L}}
   end
end


fun {OpList Op L1 L2}
   case L1 of H1|T1 then
      case L2 of H2|T2 then
	 {Op H1 H2}|{OpList Op T1 T2}
      end
   else nil
   end
end

fun {ShiftLeft L}
   case L of H|T then H|{ShiftLeft T}
   else [0]
   end
end
      
      fun {ShiftRight L} 0|L end

  
fun {Mul X Y}
    X * Y
      end
      
 fun {Sub X Y}
	 X - Y
 end
 
fun {Add X Y}
	 X + Y
end

 fun {Xor X Y}
    if X==Y then 0
    else 1
    end
 end

 fun {Adjmult X Y}
    (X+1) *(Y+1)
 end

  fun {Mine X Y}
    (X-1) *(Y+1)
  end
  
%fun {Show I}
 for I in 1..10 do {Browse {GenericPascal Mine I}}
 end

 
