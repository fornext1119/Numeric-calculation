Option Explicit

Dim i
For i = 0 To 20
    Dim x:  x  = (i - 10) / 4.0
    '標準の指数関数
    Dim d1: d1 = Exp(x)
    '自作の指数関数
    Dim d2: d2 = myExp(x, 1, 1.0, 1.0, 1.0)
    '標準関数との差異
    WScript.StdOut.Write Right(Space(5)  & FormatNumber(x,        2, -1, 0, 0),  5) & " : "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d1,      10, -1, 0, 0), 13) & " - "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d2,      10, -1, 0, 0), 13) & " = "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d1 - d2, 10, -1, 0, 0), 13) & vbNewLine
Next

'自作の指数関数
Private Function myExp(ByVal x, ByVal n, ByVal numerator, ByVal denominator, ByVal y)
    denominator     = denominator * n
    numerator       = numerator   * x
    Dim a: a = numerator / denominator
    '十分な精度になったら処理を抜ける
    If (Abs(a) <= 0.00000000001) Then
        myExp = y
    Else
        myExp = y + myExp(x, n + 1, numerator, denominator, a)
    End If
End Function
