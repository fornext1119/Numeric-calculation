with Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics, Ada.Numerics.Long_Elementary_Functions;
use  Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics, Ada.Numerics.Long_Elementary_Functions;

procedure Ada0802 is
    -- d—Í‰Á‘¬“x
    g : Constant Long_Float := -9.8;
    -- ‹ó‹C’ïRŒW”
    k : Constant Long_Float := -0.01;
    -- ŽžŠÔŠÔŠu(•b)
	h : Constant Long_Float := 0.01;
	-- Šp“x
	degree : Constant Long_Float := 45.0;

	-- ‹ó‹C’ïR‚É‚æ‚é…•½•ûŒü‚ÌŒ¸‘¬•ª
	function fx(vx:Long_Float; vy:Long_Float) return Long_Float is
	begin
	    return k * Sqrt(vx * vx + vy * vy) * vx;
	end fx;

	-- d—Í‚Æ‹ó‹C’ïR‚É‚æ‚é‰”’¼•ûŒü‚ÌŒ¸‘¬•ª
	function fy(vx:Long_Float; vy:Long_Float) return Long_Float is
	begin
	    return g + (k * Sqrt(vx * vx + vy * vy) * vy);
	end fy;

	-- Šp“x
	radian:Long_Float;
	-- ‰‘¬
	v:Long_Float;
	-- …•½•ûŒü‚Ì‘¬“x
	vx:array (0..2) of Long_Float;
	-- ‰”’¼•ûŒü‚Ì‘¬“x
	vy:array (0..2) of Long_Float;
	-- Œo‰ß•b”
	t:Long_Float := 0.0;
	-- ˆÊ’u
	x:array (0..2) of Long_Float;
	y:array (0..2) of Long_Float;

	i:Integer;
begin
	-- Šp“x
	radian := degree * Pi / 180.0;
	-- ‰‘¬ 250 km/h -> •b‘¬‚É•ÏŠ·
	v := Long_Float(250 * 1000 / 3600);
	-- …•½•ûŒü‚Ì‘¬“x
	vx(0) := v * Cos(radian);
	-- ‰”’¼•ûŒü‚Ì‘¬“x
	vy(0) := v * Sin(radian);
	-- ˆÊ’u
	x(0) := 0.0;
	y(0) := 0.0;

	-- Heun–@
	i := 1;
	while y(0) >= 0.0 loop
	    -- Œo‰ß•b”
	    t := Long_Float(i) * h;

	    -- ˆÊ’uE‘¬“x
        x(1)  :=  x(0) + h *    vx(0);
        y(1)  :=  y(0) + h *    vy(0);
        vx(1) := vx(0) + h * fx(vx(0), vy(0));
        vy(1) := vy(0) + h * fy(vx(0), vy(0));

        x(2)  :=  x(0) + h * (  vx(0)          +    vx(1)        ) / 2.0;
        y(2)  :=  y(0) + h * (  vy(0)          +    vy(1)        ) / 2.0;
        vx(2) := vx(0) + h * (fx(vx(0), vy(0)) + fx(vx(1), vy(1))) / 2.0;
        vy(2) := vy(0) + h * (fy(vx(0), vy(0)) + fy(vx(1), vy(1))) / 2.0;

        x(0)  :=  x(2);
        y(0)  :=  y(2);
        vx(0) := vx(2);
        vy(0) := vy(2);

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
end Ada0802;
