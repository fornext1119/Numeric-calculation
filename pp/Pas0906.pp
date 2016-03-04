Program Pas0906(arg);
{$MODE delphi}

uses
    SysUtils, Math;

function f(x:Double):Double;
begin
    result := x * x - 2;
end;

function secant(x0:Double; x1:Double):Double;
var
    x2: Double;
begin
    while true do
    begin
		x2 := x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0));
        writeln(format('%12.10f'#9'%13.10f', [x1, x1 - sqrt(2)]));

        If Abs(x1 - x0) < 0.0000000001 then break;
        x0 := x1;
        x1 := x2;
    end;

    result := x2;
end;

var
    x0:  Double = 1.0;
    x1:  Double = 2.0;
begin
    writeln(format('%12.10f', [secant(x0, x1)]));
end.
