(* Alex Bondar alex.bondar@campus  311822258
   Anastasia Neiman anastasinane@campus 313103400)

(*============================================================*)
(*========================= Part One =========================*)
(*============================================================*)

(*datatype 'a list = nil | :: of 'a * 'a list;
infixr 5 ::;*)

datatype ('a, 'b) heterolist = HNil | KuKu of 'a*(('b, 'a) heterolist);

fun build4 (x,one,y,two) = KuKu(x,KuKu(one,KuKu(y,KuKu(two,HNil))));

val KuKu(x,KuKu(one,KuKu(y,KuKu(two,HNil)))) = build4 ("x",1,"y",2);
(*val ("x",1,"y",2) = (x,one,y,two)*)

local 
	fun unzipA HNil = nil
	   |unzipA (KuKu(a,HNil)) = [a]
	   |unzipA (KuKu(a,KuKu(_,xf))) = a::(unzipA xf)
	fun unzipB HNil = nil
	   |unzipB (KuKu(_,HNil)) = nil
	   |unzipB (KuKu(_,KuKu(b,HNil))) = [b]
	   |unzipB (KuKu(_,KuKu(b,KuKu(_,xf)))) = b::(unzipB xf)
in
fun unzip HNil = (nil, nil)
   |unzip list1 = (unzipA list1, unzipB list1)
end;


exception Empty;

fun zip (nil : 'a list,nil : 'b list) = raise Empty
   |zip (a::b::_,nil) = raise Empty
   |zip (nil, a::_) = raise Empty
   |zip (a::nil, nil) = KuKu(a,HNil)
   |zip (a::xf,b::yf) = KuKu (a,KuKu(b,zip (xf,yf)));

(*============================================================*)
(*========================= Part Two =========================*)
(*============================================================*)
datatype 'a seq = Nil 
				| Cons of 'a * (unit-> 'a seq);
exception EmptySeq;
fun head(Cons(x,_)) = x
   | head Nil = raise EmptySeq;
fun tail(Cons(_,xf)) = xf()
   | tail Nil = raise EmptySeq;

datatype direction = Back | Forward;
datatype 'a bseq =   bNil
		        | bCons of 'a * (direction -> 'a bseq);
fun bHead(bCons(x,_)) = x
   | bHead bNil = raise EmptySeq;
fun bForward(bCons(_,xf)) = xf(Forward)
   | bForward bNil = raise EmptySeq;
fun bBack(bCons(_,xf)) = xf(Back)
   | bBack bNil = raise EmptySeq;

fun intbseq(k:int) = bCons(k,fn Forward => intbseq(k+1)
							   | Back => intbseq(k-1));


fun bmap f bNil = bNil
   |bmap f (bCons(a,xf)) = bCons(f(a),fn(direction)=>bmap f (xf(direction)));


fun bfilter pred d bNil = bNil
   |bfilter pred direction (bCons(a,xf)) = if ((pred a) = true) then bCons(a, fn(direction)=>bfilter pred direction (xf(direction)))
   										else (bfilter pred direction (xf(direction)));


fun seq2bseq (Cons(a,xf)) (Cons(b,yf)) = (bCons(b,fn(Forward) => seq2bseq (Cons(b,fn()=>Cons(a,xf))) (yf())
												   |(Back) => seq2bseq (xf()) (Cons(a,fn()=>Cons(b,yf)))));

fun bSeqJump (bCons(a,xf)) n = bCons(a, fn(direction)=>bfilter (fn a => a mod n = 0) direction (xf(direction)));