Program Pas0701(arg);
{$MODE delphi}

uses
    SysUtils, Math;

// ���̊֐�
function f(x:Double):Double;
begin
    result := x - power(x,3) / (3 * 2) + power(x,5) / (5 * 4 * 3 * 2);
end;

// Lagrange (���O�����W��) ���
function lagrange(d:Double; x:array of Double; y:array of Double):Double;
var
    sum, prod :Double;
    i, j      :Integer;
begin
    sum := 0;
    for i := Low(x) to High(x) do
    begin
        prod := y[i];
        for j := Low(x) to High(x) do
        begin
            if j <> i then
                prod := prod * (d - x[j]) / (x[i] - x[j]);
        end;
        sum := sum + prod;
    end;
    result := sum;
end;

const
    // �f�[�^�_�̐� - 1
    N = 6;
var
    i :Integer;
    x :array [0..N] of Double;
    y :array [0..N] of Double;
    d, d1, d2 :Double;
begin
    // 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
    for i := Low(x) to High(x) do
    begin
        d    := (i - 1) * 1.5 - 4.5;
        x[i] := d;
        y[i] := f(d);
    end;

    // 0.5���݂� �^�����Ă��Ȃ��l����
    for i := 0 to 18 do
    begin
        d  := i * 0.5 - 4.5;
        d1 := f(d);
        d2 := lagrange(d, x, y);

        // ���̊֐��Ɣ�r
        writeln(format('%5.2f'#9'%8.5f'#9'%8.5f'#9'%8.5f', [d, d1, d2, d1 - d2]));
    end;
end.
