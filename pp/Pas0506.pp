Program Pas0506(arg);
{$MODE delphi}

uses
    SysUtils, Math;

// ����̑ΐ��֐�
function myLog(x2:Double; numerator:Double; denominator:Double; y:Double):Double;
var
    a :Double;
begin
    denominator := denominator + 2;
    numerator   := numerator   * x2 * x2;
    a           := numerator / denominator;
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (Abs(a) <= 0.00000000001) then
        result := y
    else
        result := y + myLog(x2, numerator, denominator, a);
end;

var
    i:  Integer;
    x:  Double;
    x2: Double;
    d1: Double;
    d2: Double;
begin
    for i := 1 to 20 do
    begin
        x  := i / 5.0;
        // �W���̑ΐ��֐�
        d1 := Ln(x);
        // ����̑ΐ��֐�
        x2 := (x - 1) / (x + 1);
        d2 := 2 * myLog(x2, x2, 1.0, x2);
        // �W���֐��Ƃ̍���
        writeln(format('%5.2f : %13.10f - %13.10f = %13.10f', [x, d1, d2, d1 - d2]));
    end;
end.
