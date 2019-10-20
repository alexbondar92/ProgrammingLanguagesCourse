(* anastasia neiman 313103400 anastasiane@campus
   alex bondar      311822258 alex.bondar@campus *)
datatype natural = zero | Succ of natural;
exception NotNatural;


fun prev zero = raise NotNatural
   |prev (Succ(x)) = x;


fun natural_rep zero = 0
   |natural_rep (Succ(x)) = 1 + (natural_rep (x));


fun group_rep 0 = zero
   |group_rep n = if (n < 0 ) then raise NotNatural else Succ(group_rep(n-1));


fun less_eq (a,b) = if ((natural_rep(a)) <= (natural_rep(b))) then true else false;
infix less_eq;


fun gadd (zero,b) = b
   |gadd (a,zero) = a
   |gadd (a,b) = gadd(prev(a),Succ(b));
infix gadd;


fun gmul (zero,b) = zero
   |gmul (a, zero) = zero
   |gmul (a,b) = if (prev(a) = zero) then b else (b gadd gmul(prev(a), b));
infix gmul;


fun gsub (a,zero) = a
   |gsub (zero,b) = raise NotNatural
   |gsub (a,b) = gsub(prev(a), prev(b));

infix gsub;


fun gdiv (a,zero) = raise Div
   |gdiv (zero,b) = zero
   |gdiv (a,b) = if (a less_eq b andalso b less_eq a) then Succ(zero) else if (a less_eq b) then zero else Succ(gdiv((a gsub b),b));
infix gdiv;