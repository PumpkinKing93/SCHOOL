%%%% CSci 117 Lab 13 %%%%
 %%%% Tyler Gillette %%%%

%%=========================================================================================================%%
%%=========================================================================================================%%
%%=========================================================================================================%%

declare 
fun {MapColor Verts Colors Edges}

   case Verts of nil then Colors 
   [] V|Vt then
      {Assign Verts Colors}
      true = {Check V Colors Edges}
      {MapColor Vt Colors Edges}
   end
end

proc {Assign Verts Colors}
   choice Colors.V = Red
   [] Colors.V = Blue
   [] Colors.V = Yellow
   end
end

fun {Check V Edges Colors}
   Return = {NewCell true}
in
   for A#B in Edges do
      if {IsDet Colors.B} then
     if Colors.A = Colors.B then
        skip
     else
        Return := False 
     end
      end
   end
   @Return
end

%%=========================================================================================================%%
%%=========================================================================================================%%
%%=========================================================================================================%%


% Missionaries starts here

proc {Cross ML#MR CL#CR B AL}
   case (ML#CL) of (0#0) then AL = nil
   [] CL > ML andthen ML /= 0 then fail
   [] CR > MR andthen MR /= 0 then fail
   else
      choice

     /*
 % 1 missionary

     if (B == 0) then
        ML > 0 = true
        local
           MLn = ML - 1
           MRn = MR + 1
           AL = a(0 1 0)|T
           {Cross MLn#MRn CL#CR 1 T}
        end
     else
        MR > 0 = true
        local
           MLn = ML + 1
           MRn = MR - 1
           AL = a(1 1 0)|T
           {Cross MLn#MRn CL#CR 0 T}
        end
     end
     */


%1 cannibal

     if (B == 0) then
        CL > 0 = true
        local
           CLn = CL - 1
           CRn = RR + 1
           AL =a(0 0 1)|T
           {Cross ML#MR CLn#CRn 1 T}
        end
     else
        CR > 0 = true
        local
           CLn = CL + 1
           CRn = CR - 1
           AL = a(1 0 1)|T
           {Cross ML#MR CLn#CRn 0 T}
        end
     end


% 2 missionary

     if (B == 0) then
        ML > 1 = true
        local
           MLn = ML - 2
           MRn = MR + 2
           AL = a(0 2 0)|T
           {Cross MLn#MRn CL#CR 0 T}
        end
     else
        MR > 1 = true
        local
           MLn = ML + 2
           MRn = MR - 2
           AL = a(1 2 0)|T
           {Cross MLn#MRn CL#CR 1 T}
        end
     end


%2 cannibal

     if (B == 0) then
        CL > 1 = true
        local
           CLn = CL - 2
           CRn = RR + 2
           AL = a(0 0 2)|T
           {Cross ML#MR CLn#CRn 1 T}
        end
     else
        CR > 1 = true
        local
           CLn = CL + 2
           CRn = CR - 2
           AL = a(1 0 2)|T
           {Cross ML#MR CLn#CRn 0 T}
        end
     end


 % 1 Cannibal 1 missinary

     if (B == 0) then
        ML > 0 = true
        CL > 0 = true
        local
           MLn = ML - 1
           MRn = MR + 1
           CLn = CL - 1
           CRn = CR + 1
           AL = a(0 1 1)|T
           {Cross MLn#MRn CLn#CRn 1 T}
        end
     else
        MR > 0 = true
        MR > 0 = true
        local
           MLn = ML + 1
           MRn = MR - 1
           CLn = CL + 1
           CRn = CR - 1
           AL = a(1 1 1)|T
           {Cross ML#MR CLn#CRn 0 T}
        end
     end
      end
   end
end


%%=========================================================================================================%%
%%=========================================================================================================%%
%%=========================================================================================================%%


%% Helper Stuff...

declare


% Depth First Search - From Author's Resoruces Online

fun {Solve Script}
   {SolStep {Space.new Script} nil}
end

fun {SolStep S Rest}
   case {Space.ask S}
   of failed then Rest
   [] succeeded then {Space.merge S}|Rest
   [] alternatives(N) then 
      {SolLoop S 1 N Rest}
   end
end

fun lazy {SolLoop S I N Rest}
   if I>N then Rest
   elseif I==N then
      {Space.commit S I}
      {SolStep S Rest}
   else Right C in
      Right={SolLoop S I+1 N Rest}
      C={Space.clone S}
      {Space.commit C I}
      {SolStep C Right}
   end
end


% Breadth First Search

fun {SolveB Script}
   {SolStepB [{Space.new Script}] nil}
end

fun {SolStepB SL Rest}
   case SL of nil then Rest 
   [] S|T then
      case {Space.ask S}
      of failed then {SolStepB T Rest}
      [] succeeded then {Space.merge S}|{SolStepB T Rest}
      [] alternatives(N) then 
	 {SolLoopB SL 1 N Rest}
      end
   end
end

fun lazy {SolLoopB SL I N Rest}
   case SL of S|T then
      if I>N then {SolStepB T Rest}
      elseif I==N then
	 {Space.commit S I}
	 if {Space.ask S} == failed then {SolStepB SL Rest} else
	 {SolStepB {Append SL S|nil} Rest} end
      else Right C in


	 %Right={SolLoopB SL I+1 N Rest}

	 C={Space.clone S}
	 {Space.commit C I}
	 if {Space.ask C} == failed then {SolLoopB SL I+1 N Rest} else
	 {SolLoopB {Append SL C|nil} I+1 N Rest} end


         %{SolStepB {Append SL C} Right}

      end
   end
end

fun {SolveAll F}
   L = {Solve F}
   proc {TouchAll L}
      if L==nil then skip else {TouchAll L.2} end end
   in
   {TouchAll L}
   L
end


fun {SolveAllB F}
   L = {SolveB F}
   proc {TouchAll L}
      if L==nil then skip else {TouchAll L.2} end end
   in
   {TouchAll L}
   L
end


% Sum Question

proc {Sum N1 N2 N3}

end
%%=========================================================================================================%%
%%=========================================================================================================%%
%%=========================================================================================================%%