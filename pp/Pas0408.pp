Program Pas040101(arg);
    
    // ‘g‡‚¹
    function Comb(n: Integer; r: Integer): Longint;
    begin
        if (r = 0) or (r = n) then
            Comb := 1
        else if r = 1 then
            Comb := n
        else
            Comb := Comb(n - 1, r - 1) + Comb(n - 1, r);
    end;

var
    n: Integer;
    r: Integer;
begin
    // ‘g‡‚¹ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‘g‡‚¹‚Ì‘”)
    n := 10;
    r := 5;
    writeln(Comb(n, r));
end.
