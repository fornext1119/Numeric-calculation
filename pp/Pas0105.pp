Program Pas0105(arg);
var
    i:integer;
    sum:integer = 0;
begin
    for i := 1 to 99 do
    begin
        if (i mod 3 = 0) then
            sum := sum + i;
    end;
    writeln(sum);
end.
