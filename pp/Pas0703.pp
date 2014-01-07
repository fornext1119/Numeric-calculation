Program Pas0703(arg);
{$MODE delphi}

uses
    SysUtils, Math;

const
    // �f�[�^�_�̐� - 1
    N = 6;

// ���̊֐�
function f(x:Double):Double;
begin
    result := x - power(x,3) / (3 * 2) + power(x,5) / (5 * 4 * 3 * 2);
end;

// Newton (�j���[�g��) ���
function newton(d:Double; x:array of Double; a:array of Double):Double;
var
    sum, prod :Double;
    i, j      :Integer;
begin
    sum := a[0];
    for i := 1 to High(x) do
    begin
        prod := a[i];
        for j := Low(x) to i-1 do
            prod := prod * (d - x[j]);
        sum := sum + prod;
    end;
    result := sum;
end;

var
    i, j :Integer;
    x :array [0..N] of Double;
    y :array [0..N] of Double;
    a :array [0..N] of Double;
    d :array [0..N, 0..N] of Double;
    d1, d2, d3 :Double;
begin
    // 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
    for i := Low(x) to High(x) do
    begin
        d1   := i * 1.5 - 4.5;
        x[i] := d1;
        y[i] := f(d1);
    end;

    // �������̕\�����
    for j := Low(y) to High(y) do
        d[0,j] := y[j];

    for i := 1 to High(x) do
    begin
        for j := Low(x) to High(x)-i do
            d[i,j] := (d[i-1,j+1] - d[i-1,j]) / (x[j+i] - x[j]);
    end;

    // ���K������
    for j := Low(a) to High(a) do
        a[j] := d[j,0];

    // 0.5���݂� �^�����Ă��Ȃ��l���� 
    for i := 0 to 18 do
    begin
        d1 := i * 0.5 - 4.5;
        d2 := f(d1);
        d3 := newton(d1, x, a);

        // ���̊֐��Ɣ�r
        writeln(format('%5.2f'#9'%8.5f'#9'%8.5f'#9'%8.5f', [d1, d2, d3, d2 - d3]));
    end;
end.
