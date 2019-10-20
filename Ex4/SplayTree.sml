(* anastasia neiman 313103400 anastasiane@campus
   alex bondar      311822258 alex.bondar@campus *)
datatype ('a,'b) SplayTree = 
	Nil 
   |Br of ('a)*('b)*(('a,'b) SplayTree)*(('a,'b) SplayTree);

datatype Rotate = Zig | ZigZig | ZigZag;
exception NotFound;

fun size Nil = 0
   |size (Br (_,_,left,right)) = 1 + size left + size right;

fun inorder Nil = []
   |inorder (Br (_,v,left,right)) = (inorder left)@[v]@(inorder right);

fun get comp (Nil,_) = raise NotFound
   |get comp (Br (a,b,t1,t2),find_a) = case (comp (a,find_a)) of
				 EQUAL => b
				|GREATER => (get comp (t2,find_a))
				|LESS => (get comp (t1,find_a));

local
	datatype Rotate = Zig | ZigZig | ZigZag | Not;
	fun getKey (Br (a,_,_,_)) = a;
	fun getData (Br (_,b,_,_)) = b;
	fun getLeft (Br (_,_ : 'b,left,_)) = left;
	fun getRight (Br (_,_,_,right)) = right;

	fun isZig comp (Br (a,_,left,right), key) = case (comp  (a, key)) of
					 LESS => if (comp (getKey right, key) = EQUAL) then true else false
					|GREATER => if (comp (getKey left, key) = EQUAL) then true else false;

	fun isZigZig comp (tree, key) = case (comp  (getKey tree, key)) of
					 LESS => (case getRight (getRight tree) of Nil => false | _ => if (comp (getKey (getRight (getRight tree)), key) = EQUAL) then true else false)
					|GREATER => (case getLeft (getLeft tree) of Nil => false | _ => if (comp (getKey (getLeft (getLeft tree)), key) = EQUAL) then true else false);

	fun isZigZag comp (tree, key) = case (comp  (getKey tree, key)) of
					 LESS => (case getLeft (getRight tree) of Nil => false | _ => if (comp (getKey (getLeft (getRight tree)), key) = EQUAL) then true else false)
					|GREATER => (case getRight (getLeft tree) of Nil => false | _ => if (comp (getKey (getRight (getLeft tree)), key) = EQUAL) then true else false);

	fun watSplay comp (Br (a,b,left,right), key) = if ((isZig comp (Br (a,b,left,right), key)) = true) then Zig
			else if ((isZigZig comp (Br (a,b,left,right), key)) = true) then ZigZig
				 else if ((isZigZag comp (Br (a,b,left,right), key)) = true) then ZigZag 
				 	  else Not;

	fun doZig comp (Br (a,b,left,right), key) = if (comp (a, key) = GREATER) then Br (getKey left, getData left, getLeft left, Br (a,b, getRight left, right))
			else Br (getKey right, getData right, Br (a, b, left, getLeft right), getRight right);

	fun doZigZig comp (Br (a,b,left,right), key) = if (comp (a, key) = GREATER) then doZig comp (doZig comp (Br (a,b,left,right), getKey left), key)
			else doZig comp (doZig comp (Br (a,b,left,right), getKey right), key);

	fun doZigZag comp (Br (a,b,left,right), key) = if (comp (a, key) = GREATER) then doZig comp (Br (a, b, left, doZig comp (right, key)), key)
			else doZig comp (Br (a, b, doZig comp (left,key) left, right, key);

	fun splayH comp (Br (a,b,left,right), key) = case (watSplay comp (Br (a,b,left,right), key)) of
			 Zig => doZig comp (Br (a,b,left,right), key)
			|ZigZig => doZigZig comp (Br (a,b,left,right), key)
			|ZigZag => doZigZag comp (Br (a,b,left,right), key)
			|Not => if ((comp (a, key)) = GREATER) then (Br (a,b,left,splayH comp (right, key)))
					else (Br (a,b,splayH comp (left, key), right));

	fun splay comp (Br (a,b,left,right),key) = if ((comp (a, key)) = EQUAL) then (Br (a,b,left,right)) 
			else (splay comp (splayH comp (Br (a,b,left,right), key), key));

	fun insertH comp (Nil,(new_a,new_b)) = Br (new_a,new_b,Nil,Nil)
	   |insertH comp (Br (a,b,left,right),(new_a,new_b)) = case (comp (a,new_a)) of
					 EQUAL => Br (a, new_b, left, right)
					|GREATER => Br (a, b, insertH comp (left, (new_a,new_b)), right)
					|LESS => Br (a, b, left, insertH comp (right, (new_a,new_b)));
in
	fun insert comp (tree,(new_a,new_b)) = splay comp (insertH comp (tree,(new_a,new_b)), new_a);
end;