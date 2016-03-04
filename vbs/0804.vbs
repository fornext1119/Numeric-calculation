Option Explicit

Private Const PI = 3.14159265359

'èdóÕâ¡ë¨ìx
Private Const g = -9.8
'ãÛãCíÔçRåWêî
Private Const k = -0.01
'éûä‘ä‘äu(ïb)
Private Const h = 0.01

'äpìx
Private Const degree = 45
Private radian: radian = degree * PI / 180.0
'èâë¨ 250 km/h -> ïbë¨Ç…ïœä∑
Private v: v = 250 * 1000 \ 3600
'êÖïΩï˚å¸ÇÃë¨ìx
Private vx(): ReDim vx(5)
vx(0) = v * Cos(radian)
'âîíºï˚å¸ÇÃë¨ìx
Private vy(): ReDim vy(5)
vy(0) = v * Sin(radian)
'åoâﬂïbêî
Private t: t = 0.0
'à íu
Private x(): ReDim x(5)
x(0) = 0.0
Private y(): ReDim y(5)
y(0) = 0.0

'ãÛãCíÔçRÇ…ÇÊÇÈêÖïΩï˚å¸ÇÃå∏ë¨ï™
Private Function fx(ByVal vx, ByVal vy)
    fx = k * Sqr(vx * vx + vy * vy) * vx
End Function

'èdóÕÇ∆ãÛãCíÔçRÇ…ÇÊÇÈâîíºï˚å¸ÇÃå∏ë¨ï™
Private Function fy(ByVal vx, ByVal vy)
    fy = g + (k * Sqr(vx * vx + vy * vy) * vy)
End Function

'Runge-Kuttañ@
Dim i: i = 1
Do While (y(0) >= 0.0)
    'åoâﬂïbêî
    t = i * h

    'à íuÅEë¨ìx
    x(1)  = h *    vx(0)
    y(1)  = h *    vy(0)
    vx(1) = h * fx(vx(0), vy(0))
    vy(1) = h * fy(vx(0), vy(0))
    
    Dim wx: wx = vx(0) + vx(1) / 2.0
    Dim wy: wy = vy(0) + vy(1) / 2.0
    x(2)  = h *    wx
    y(2)  = h *    wy
    vx(2) = h * fx(wx, wy)
    vy(2) = h * fy(wx, wy)

    wx    = vx(0) + vx(2) / 2
    wy    = vy(0) + vy(2) / 2
    x(3)  = h *    wx
    y(3)  = h *    wy
    vx(3) = h * fx(wx, wy)
    vy(3) = h * fy(wx, wy)

    wx    = vx(0) + vx(3)
    wy    = vy(0) + vy(3)
    x(4)  = h *    wx
    y(4)  = h *    wy
    vx(4) = h * fx(wx, wy)
    vy(4) = h * fy(wx, wy)

    x(0)  = x(0)  + ( x(1) +  x(2) * 2 +  x(3) * 2 +  x(4)) / 6
    y(0)  = y(0)  + ( y(1) +  y(2) * 2 +  y(3) * 2 +  y(4)) / 6
    vx(0) = vx(0) + (vx(1) + vx(2) * 2 + vx(3) * 2 + vx(4)) / 6
    vy(0) = vy(0) + (vy(1) + vy(2) * 2 + vy(3) * 2 + vy(4)) / 6

    WScript.StdOut.Write     Right(Space(4) & FormatNumber(t,     2, -1, 0, 0), 4) & vbTab
    WScript.StdOut.Write     Right(Space(8) & FormatNumber(vx(0), 5, -1, 0, 0), 8) & vbTab
    WScript.StdOut.Write     Right(Space(9) & FormatNumber(vy(0), 5, -1, 0, 0), 9) & vbTab
    WScript.StdOut.Write     Right(Space(9) & FormatNumber(x(0),  5, -1, 0, 0), 9) & vbTab
    WScript.StdOut.WriteLine Right(Space(9) & FormatNumber(y(0),  5, -1, 0, 0), 9)

    i = i + 1
Loop
