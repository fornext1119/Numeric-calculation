Program Pas0409(arg);
    
    // 組合せ
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
    // 重複組合せ (異なる 10 個のものから重複を許して 5 個とる組合せの総数)
    n := 10;
    r := 5;
    writeln(Comb(n + r - 1, r));
end.
