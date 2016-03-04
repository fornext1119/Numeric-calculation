with Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics, Ada.Numerics.Long_Elementary_Functions;
use  Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics, Ada.Numerics.Long_Elementary_Functions;

procedure Ada0805 is
    -- �d�͉����x
    g : Constant Long_Float := -9.8;
    -- ��C��R�W��
    k : Constant Long_Float := -0.01;
    -- ���ԊԊu(�b)
    h : Constant Long_Float := 0.01;
    -- �p�x
    degree : Constant Long_Float := 45.0;

	-- ��C��R�ɂ�鐅�������̌�����
	function fx(vx:Long_Float; vy:Long_Float) return Long_Float is
	begin
	    return k * Sqrt(vx * vx + vy * vy) * vx;
	end fx;

	-- �d�͂Ƌ�C��R�ɂ�鉔�������̌�����
	function fy(vx:Long_Float; vy:Long_Float) return Long_Float is
	begin
	    return g + (k * Sqrt(vx * vx + vy * vy) * vy);
	end fy;

	-- �p�x
	radian:Long_Float;
	-- ����
	v:Long_Float;
	-- ���������̑��x
	vx:array (0..4) of Long_Float;
	wx:Long_Float;
	-- ���������̑��x
	vy:array (0..4) of Long_Float;
	wy:Long_Float;
	-- �o�ߕb��
	t:Long_Float := 0.0;
	-- �ʒu
	x:array (0..4) of Long_Float;
	y:array (0..4) of Long_Float;

	i:Integer;
begin
	-- �p�x
	radian := degree * Pi / 180.0;
	-- ���� 250 km/h -> �b���ɕϊ�
	v := Long_Float(250 * 1000 / 3600);
	-- ���������̑��x
	vx(0) := v * Cos(radian);
	-- ���������̑��x
	vy(0) := v * Sin(radian);
	-- �ʒu
	x(0) := 0.0;
	y(0) := 0.0;

	-- Runge-Kutta-Gill�@
	i := 1;
	while y(0) >= 0.0 loop
	    -- �o�ߕb��
	    t := Long_Float(i) * h;

	    -- �ʒu�E���x
        x(1)  := h *    vx(0);
        y(1)  := h *    vy(0);
        vx(1) := h * fx(vx(0), vy(0));
        vy(1) := h * fy(vx(0), vy(0));
        
        wx    := vx(0) + vx(1) / 2.0;
        wy    := vy(0) + vy(1) / 2.0;
        x(2)  := h *    wx;
        y(2)  := h *    wy;
        vx(2) := h * fx(wx, wy);
        vy(2) := h * fy(wx, wy);

        wx    := vx(0) + vx(1) * ((Sqrt(2.0) - 1.0) / 2.0) + vx(2) * (1.0 - 1.0 / Sqrt(2.0));
        wy    := vy(0) + vy(1) * ((Sqrt(2.0) - 1.0) / 2.0) + vy(2) * (1.0 - 1.0 / Sqrt(2.0));
        x(3)  := h *    wx;
        y(3)  := h *    wy;
        vx(3) := h * fx(wx, wy);
        vy(3) := h * fy(wx, wy);

        wx    := vx(0) - vx(2) / Sqrt(2.0) + vx(3) * (1.0 + 1.0 / Sqrt(2.0));
        wy    := vy(0) - vy(2) / Sqrt(2.0) + vy(3) * (1.0 + 1.0 / Sqrt(2.0));
        x(4)  := h *    wx;
        y(4)  := h *    wy;
        vx(4) := h * fx(wx, wy);
        vy(4) := h * fy(wx, wy);

        x(0)  := x(0)  + ( x(1) +  x(2) * (2.0 - Sqrt(2.0)) +  x(3) * (2.0 + Sqrt(2.0)) +  x(4)) / 6.0;
        y(0)  := y(0)  + ( y(1) +  y(2) * (2.0 - Sqrt(2.0)) +  y(3) * (2.0 + Sqrt(2.0)) +  y(4)) / 6.0;
        vx(0) := vx(0) + (vx(1) + vx(2) * (2.0 - Sqrt(2.0)) + vx(3) * (2.0 + Sqrt(2.0)) + vx(4)) / 6.0;
        vy(0) := vy(0) + (vy(1) + vy(2) * (2.0 - Sqrt(2.0)) + vy(3) * (2.0 + Sqrt(2.0)) + vy(4)) / 6.0;

        Put(t,       Fore=>1, Aft=>2, Exp=>0);
        Put(Ascii.HT);
        Put(vx(0),   Fore=>3, Aft=>5, Exp=>0);
        Put(Ascii.HT);
        Put(vy(0),   Fore=>4, Aft=>5, Exp=>0);
        Put(Ascii.HT);
        Put(x(0),    Fore=>4, Aft=>5, Exp=>0);
        Put(Ascii.HT);
        Put(y(0),    Fore=>4, Aft=>5, Exp=>0);
        New_Line;

	    i := i + 1;
	end loop;
end Ada0805;
