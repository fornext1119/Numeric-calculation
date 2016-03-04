Program Pas0705(arg);
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

// Spline (�X�v���C��) ���
function spline(d:Double; x:array of Double; y:array of Double; z:array of Double):Double;
var
    d1, d2, d3 :Double;
    i, k :Integer;
begin
    // ��Ԋ֐��l���ǂ̋�Ԃɂ��邩
    k := -1;
    for i := 1 to High(x) do
	begin
        if d <= x[i] then
        begin
            k := i - 1;
            break;
        end;
    end;
    if k < 0 then
		k := i - 1;

    d1     := x[k+1] - d;
    d2     := d      - x[k];
    d3     := x[k+1] - x[k];
    result := (z[k] * power(d1,3) + z[k+1] * power(d2,3)) / (6.0 * d3)
            + (y[k]   / d3 - z[k]   * d3 / 6.0) * d1  
            + (y[k+1] / d3 - z[k+1] * d3 / 6.0) * d2;
end;

var
    i, j :Integer;
    x  :array [0..N] of Double;
    y  :array [0..N] of Double;
    a  :array [0..N] of Double;
    b  :array [0..N] of Double;
    c  :array [0..N] of Double;
    d  :array [0..N] of Double;
    g  :array [0..N] of Double;
    s  :array [0..N] of Double;
    z  :array [0..N] of Double;
    d1, d2, d3 :Double;
begin
    // 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
    for i := Low(x) to High(x) do
    begin
        d1   := i * 1.5 - 4.5;
        x[i] := d1;
        y[i] := f(d1);
    end;

    // �R���������̌W���̕\�����
    for i := 1 to High(x)-1 do
    begin
        a[i] :=         x[i]   - x[i-1]; 
        b[i] := 2.0 *  (x[i+1] - x[i-1]); 
        c[i] :=         x[i+1] - x[i]; 
        d[i] := 6.0 * ((y[i+1] - y[i]) / (x[i+1] - x[i]) - (y[i] - y[i-1]) / (x[i] - x[i-1]));
    end;
    // �R�������������� (�g�|�}�X�@)
    g[1] := b[1];
    s[1] := d[1];
    for i := 2 to High(a)-1 do
    begin
        g[i] := b[i] - a[i] * c[i-1] / g[i-1];
        s[i] := d[i] - a[i] * s[i-1] / g[i-1];
    end;
    z[0]   := 0;
    z[N]   := 0;
    z[N-1] := s[N-1] / g[N-1];
    for i := N-2 downto 1 do
    begin
        z[i] := (s[i] - c[i] * z[i+1]) / g[i];
    end;

    // 0.5���݂� �^�����Ă��Ȃ��l���� 
    for i := 0 to 18 do
    begin
        d1 := i * 0.5 - 4.5;
        d2 := f(d1);
        d3 := spline(d1, x, y, z);

        // ���̊֐��Ɣ�r
        writeln(format('%5.2f'#9'%8.5f'#9'%8.5f'#9'%8.5f', [d1, d2, d3, d2 - d3]));
    end;
end.
