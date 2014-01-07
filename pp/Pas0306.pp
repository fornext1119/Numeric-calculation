Program Pas0306(arg);
uses
    SysUtils, Math;
var
    n:Integer;
begin
    // 100 ‚Ü‚Å‚Ì ©‘R”‚Ì‚Ræ‚Ì˜a
    n := 100;
    writeln( format('%g', [(power(n, 2) * power((n + 1), 2) / 4)]) );
end.
