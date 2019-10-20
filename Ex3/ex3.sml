(* anastasia neiman 313103400 anastasiane@campus
   alex bondar      311822258 alex.bondar@campus *)

fun T ([]::_) = []
  | T rows:real list list = (map hd rows) :: T (map tl rows);

local
	fun addRow ([],[]) = []
	   |addRow (A:real list,B) = (hd A + hd B)::addRow(tl A,tl B);
	fun sum ([],[]) = []
	   |sum (A,B) = addRow (hd A,hd B)::sum(tl A,tl B);
in
	infix ++;
	val op++ = sum;
end;


local
      fun f1 ([],[]) = 0.0 
         |f1 (A1,B1) = op*(hd A1,hd B1) + (f1 (tl A1,tl B1));
      fun mulRow (_,[]) = [] 
         |mulRow (A,B) = (f1 (A,hd B))::mulRow(A,tl B);
      fun mulMatrix ([],_) = [] 
         |mulMatrix (A,B) = (mulRow (hd A,T B))::mulMatrix(tl A,B);
in
      infix **;
      val op** = mulMatrix;
end;

local 
	fun take (0,_) = []
	   |take (i,x::xs) = x::take (i-1,xs);
	fun drop (0,xs) = xs
	   |drop (i,_::xs) = drop (i-1,xs);
	fun length [] = 0
	   |length (_::xs) = 1+ length xs;
	fun RemoveRow (i,A) = (take (i-1,A))@(drop (i,A));
	fun RemoveCol (j,[]) = []
	   |RemoveCol (j,A) = (RemoveRow (j,hd A))::(RemoveCol (j,tl A));
	fun Get (i,j,A) = hd (drop (j-1,hd (drop (i-1,A))));
	fun Minor (i,j,A) = if (length A > 2) then RemoveRow(i,RemoveCol(j,A)) else A;
	fun DetH (#"+",i,j,A) = if (length A = 2) then (Get(1,1,A) * Get(2,2,A)) - (Get(1,2,A) * Get(2,1,A))
      		 			else  (Get(i,j,A)*DetH(#"+",1,1,Minor (i,j,A))) + (if (j+1 > length A) then 0.0 else DetH(#"-",i,j+1,A))
   	   |DetH (#"-",i,j,A) = if (length A = 2) then (Get(1,1,A) * Get(2,2,A)) - (Get(1,2,A) * Get(2,1,A))
			 			else  ((~1.0)*Get(i,j,A)*DetH(#"+",1,1,Minor (i,j,A))) + (if (j+1 > length A) then 0.0 else DetH(#"+",i,j+1,A));
	fun Det A = DetH (#"+",1,1,A);
	fun Adj A = if (length A = 2)then [[Get(2,2,A),(~1.0)*Get(1,2,A)],[(~1.0)*Get(2,1,A),Get(1,1,A)]] else T (AdjH (1,1,A,A));
	fun Insert (i,j,a,A) = (take(i-1,A))@(((take (j-1,hd (drop (i-1,A))))@(a::(tl (drop(j-1,hd (drop (i-1,A)))))))::(tl (drop (i-1,A))));
	fun AdjH (i,j,A,B) = if (i > length (hd A)) then B else AdjH(if (j+1 > length (hd A)) then i+1 else i,if (j+1 > (length (hd A))) then 1 else j+1,A, Insert(i,j,(Det (Minor (i,j,A)))*(if ((i+j) mod 2 = 0) then 1.0 else ~1.0), B));
	fun hiluk b a = a/b;
	fun invertibleH (A,[]) = []	   |invertibleH (A,B) = (map (hiluk (Det A)) (hd B))::(invertibleH (A,tl B));
in 
	fun invertible A = invertibleH(A, Adj A);
end;

local
	fun take (0,_) = []
	   |take (i,x::xs) = x::take (i-1,xs);
	fun drop (0,xs) = xs
	   |drop (i,_::xs) = drop (i-1,xs);
	fun length [] = 0
	   |length (_::xs) = 1+ length xs;
	fun Insert (i,j,a,A) = (take(i-1,A))@(((take (j-1,hd (drop (i-1,A))))@(a::(tl (drop(j-1,hd (drop (i-1,A)))))))::(tl (drop (i-1,A))));
	fun BigCity (0,_) = []
	   |BigCity (i,j) = City(j)::BigCity((i-1),j);
	fun City 0 = []
	   | City (i) = 0::City(i-1);
	fun newRow 0 = []
	   | newRow j = 0::newRow(j-1);
	fun findMin (a,b) = if (a < b) then a else b;
	fun insertB (i,j,x,y,A) = Insert(i,j,findMin(x,y), A);
	fun Get (i,A) = hd (drop(i-1, A));
	fun emptyMatrix (0,_) = []
	   |emptyMatrix(i,j) = newRow(j)::emptyMatrix(i-1,j);
	fun InsertBilding (i,j,west, north, city) = if ((i = (length west)) andalso (j = (length north))) then insertB(i,j,Get (i,west), Get(j,north), city) else InsertBilding(if (i = (length west))then i else i+1,if (j = (length north))then j else j+1,west,north,insertB(i,j,Get (i,west), Get(j,north), city));
	fun InsertBilding (i,j,west,north, city) = if ((i = (length west)) andalso (j = (length north))) then insertB(i,j,Get (i,west), Get(j,north), city) else 
			if (Get(i,west) < Get(j,north)) then InsertBilding (i+1,j,west, north,insertB(i,j,Get (i,west), Get(j,north), city)) else if (Get(i,west) > Get(j,north)) then InsertBilding (i,j+1,west, north,insertB(i,j,Get (i,west), Get(j,north), city)) else InsertBilding (if(i = length west) then i else i+1,if(j = length north) then j else j+1,west, north,insertB(i,j,Get (i,west), Get(j,north), city));
	fun max_cityH (i,j,west,north,city) = if(i = 1 andalso j = 1) then Insert(i,j,findMin(Get(i,west),Get(j,north)),city) else
		max_cityH(if (j = 1)then i-1 else i ,if (j = 1)then length north else j-1,west,north,Insert(i,j,findMin(Get(i,west),Get(j,north)),city));
in
	fun min_city [] _ = []
	   |min_city _ [] = []
	   |min_city west north = InsertBilding (1,1,west,north, BigCity(length west,length north));

	fun max_city [] _ = []
	   |max_city _ [] = []
	   |max_city west north = max_cityH (length west, length north, west, north, BigCity(length west,length north));
end;