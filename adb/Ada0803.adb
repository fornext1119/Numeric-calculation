with Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics, Ada.Numerics.Long_Elementary_Functions;
use  Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics, Ada.Numerics.Long_Elementary_Functions;

procedure Ada0803 is
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
	vx:array (0..1) of Long_Float;
	wx:Long_Float;
	-- ���������̑��x
	vy:array (0..1) of Long_Float;
	wy:Long_Float;
	-- �o�ߕb��
	t:Long_Float := 0.0;
	-- �ʒu
	x:array (0..1) of Long_Float;
	y:array (0..1) of Long_Float;

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

	-- ���_�@
	i := 1;
	while y(0) >= 0.0 loop
	    -- �o�ߕb��
	    t := Long_Float(i) * h;

	    -- �ʒu�E���x
        vx(1) := h * fx(vx(0), vy(0));
        vy(1) := h * fy(vx(0), vy(0));
        
        wx    := vx(0) + vx(1) / 2.0;
        wy    := vy(0) + vy(1) / 2.0;
        vx(0) := vx(0) + h * fx(wx, wy);
        vy(0) := vy(0) + h * fy(wx, wy);
        x(0)  := x(0)  + h *    wx;
        y(0)  := y(0)  + h *    wy;

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
end Ada0803;
