{anastasia neiman, 313103400 anastasiane@campus.technion.ac.il
 alex bondar,      311822258 alex.bondar@campus.technion.ac.il}
program GrayCode;

var n : integer;
var arr : array [1..256] of integer;

procedure printarray(arr1 : array of integer; n : integer); forward;
procedure intGray(arr1 : array of integer); forward;
procedure gray(arr1 : array of integer ; i : integer); forward;
procedure mirrorGray(arr1 : array of integer ; i : integer); forward;


procedure intGray(arr1 : array of integer);
var i : integer;
begin
    for i := 1 to 255 do
    begin
        arr1[i] := 0
    end
end;


procedure gray(arr1 : array of integer ; i : integer);
begin
        if n=i then
                printarray(arr1, i)
        else
                begin
                arr1[i+1] := 0;
                gray(arr1, i+1);
                arr1[i+1] := 1;
                mirrorGray(arr1, i+1)
                end
end;

procedure mirrorGray(arr1 : array of integer ; i : integer);
begin
        if n=i then
                printarray(arr1, i)
        else
        begin
                arr1[i+1] := 1;
                gray(arr1, i+1);
                arr1[i+1] := 0;
                mirrorGray(arr1, i+1)
        end
end;


procedure printarray(arr1 : array of integer; n : integer);
var i : integer;
begin
        for i := 1 to n do
        begin
                if i = n then
                        WriteLn(arr1[i])
                else
                        Write(arr1[i])

        end
end;

BEGIN
        n := 0;
        read(n);
        intGray(arr);
        gray(arr, 0)
END.
