 (* anastasia neiman 313103400 anastasiane@campus.technion.ac.il *)
 (* alex bondar      311822258 alex.bondar@campus.technion.ac.il *)


fun dubchar a = str(a)^str(a);


fun apply_on_nth_char f n = fn str => if size(str)<n+1 orelse n<0 then f #"!" else f(String.sub(str, n));


local
	fun sum_mod0 (num,0) = 0
         |sum_mod0 (num,a) = if (num mod a = 0) then a+temp5(num,a-1) else temp5(num,a-1);
in
	fun perfect 0 = false
	    |perfect num = if (sum_mod0(num,num-1) = num) then true else false;
end;





local
	fun cnt_brackets (str,~1,a) = if (a = 0 ) then true else false
	   |cnt_brackets (str,i,~1) = false
	   |cnt_brackets (str,i,a) = if(String.sub(str,i) = #")" ) then cnt_brackets(str,i-1, a+1)
				else if(String.sub(str,i) = #"(" ) then cnt_brackets(str,i-1, a-1)
				else cnt_brackets(str,i-1,a)
in
	fun balance str = cnt_brackets(str,size(str)-1,0)
end;





fun sig1 a b f = if ( 2 = 1) then f(a,b) else b;
fun sig2 (3,a) f = true
   |sig2 (a,b) f = if(f(b+2.0)="str") then false else true;
fun sig3 f a b d = f a b;
fun sig4 a b c d = c+d;
fun sig5 f a g = g (f a,f a);
fun sig6 () () = 1;