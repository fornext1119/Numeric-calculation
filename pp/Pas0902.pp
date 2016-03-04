Program Pas0902(arg);
{$MODE delphi}

uses
    SysUtils, Math;

function f(x:Double):Double;
begin
    result := x * x - 2.0;
end;

function falseposition(a:Double; b:Double):Double;
var
    c:  Double;
    fc: Double;
begin
    while true do
    begin
        { �_ (a,f(a)) �� �_ (b,f(b)) �����Ԓ����� x���̌�_ }
        c := (a * f(b) - b * f(a)) / (f(b) - f(a));
        writeln(format('%12.10f'#9'%13.10f', [c, c - sqrt(2)]));

        fc := f(c);
        If Abs(fc) < 0.0000000001 then break;
      
        if fc < 0 then
        begin
            { f(c) < 0 �ł����, ���͋�� (c, b) �̒��ɑ��� }
            a := c;
        end
        else
        begin
            { f(c) > 0 �ł����, ���͋�� (a, c) �̒��ɑ��� }
            b := c;
        end;
    end;

    result := c;
end;

var
    a:  Double = 1.0;
    b:  Double = 2.0;
begin
    writeln(format('%12.10f', [falseposition(a, b)]));
end.
