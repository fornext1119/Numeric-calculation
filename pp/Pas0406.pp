Program Pas0406(arg);
uses
    SysUtils;

    // 階乗
    function Fact(n: Integer): Longint;
    begin
        if n <= 1 then
            Fact := 1
        else
            Fact := n * Fact(n - 1);
    end;

    // 下降階乗冪
    function FallingFact(x: Integer; n: Integer): Longint;
    begin
        if n <= 1 then
            FallingFact := x
        else
            FallingFact := x * FallingFact(x - 1, n - 1);
    end;

var
    n: Integer;
    r: Integer;
begin
    // 順列 (異なる 10 個のものから 5 個取ってできる順列の総数)
    n := 10;
    r := 5;
    writeln(format('%g', [Fact(n) / Fact(n - r)]));
    writeln(FallingFact(n, r));
end.
