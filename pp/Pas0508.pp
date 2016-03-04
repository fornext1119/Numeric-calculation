Program Pas0508(arg);
{$MODE delphi}

uses
    SysUtils, Math;

// ����̑o�Ȑ������֐�
function mySinh(x:Double; n:Integer; numerator:Double; denominator:Double; y:Double):Double;
var
    m: Integer;
    a: Double;
begin
    m           := 2 * n;
    denominator := denominator * (m + 1) * m;
    numerator   := numerator   * x * x;
    a           := numerator / denominator;
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (Abs(a) <= 0.00000000001) then
        result := y
    else
        result := y + mySinh(x, n + 1, numerator, denominator, a);
end;

var
    i:  Integer;
    x:  Integer;
    d1: Double;
    d2: Double;
begin
    for i := 0 to 20 do
    begin
        x  := i - 10;
        // ����̑o�Ȑ������֐�
        d1 := mySinh(x, 1, x, 1.0, x);
        // �W���̑o�Ȑ������֐�
        d2 := Sinh(x);
        // �W���֐��Ƃ̍���
        writeln(format('%3d : %17.10f - %17.10f = %13.10f', [x, d1, d2, d1 - d2]));
    end;
end.
