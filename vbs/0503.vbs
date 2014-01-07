Option Explicit

Const PI = 3.14159265359
Dim i
For i = 0 To 180 Step 15
    If (i Mod 180 <> 0) Then
        Dim degree: degree = i - 90
        Dim radian: radian = degree * PI / 180.0
        Dim x2:     x2     = radian * radian
        '自作の正接関数
        Dim d1: d1         = myTan(radian, x2, 15, 0.0) '15:必要な精度が得られる十分大きな奇数
        '標準の正接関数
        Dim d2: d2         = Tan(radian)
        '標準関数との差異
        WScript.StdOut.Write Right(Space(3)  & degree,                               3) & " : "
        WScript.StdOut.Write Right(Space(13) & FormatNumber(d1,      10, -1, 0, 0), 13) & " - "
        WScript.StdOut.Write Right(Space(13) & FormatNumber(d2,      10, -1, 0, 0), 13) & " = "
        WScript.StdOut.Write Right(Space(13) & FormatNumber(d1 - d2, 10, -1, 0, 0), 13) & vbNewLine
    End If
Next

'自作の正接関数
Private Function myTan(ByVal x, ByVal x2, ByVal n, ByVal t)
    t = x2 / (n - t)
    n = n - 2
    If (n <= 1) Then
        myTan = x / (1 - t)
    Else
        myTan = myTan(x, x2, n, t)
    End If
End Function
