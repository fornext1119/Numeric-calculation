Option Explicit

Const PI = 3.14159265359
Const a = 0
Const b = 1

'Simpsonë•Ç≈êœï™
Dim n: n = 2
Dim i, j
For j = 1 To 5
    Dim h:  h  = (b - a) / n
    Dim s2: s2 = 0
    Dim s4: s4 = 0
    Dim x:  x  = a + h
    For i = 1 To n \ 2
        s4 = s4 + f(x)
        x  = x  + h
        s2 = s2 + f(x)
        x  = x  + h
    Next
    s2 = (s2 - f(b)) * 2 + f(a) + f(b)
    s4 = s4 * 4
    Dim s: s = (s2 + s4) * h / 3
    n = n * 2

    'åãâ Ç ÉŒ Ç∆î‰är
    WScript.StdOut.Write Right(Space(2)  & j,                                   2) & " : "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(s,      10, -1, 0, 0), 13) & ", "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(s - PI, 10, -1, 0, 0), 13) & vbNewLine
Next

Private Function f(x)
    f = 4 / (1 + x * x)
End Function
