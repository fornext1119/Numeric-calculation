Program Pas0501(arg);
{$MODE delphi}

uses
    SysUtils, Math;

// ����̐����֐�
function mySin(x:Double; n:Integer; nega:Boolean; numerator:Double; denominator:Double; y:Double):Double;
var
    m: Integer;
    a: Double;
begin
    m           := 2 * n;
    denominator := denominator * (m + 1) * m;
    numerator   := numerator   * x * x;
    a           := numerator / denominator;
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (a <= 0.00000000001) then
        result := y
    else
    begin
        if not nega then a := -a;
        result := y + mySin(x, n + 1, not nega, numerator, denominator, a);
    end;
end;

var
    i:      Integer;
    degree: Integer;
    radian: Double;
    d1:     Double;
    d2:     Double;
begin
    for i := 0 to 24 do
    begin
        degree := i * 15;
        if (degree mod 30 = 0) or (degree mod 45 = 0) then
        begin
            radian := DegToRad(degree);
            // ����̐����֐�
            d1 := mySin(radian, 1, false, radian, 1.0, radian);
            // �W���̐����֐�
            d2 := Sin(radian);
            // �W���֐��Ƃ̍���
            writeln(format('%3d : %13.10f - %13.10f = %13.10f', [degree, d1, d2, d1 - d2]));
        end;
    end;
end.
