Option Explicit

Const PI = 3.14159265359
Const a = 0
Const b = 1

'ë‰å`ë•Ç≈êœï™
Dim n: n = 2
Dim i, j
For j = 1 To 10
    Dim h: h = (b - a) / n
    Dim s: s = 0
    Dim x: x = a
    For i = 1 To n - 1
        x = x + h
        s = s + f(x)
    Next
    s = h * ((f(a) + f(b)) / 2 + s)
    n = n * 2

    'åãâ Ç ÉŒ Ç∆î‰är
    WScript.StdOut.Write Right(Space(2)  & j,                                   2) & " : "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(s,      10, -1, 0, 0), 13) & ", "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(s - PI, 10, -1, 0, 0), 13) & vbNewLine
Next

Private Function f(x)
    f = 4 / (1 + x * x)
End Function
