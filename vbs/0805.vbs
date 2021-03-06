Option Explicit

Private Const PI = 3.14159265359

'重力加速度
Private Const g = -9.8
'空気抵抗係数
Private Const k = -0.01
'時間間隔(秒)
Private Const h = 0.01

'角度
Private Const degree = 45
Private radian: radian = degree * PI / 180.0
'初速 250 km/h -> 秒速に変換
Private v: v = 250 * 1000 \ 3600
'水平方向の速度
Private vx(): ReDim vx(5)
vx(0) = v * Cos(radian)
'鉛直方向の速度
Private vy(): ReDim vy(5)
vy(0) = v * Sin(radian)
'経過秒数
Private t: t = 0.0
'位置
Private x(): ReDim x(5)
x(0) = 0.0
Private y(): ReDim y(5)
y(0) = 0.0

'空気抵抗による水平方向の減速分
Private Function fx(ByVal vx, ByVal vy)
    fx = k * Sqr(vx * vx + vy * vy) * vx
End Function

'重力と空気抵抗による鉛直方向の減速分
Private Function fy(ByVal vx, ByVal vy)
    fy = g + (k * Sqr(vx * vx + vy * vy) * vy)
End Function

'Runge-Kutta-Gill法
Dim i: i = 1
Do While (y(0) >= 0.0)
    '経過秒数
    t = i * h

    '位置・速度
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

    wx    = vx(0) + vx(1) * ((Sqr(2.0) - 1) / 2) + vx(2) * (1 - 1 / Sqr(2.0))
    wy    = vy(0) + vy(1) * ((Sqr(2.0) - 1) / 2) + vy(2) * (1 - 1 / Sqr(2.0))
    x(3)  = h *    wx
    y(3)  = h *    wy
    vx(3) = h * fx(wx, wy)
    vy(3) = h * fy(wx, wy)

    wx    = vx(0) - vx(2) / Sqr(2.0) + vx(3) * (1 + 1 / Sqr(2.0))
    wy    = vy(0) - vy(2) / Sqr(2.0) + vy(3) * (1 + 1 / Sqr(2.0))
    x(4)  = h *    wx
    y(4)  = h *    wy
    vx(4) = h * fx(wx, wy)
    vy(4) = h * fy(wx, wy)

    x(0)  = x(0)  + ( x(1) +  x(2) * (2 - Sqr(2.0)) +  x(3) * (2 + Sqr(2.0)) +  x(4)) / 6
    y(0)  = y(0)  + ( y(1) +  y(2) * (2 - Sqr(2.0)) +  y(3) * (2 + Sqr(2.0)) +  y(4)) / 6
    vx(0) = vx(0) + (vx(1) + vx(2) * (2 - Sqr(2.0)) + vx(3) * (2 + Sqr(2.0)) + vx(4)) / 6
    vy(0) = vy(0) + (vy(1) + vy(2) * (2 - Sqr(2.0)) + vy(3) * (2 + Sqr(2.0)) + vy(4)) / 6

    WScript.StdOut.Write     Right(Space(4) & FormatNumber(t,     2, -1, 0, 0), 4) & vbTab
    WScript.StdOut.Write     Right(Space(8) & FormatNumber(vx(0), 5, -1, 0, 0), 8) & vbTab
    WScript.StdOut.Write     Right(Space(9) & FormatNumber(vy(0), 5, -1, 0, 0), 9) & vbTab
    WScript.StdOut.Write     Right(Space(9) & FormatNumber(x(0),  5, -1, 0, 0), 9) & vbTab
    WScript.StdOut.WriteLine Right(Space(9) & FormatNumber(y(0),  5, -1, 0, 0), 9)

    i = i + 1
Loop
