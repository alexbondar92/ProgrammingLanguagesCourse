{anastasia neiman, 313103400 anastasiane@campus.technion.ac.il
 alex bondar,      311822258 alex.bondar@campus.technion.ac.il}
program TheRainfallProblem;


var sum, n, x : integer;


BEGIN
        sum := 0;
        n := 0;
        repeat
          read(x);
          if x>=0 then
            begin
                sum := sum + x;
                n := n + 1;
            end;
        until x = -999;

        if sum>0 then
                WriteLn(sum/n)
        else
                WriteLn(0);

END.

