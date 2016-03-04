Program Pas0406(arg);
uses
    SysUtils;

    // ŠKæ
    function Fact(n: Integer): Longint;
    begin
        if n <= 1 then
            Fact := 1
        else
            Fact := n * Fact(n - 1);
    end;

    // ‰º~ŠKæ™p
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
    // ‡—ñ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‡—ñ‚Ì‘”)
    n := 10;
    r := 5;
    writeln(format('%g', [Fact(n) / Fact(n - r)]));
    writeln(FallingFact(n, r));
end.
