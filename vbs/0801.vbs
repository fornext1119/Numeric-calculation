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
Private vx(): ReDim vx(1)
vx(0) = v * Cos(radian)
'鉛直方向の速度
Private vy(): ReDim vy(1)
vy(0) = v * Sin(radian)
'経過秒数
Private t: t = 0.0
'位置
Private x: x = 0.0
Private y: y = 0.0

'空気抵抗による水平方向の減速分
Private Function fx(ByVal vx, ByVal vy)
    fx = k * Sqr(vx * vx + vy * vy) * vx
End Function

'重力と空気抵抗による鉛直方向の減速分
Private Function fy(ByVal vx, ByVal vy)
    fy = g + (k * Sqr(vx * vx + vy * vy) * vy)
End Function

'Euler法
Dim i: i = 1
Do While (y >= 0.0)
    '経過秒数
    t = i * h

    '位置
    x = x + h * vx(0)
    y = y + h * vy(0)

    WScript.StdOut.Write     Right(Space(4) & FormatNumber(t,     2, -1, 0, 0), 4) & vbTab
    WScript.StdOut.Write     Right(Space(8) & FormatNumber(vx(0), 5, -1, 0, 0), 8) & vbTab
    WScript.StdOut.Write     Right(Space(9) & FormatNumber(vy(0), 5, -1, 0, 0), 9) & vbTab
    WScript.StdOut.Write     Right(Space(9) & FormatNumber(x,     5, -1, 0, 0), 9) & vbTab
    WScript.StdOut.WriteLine Right(Space(8) & FormatNumber(y,     5, -1, 0, 0), 8)

    '速度
    vx(1) = vx(0) + h * fx(vx(0), vy(0))
    vy(1) = vy(0) + h * fy(vx(0), vy(0))
    vx(0) = vx(1)
    vy(0) = vy(1)

    i = i + 1
Loop
