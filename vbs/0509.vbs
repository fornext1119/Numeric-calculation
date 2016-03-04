Option Explicit

Dim i
For i = 0 To 20
    Dim x:  x  = i - 10
    '自作の双曲線余弦関数
    Dim d1: d1 = myCosh(x, 1, 1.0, 1.0, 1.0)
    '標準の双曲線余弦関数はない
    Dim d2: d2 = (Exp(x) + Exp(-x)) / 2
    '標準関数との差異
    WScript.StdOut.Write Right(Space(3)  & x,                                    3) & " : "
    WScript.StdOut.Write Right(Space(17) & FormatNumber(d1,      10, -1, 0, 0), 17) & " - "
    WScript.StdOut.Write Right(Space(17) & FormatNumber(d2,      10, -1, 0, 0), 17) & " = "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d1 - d2, 10, -1, 0, 0), 13) & vbNewLine
Next

'自作の双曲線余弦関数
Private Function myCosh(ByVal x, ByVal n, ByVal numerator, ByVal denominator, ByVal y)
    Dim m: m    = 2 * n
    denominator = denominator * m * (m - 1) 
    numerator   = numerator   * x * x
    Dim a: a    = numerator / denominator
    '十分な精度になったら処理を抜ける
    If (Abs(a) <= 0.00000000001) Then
        myCosh = y
    Else
        myCosh = y + myCosh(x, n + 1, numerator, denominator, a)
    End If
End Function
