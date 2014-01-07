Program Pas0403(arg);
    // ŠKæ‚ğ‹‚ß‚éŠÖ”
    function Fact(n: Integer): Longint;
    begin
        if n <= 1 then
            Fact := 1
        else
            Fact := n * Fact(n - 1);
    end;

begin
    // 10‚ÌŠKæ
    writeln(Fact(10));
    writeln(10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1);
end.
