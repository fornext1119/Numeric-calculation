Program Pas0104(arg);
uses
    SysUtils;
var
    i:integer;
begin
    for i := 1 to 9 do
    begin
        if (i mod 3 = 0) then
            write(format('%d, ', [i]));
    end;
    writeln();
end.
