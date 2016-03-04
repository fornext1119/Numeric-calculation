Option Explicit

Dim a: a = 5  '‰€ 5
Dim d: d = 3  'Œö· 3
Dim n: n = 10 '€” 10
Dim p: p = 1  'Ï
Dim m

Dim i
For i = 1 To n
    m = a + (d * (i - 1))
    WScript.StdOut.Write m & " * " & p & " = "

    p = p * m
    WScript.Echo p
Next
