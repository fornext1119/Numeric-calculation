Program Pas0503(arg);
{$MODE delphi}

uses
    SysUtils, Math;

// ����̐��ڊ֐�
function myTan(x:Double; x2:Double; n:Integer; t:Double):Double;
begin
    t := x2 / (n - t);
    n := n - 2;
    if (n <= 1) then
        result := x / (1 - t)
    else
        result := myTan(x, x2, n, t);
end;

var
    i:      Integer;
    degree: Integer;
    radian: Double;
    x2:     Double;
    d1:     Double;
    d2:     Double;
begin
    for i := 0 to 12 do
    begin
        if (i * 15 mod 180 <> 0) then
        begin
            degree := i * 15 - 90;
            radian := DegToRad(degree);
            // ����̐��ڊ֐�
            x2 := radian * radian;
            d1 := myTan(radian, x2, 15, 0.0); // 15:�K�v�Ȑ��x��������\���傫�Ȋ
            // �W���̐��ڊ֐�
            d2 := Tan(radian);
            // �W���֐��Ƃ̍���
            writeln(format('%3d : %13.10f - %13.10f = %13.10f', [degree, d1, d2, d1 - d2]));
        end;
    end;
end.
