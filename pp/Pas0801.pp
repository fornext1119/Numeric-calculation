Program Pas0801(arg);
{$MODE delphi}

uses
    SysUtils, Math;

const
    // èdóÕâ¡ë¨ìx
    g = -9.8;
	// ãÛãCíÔçRåWêî
	k = -0.01;
	// éûä‘ä‘äu(ïb)
	h = 0.01;
	// äpìx
	degree = 45;

// ãÛãCíÔçRÇ…ÇÊÇÈêÖïΩï˚å¸ÇÃå∏ë¨ï™
function fx(vx:Double; vy:Double):Double;
begin
    result := k * Sqrt(vx * vx + vy * vy) * vx;
end;

// èdóÕÇ∆ãÛãCíÔçRÇ…ÇÊÇÈâîíºï˚å¸ÇÃå∏ë¨ï™
function fy(vx:Double; vy:Double):Double;
begin
    result := g + (k * Sqrt(vx * vx + vy * vy) * vy);
end;

var
	// äpìx
	radian:Double;
	// èâë¨
	v:Double;
	// êÖïΩï˚å¸ÇÃë¨ìx
	vx:array [0..1] of Double;
	// âîíºï˚å¸ÇÃë¨ìx
	vy:array [0..1] of Double;
	// åoâﬂïbêî
	t:Double = 0.0;
	// à íu
	x:Double = 0.0;
	y:Double = 0.0;

	i:Integer;
begin
	// äpìx
	radian := degree * PI / 180.0;
	// èâë¨ 250 km/h -> ïbë¨Ç…ïœä∑
	v := 250 * 1000 div 3600;
	// êÖïΩï˚å¸ÇÃë¨ìx
	vx[0] := v * Cos(radian);
	// âîíºï˚å¸ÇÃë¨ìx
	vy[0] := v * Sin(radian);

	// Eulerñ@
	i := 1;
	while y >= 0.0 do
	begin
	    // åoâﬂïbêî
	    t := i * h;

	    // à íu
	    x := x + h * vx[0];
	    y := y + h * vy[0];

		writeln(format('%4.2f'#9'%8.5f'#9'%9.5f'#9'%9.5f'#9'%8.5f', [t, vx[0], vy[0], x, y]));

	    // ë¨ìx
	    vx[1] := vx[0] + h * fx(vx[0], vy[0]);
	    vy[1] := vy[0] + h * fy(vx[0], vy[0]);
	    vx[0] := vx[1];
	    vy[0] := vy[1];

	    inc(i);
	end;
end.
