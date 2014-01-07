Program Pas0602(arg);
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
begin
    // ’†“_‘¥‚ÅÏ•ª
    n := 2;
    for j := 1 to 10 do
    begin
        h := (b - a) / n;
        s := 0;
        x := a + (h / 2);
        for i := 1 to n do
        begin
            s := s + f(x);
            x := x + h;
        end;
        s := h * s;
        n := n * 2;

        // Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
        writeln(format('%2d : %13.10f, %13.10f', [j, s, s - PI]));
    end;
end.
