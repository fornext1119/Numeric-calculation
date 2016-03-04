Program Pas0603(arg);
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
    s2, s4 :Double;
begin
    // Simpsonë•Ç≈êœï™
    n := 2;
    for j := 1 to 5 do
    begin
        h  := (b - a) / n;
        s2 := 0;
        s4 := 0;
        x  := a + h;
        for i := 1 to (n div 2) do
        begin
            s4 := s4 + f(x);
            x  := x  + h;
            s2 := s2 + f(x);
            x  := x  + h;
        end;
        s2 := (s2 - f(b)) * 2 + f(a) + f(b);
        s4 := s4 * 4;
        s  := (s2 + s4) * h / 3;
        n  := n * 2;

        // åãâ Ç ÉŒ Ç∆î‰är
        writeln(format('%2d : %13.10f, %13.10f', [j, s, s - PI]));
    end;
end.
