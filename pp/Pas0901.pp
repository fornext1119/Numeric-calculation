Program Pas0901(arg);
{$MODE delphi}

uses
    SysUtils, Math;

function f(x:Double):Double;
begin
    result := x * x - 2.0;
end;

function bisection(a:Double; b:Double):Double;
var
    c:  Double;
    fc: Double;
begin
    while true do
    begin
        { ‹æŠÔ (a, b) ‚Ì’†“_ c = (a + b) / 2 }
        c := (a + b) / 2;
        writeln(format('%12.10f'#9'%13.10f', [c, c - sqrt(2)]));

        fc := f(c);
        If Abs(fc) < 0.0000000001 then break;
      
        if fc < 0 then
        begin
            { f(c) < 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (c, b) ‚Ì’†‚É‘¶İ }
            a := c;
        end
        else
        begin
            { f(c) > 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (a, c) ‚Ì’†‚É‘¶İ }
            b := c;
        end;
    end;

    result := c;
end;

var
    a:  Double = 1.0;
    b:  Double = 2.0;
begin
    writeln(format('%12.10f', [bisection(a, b)]));
end.
