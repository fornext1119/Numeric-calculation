Program Pas0407(arg);
uses
    SysUtils, Math;
var
    n: Integer;
    r: Integer;
begin
    // 重複順列 (異なる 10 個のものから重複を許して 5 個取ってできる順列の総数)
    n := 10;
    r := 5;
    writeln(format('%g', [power(n, r)]));
end.
