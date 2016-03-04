Program Pas0103(arg);
uses
    SysUtils;
var
    i:integer;
begin
    for i := 1 to 9 do
    begin
        write(format('%d, ', [i]));
    end;
    writeln();
end.
