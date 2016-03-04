Option Explicit

Dim i
For i = 0 To 20
    Dim x:  x  = (i - 10) / 4.0
    '標準の指数関数
    Dim d1: d1 = Exp(x)
    '自作の指数関数
    Dim x2: x2 = x * x
    Dim d2: d2 = myExp(x, x2, 30, 0.0) '30:必要な精度が得られるよう, 6から始めて4ずつ増加させる
    '標準関数との差異
    WScript.StdOut.Write Right(Space(5)  & FormatNumber(x,        2, -1, 0, 0),  5) & " : "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d1,      10, -1, 0, 0), 13) & " - "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d2,      10, -1, 0, 0), 13) & " = "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d1 - d2, 10, -1, 0, 0), 13) & vbNewLine
Next

'自作の指数関数
Private Function myExp(ByVal x, ByVal x2, ByVal n, ByVal t)
    t = x2 / (n + t)
    n = n - 4  

    If (n < 6) Then
        myExp = 1 + ((2 * x) / (2 - x + t))
    Else
        myExp = myExp(x, x2, n, t)
    End If
End Function
