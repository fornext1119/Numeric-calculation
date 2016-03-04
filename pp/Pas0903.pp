Program Pas0903(arg);
{$MODE delphi}

uses
    SysUtils, Math;

function g(x:Double):Double;
begin
    result := (x / 2) + (1 / x);
end;

function iterative(x0:Double):Double;
var
    x1: Double;
begin
    while true do
    begin
        x1 := g(x0);
        writeln(format('%12.10f'#9'%13.10f', [x1, x1 - sqrt(2)]));

        If Abs(x1 - x0) < 0.0000000001 then break;
        x0 := x1;
    end;

    result := x1;
end;

var
    x:  Double = 1.0;
begin
    writeln(format('%12.10f', [iterative(x)]));
end.
