Program Pas0504(arg);
{$MODE delphi}

uses
    SysUtils, Math;

// ����̎w���֐�
function myExp(x:Double; n:Integer; numerator:Double; denominator:Double; y:Double):Double;
var
    a: Double;
begin
    denominator := denominator * n;
    numerator   := numerator   * x;
    a           := numerator / denominator;
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (Abs(a) <= 0.00000000001) then
        result := y
    else
        result := y + myExp(x, n + 1, numerator, denominator, a);
end;

var
    i:  Integer;
    x:  Double;
    d1: Double;
    d2: Double;
begin
    for i := 0 to 20 do
    begin
        x  := (i - 10) / 4.0;
        // �W���̎w���֐�
        d1 := Exp(x);
        // ����̎w���֐�
        d2 := myExp(x, 1, 1.0, 1.0, 1.0);
        // �W���֐��Ƃ̍���
        writeln(format('%5.2f : %13.10f - %13.10f = %13.10f', [x, d1, d2, d1 - d2]));
    end;
end.
