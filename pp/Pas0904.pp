Program Pas0904(arg);
{$MODE delphi}

uses
    SysUtils, Math;

function f0(x:Double):Double;
begin
    result := x * x - 2;
end;

function f1(x:Double):Double;
begin
    result := 2 * x;
end;

function newton(x0:Double):Double;
var
    x1: Double;
begin
    while true do
    begin
        x1 := x0 - (f0(x0) / f1(x0));
        writeln(format('%12.10f'#9'%13.10f', [x1, x1 - sqrt(2)]));

        If Abs(x1 - x0) < 0.0000000001 then break;
        x0 := x1;
    end;

    result := x1;
end;

var
    x:  Double = 2.0;
begin
    writeln(format('%12.10f', [newton(x)]));
end.
