Program Pas0402(arg);
{$MODE delphi}

function product(m:Integer; d:Integer; n:Integer):Int64;
begin
    if n = 0 then
        result := 1
    else
        result := m * product(m + d, d, n - 1);
end;

begin
    // ‰€ 5, Œö· 3, €” 10 ‚Ì”—ñ‚ÌÏ‚ğ•\¦‚·‚é
    writeln(product(5, 3, 10));
end.
