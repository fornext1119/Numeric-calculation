Program Pas0303(arg);
uses
    SysUtils, Math;
var
    n:Integer;
    a:Integer;
    r:Integer;
begin
    // ‰€ 2, Œö”ä 3, €” 10 ‚Ì“™”ä”—ñ‚Ì˜a
    n := 10;
    a := 2;
    r := 3;
    writeln( format('%g', [(a * (power(r, n) - 1)) / (r - 1)]) );
end.
