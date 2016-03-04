Program Pas0803(arg);
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
	wx:Double;
	// âîíºï˚å¸ÇÃë¨ìx
	vy:array [0..1] of Double;
	wy:Double;
	// åoâﬂïbêî
	t:Double = 0.0;
	// à íu
	x:array [0..1] of Double;
	y:array [0..1] of Double;

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
	// à íu
	x[0] := 0.0;
	y[0] := 0.0;

	// íÜì_ñ@
	i := 1;
	while y[0] >= 0.0 do
	begin
	    // åoâﬂïbêî
	    t := i * h;

	    // à íuÅEë¨ìx
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
