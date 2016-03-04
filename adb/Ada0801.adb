with Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics, Ada.Numerics.Long_Elementary_Functions;
use  Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics, Ada.Numerics.Long_Elementary_Functions;

procedure Ada0801 is
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
	-- ���������̑��x
	vy:array (0..1) of Long_Float;
	-- �o�ߕb��
	t:Long_Float := 0.0;
	-- �ʒu
	x:Long_Float := 0.0;
	y:Long_Float := 0.0;

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

	-- Euler�@
	i := 1;
	while y >= 0.0 loop
	    -- �o�ߕb��
	    t := Long_Float(i) * h;

	    -- �ʒu
	    x := x + h * vx(0);
	    y := y + h * vy(0);

        Put(t,       Fore=>1, Aft=>2, Exp=>0);
        Put(Ascii.HT);
        Put(vx(1),   Fore=>3, Aft=>5, Exp=>0);
        Put(Ascii.HT);
        Put(vy(1),   Fore=>4, Aft=>5, Exp=>0);
        Put(Ascii.HT);
        Put(x,       Fore=>4, Aft=>5, Exp=>0);
        Put(Ascii.HT);
        Put(y,       Fore=>3, Aft=>5, Exp=>0);
        New_Line;

	    -- ���x
	    vx(1) := vx(0) + h * fx(vx(0), vy(0));
	    vy(1) := vy(0) + h * fy(vx(0), vy(0));
	    vx(0) := vx(1);
	    vy(0) := vy(1);

	    i := i + 1;
	end loop;
end Ada0801;
