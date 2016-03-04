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
Private vx(): ReDim vx(2)
vx(0) = v * Cos(radian)
'âîíºï˚å¸ÇÃë¨ìx
Private vy(): ReDim vy(2)
vy(0) = v * Sin(radian)
'åoâﬂïbêî
Private t: t = 0.0
'à íu
Private x(): ReDim x(2)
x(0) = 0.0
Private y(): ReDim y(2)
y(0) = 0.0

'ãÛãCíÔçRÇ…ÇÊÇÈêÖïΩï˚å¸ÇÃå∏ë¨ï™
Private Function fx(ByVal vx, ByVal vy)
    fx = k * Sqr(vx * vx + vy * vy) * vx
End Function

'èdóÕÇ∆ãÛãCíÔçRÇ…ÇÊÇÈâîíºï˚å¸ÇÃå∏ë¨ï™
Private Function fy(ByVal vx, ByVal vy)
    fy = g + (k * Sqr(vx * vx + vy * vy) * vy)
End Function

'Heunñ@
Dim i: i = 1
Do While (y(0) >= 0.0)
    'åoâﬂïbêî
    t = i * h

    'à íuÅEë¨ìx
    x(1)  =  x(0) + h *    vx(0)
    y(1)  =  y(0) + h *    vy(0)
    vx(1) = vx(0) + h * fx(vx(0), vy(0))
    vy(1) = vy(0) + h * fy(vx(0), vy(0))

    x(2)  =  x(0) + h * (  vx(0)          +    vx(1)        ) / 2
    y(2)  =  y(0) + h * (  vy(0)          +    vy(1)        ) / 2
    vx(2) = vx(0) + h * (fx(vx(0), vy(0)) + fx(vx(1), vy(1))) / 2
    vy(2) = vy(0) + h * (fy(vx(0), vy(0)) + fy(vx(1), vy(1))) / 2

    x(0)  =  x(2)
    y(0)  =  y(2)
    vx(0) = vx(2)
    vy(0) = vy(2)

    WScript.StdOut.Write     Right(Space(4) & FormatNumber(t,     2, -1, 0, 0), 4) & vbTab
    WScript.StdOut.Write     Right(Space(8) & FormatNumber(vx(0), 5, -1, 0, 0), 8) & vbTab
    WScript.StdOut.Write     Right(Space(9) & FormatNumber(vy(0), 5, -1, 0, 0), 9) & vbTab
    WScript.StdOut.Write     Right(Space(9) & FormatNumber(x(0),  5, -1, 0, 0), 9) & vbTab
    WScript.StdOut.WriteLine Right(Space(8) & FormatNumber(y(0),  5, -1, 0, 0), 8)

    i = i + 1
Loop
