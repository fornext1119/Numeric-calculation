Program Pas0802(arg);
{$MODE delphi}

uses
    SysUtils, Math;

const
    // 重力加速度
    g = -9.8;
    // 空気抵抗係数
	k = -0.01;
	// 時間間隔(秒)
	h = 0.01;
	// 角度
	degree = 45;

// 空気抵抗による水平方向の減速分
function fx(vx:Double; vy:Double):Double;
begin
    result := k * Sqrt(vx * vx + vy * vy) * vx;
end;

// 重力と空気抵抗による鉛直方向の減速分
function fy(vx:Double; vy:Double):Double;
begin
    result := g + (k * Sqrt(vx * vx + vy * vy) * vy);
end;

var
	// 角度
	radian:Double;
	// 初速
	v:Double;
	// 水平方向の速度
	vx:array [0..2] of Double;
	// 鉛直方向の速度
	vy:array [0..2] of Double;
	// 経過秒数
	t:Double = 0.0;
	// 位置
	x:array [0..2] of Double;
	y:array [0..2] of Double;

	i:Integer;
begin
	// 角度
	radian := degree * PI / 180.0;
	// 初速 250 km/h -> 秒速に変換
	v := 250 * 1000 div 3600;
	// 水平方向の速度
	vx[0] := v * Cos(radian);
	// 鉛直方向の速度
	vy[0] := v * Sin(radian);
	// 位置
	x[0] := 0.0;
	y[0] := 0.0;

	// Heun法
	i := 1;
	while y[0] >= 0.0 do
	begin
	    // 経過秒数
	    t := i * h;

	    // 位置・速度
        x[1]  :=  x[0] + h *    vx[0];
        y[1]  :=  y[0] + h *    vy[0];
        vx[1] := vx[0] + h * fx(vx[0], vy[0]);
        vy[1] := vy[0] + h * fy(vx[0], vy[0]);

        x[2]  :=  x[0] + h * (  vx[0]          +    vx[1]        ) / 2;
        y[2]  :=  y[0] + h * (  vy[0]          +    vy[1]        ) / 2;
        vx[2] := vx[0] + h * (fx(vx[0], vy[0]) + fx(vx[1], vy[1])) / 2;
        vy[2] := vy[0] + h * (fy(vx[0], vy[0]) + fy(vx[1], vy[1])) / 2;

        x[0]  :=  x[2];
        y[0]  :=  y[2];
        vx[0] := vx[2];
        vy[0] := vy[2];

		writeln(format('%4.2f'#9'%8.5f'#9'%9.5f'#9'%9.5f'#9'%8.5f', [t, vx[0], vy[0], x[0], y[0]]));

	    inc(i);
	end;
end.
