with Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics, Ada.Numerics.Long_Elementary_Functions;
use  Text_IO, Ada.Long_Float_Text_IO, Ada.Numerics, Ada.Numerics.Long_Elementary_Functions;

procedure Ada0801 is
    -- 重力加速度
    g : Constant Long_Float := -9.8;
    -- 空気抵抗係数
    k : Constant Long_Float := -0.01;
	-- 時間間隔(秒)
	h : Constant Long_Float := 0.01;
	-- 角度
	degree : Constant Long_Float := 45.0;

	-- 空気抵抗による水平方向の減速分
	function fx(vx:Long_Float; vy:Long_Float) return Long_Float is
	begin
	    return k * Sqrt(vx * vx + vy * vy) * vx;
	end fx;

	-- 重力と空気抵抗による鉛直方向の減速分
	function fy(vx:Long_Float; vy:Long_Float) return Long_Float is
	begin
	    return g + (k * Sqrt(vx * vx + vy * vy) * vy);
	end fy;

	-- 角度
	radian:Long_Float;
	-- 初速
	v:Long_Float;
	-- 水平方向の速度
	vx:array (0..1) of Long_Float;
	-- 鉛直方向の速度
	vy:array (0..1) of Long_Float;
	-- 経過秒数
	t:Long_Float := 0.0;
	-- 位置
	x:Long_Float := 0.0;
	y:Long_Float := 0.0;

	i:Integer;
begin
	-- 角度
	radian := degree * Pi / 180.0;
	-- 初速 250 km/h -> 秒速に変換
	v := Long_Float(250 * 1000 / 3600);
	-- 水平方向の速度
	vx(0) := v * Cos(radian);
	-- 鉛直方向の速度
	vy(0) := v * Sin(radian);

	-- Euler法
	i := 1;
	while y >= 0.0 loop
	    -- 経過秒数
	    t := Long_Float(i) * h;

	    -- 位置
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

	    -- 速度
	    vx(1) := vx(0) + h * fx(vx(0), vy(0));
	    vy(1) := vy(0) + h * fy(vx(0), vy(0));
	    vx(0) := vx(1);
	    vy(0) := vy(1);

	    i := i + 1;
	end loop;
end Ada0801;
