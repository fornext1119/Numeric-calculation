Option Explicit

Const PI = 3.14159265359
Const a = 0
Const b = 1

Dim t(6, 6)

'ë‰å`ë•Ç≈êœï™
Dim n: n = 2
Dim i, j
For i = 1 To 6
    Dim h: h = (b - a) / n
    Dim s: s = 0
    Dim x: x = a
    For j = 1 To n - 1
        x = x + h
        s = s + f(x)
    Next
    'åãâ Çï€ë∂
    t(i,1) = h * ((f(a) + f(b)) / 2 + s)
    n = n * 2
Next

'RichardsonÇÃï‚äOñ@
n = 4
For j = 2 To 6
    For i = j To 6
        t(i,j) = t(i, j - 1) + (t(i, j - 1) - t(i - 1, j - 1)) / (n - 1)
        If i = j Then
            'åãâ Ç ÉŒ Ç∆î‰är
            WScript.StdOut.Write Right(Space(2)  & j,                                        2) & " : "
            WScript.StdOut.Write Right(Space(13) & FormatNumber(t(i,j),      10, -1, 0, 0), 13) & ", "
            WScript.StdOut.Write Right(Space(13) & FormatNumber(t(i,j) - PI, 10, -1, 0, 0), 13) & vbNewLine
        End If
    Next
    n = n * 4
Next

Private Function f(x)
    f = 4 / (1 + x * x)
End Function
