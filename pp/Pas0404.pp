Program Pas0404(arg);

    // ‰º~ŠKæ™p
    function FallingFact(x: Integer; n: Integer): Longint;
    begin
        if n <= 1 then
            FallingFact := x
        else
            FallingFact := x * FallingFact(x - 1, n - 1);
    end;

begin
    // 10 ‚©‚ç 6 ‚Ü‚Å‚Ì ‘æ
    writeln(FallingFact(10, 5));
    writeln(10 * 9 * 8 * 7 * 6);
end.
