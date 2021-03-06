Option Explicit

Dim a: a = 1.0
Dim b: b = 2.0
WScript.StdOut.Write Right(Space(12) & FormatNumber(bisection(a, b), 10, -1, 0, 0), 12) & vbNewLine

Private Function bisection(ByVal a, ByVal b)
    Dim c
    Do While(True)
        '区間 (a, b) の中点 c = (a + b) / 2
        c = (a + b) / 2
        WScript.StdOut.Write Right(Space(12) & FormatNumber(c,          10, -1, 0, 0), 12) & vbTab
        WScript.StdOut.Write Right(Space(12) & FormatNumber(c - Sqr(2), 10, -1, 0, 0), 12) & vbNewLine

        Dim fc: fc = f(c)
        If Abs(fc) < 0.0000000001 Then Exit Do

        If fc < 0 Then
            'f(c) < 0 であれば, 解は区間 (c, b) の中に存在
            a = c
        Else
            'f(c) > 0 であれば, 解は区間 (a, c) の中に存在
            b = c
        End If
    Loop

    bisection = c
End Function

Private Function f(ByVal x)
    f = x * x - 2.0
End Function
