Program Pas0803(arg);
{$MODE delphi}

uses
    SysUtils, Math;

const
    // �d�͉����x
    g = -9.8;
    // ��C��R�W��
	k = -0.01;
	// ���ԊԊu(�b)
	h = 0.01;
	// �p�x
	degree = 45;

// ��C��R�ɂ�鐅�������̌�����
function fx(vx:Double; vy:Double):Double;
begin
    result := k * Sqrt(vx * vx + vy * vy) * vx;
end;

// �d�͂Ƌ�C��R�ɂ�鉔�������̌�����
function fy(vx:Double; vy:Double):Double;
begin
    result := g + (k * Sqrt(vx * vx + vy * vy) * vy);
end;

var
	// �p�x
	radian:Double;
	// ����
	v:Double;
	// ���������̑��x
	vx:array [0..1] of Double;
	wx:Double;
	// ���������̑��x
	vy:array [0..1] of Double;
	wy:Double;
	// �o�ߕb��
	t:Double = 0.0;
	// �ʒu
	x:array [0..1] of Double;
	y:array [0..1] of Double;

	i:Integer;
begin
	// �p�x
	radian := degree * PI / 180.0;
	// ���� 250 km/h -> �b���ɕϊ�
	v := 250 * 1000 div 3600;
	// ���������̑��x
	vx[0] := v * Cos(radian);
	// ���������̑��x
	vy[0] := v * Sin(radian);
	// �ʒu
	x[0] := 0.0;
	y[0] := 0.0;

	// ���_�@
	i := 1;
	while y[0] >= 0.0 do
	begin
	    // �o�ߕb��
	    t := i * h;

	    // �ʒu�E���x
        vx[1] := h * fx(vx[0], vy[0]);
        vy[1] := h * fy(vx[0], vy[0]);
        
        wx    := vx[0] + vx[1] / 2;
        wy    := vy[0] + vy[1] / 2;
        vx[0] := vx[0] + h * fx(wx, wy);
        vy[0] := vy[0] + h * fy(wx, wy);
        x[0]  := x[0]  + h *    wx;
        y[0]  := y[0]  + h *    wy;

		writeln(format('%4.2f'#9'%8.5f'#9'%9.5f'#9'%9.5f'#9'%9.5f', [t, vx[0], vy[0], x[0], y[0]]));

	    inc(i);
	end;
end.
