Program Pas0505(arg);
{$MODE delphi}

uses
    SysUtils, Math;

// ����̎w���֐�
function myExp(x:Double; x2:Double; n:Integer; t:Double):Double;
begin
    t := x2 / (n + t);
    n := n - 4;  

    if (n < 6) then
        result := 1 + ((2 * x) / (2 - x + t))
    else
        result := myExp(x, x2, n, t);
end;

var
    i:  Integer;
    x:  Double;
    x2: Double;
    d1: Double;
    d2: Double;
begin
    for i := 0 to 20 do
    begin
        x  := (i - 10) / 4.0;
        // �W���̎w���֐�
        d1 := Exp(x);
        // ����̎w���֐�
        x2 := x * x;
        d2 := myExp(x, x2, 30, 0.0); // 30:�K�v�Ȑ��x��������悤, 6����n�߂�4������������
        // �W���֐��Ƃ̍���
        writeln(format('%5.2f : %13.10f - %13.10f = %13.10f', [x, d1, d2, d1 - d2]));
    end;
end.
