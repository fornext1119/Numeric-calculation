Program Pas0604(arg);
{$MODE delphi}

uses
    SysUtils, Math;

function f(x:Double):Double;
begin
    result := 4 / (1 + x * x);
end;

const
    a:Double = 0;
    b:Double = 1;
var
    n, i, j:Integer;
    h, s, x:Double;
    t:array [1..6, 1..6] of Double;
begin
    // ‘äŒ`‘¥‚ÅÏ•ª
    n := 2;
    for i := 1 to 6 do
    begin
        h := (b - a) / n;
        s := 0;
        x := a;
        for j := 1 to n - 1 do
        begin
            x := x + h;
            s := s + f(x);
        end;
        // Œ‹‰Ê‚ğ•Û‘¶
        t[i,1] := h * ((f(a) + f(b)) / 2 + s);
        n      := n * 2;
    end;

    // Richardson‚Ì•âŠO–@
    n := 4;
    for j := 2 to 6 do
    begin
        for i := j to 6 do
        begin
            t[i,j] := t[i, j - 1] + (t[i, j - 1] - t[i - 1, j - 1]) / (n - 1);
            if i = j then
            begin
                // Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
                writeln(format('%2d : %13.10f, %13.10f', [j, t[i,j], t[i,j] - PI]));
            end;
        end;
        n := n * 4;
    end;
end.
