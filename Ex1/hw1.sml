 (* anastasia neiman 313103400 anastasiane@campus.technion.ac.il *)
 (* alex bondar      311822258 alex.bondar@campus.technion.ac.il *)

fun uncurry (f: 'a -> 'b -> 'c) = fn(a,b) => f a b;

fun curry (f:('a * 'b -> 'c)) = fn a => fn b => f(a,b);