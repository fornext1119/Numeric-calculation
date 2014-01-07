Option Explicit

Dim i
For i = 1 To 20
    Dim x:  x  = i / 5.0
    '標準の対数関数
    Dim d1: d1 = Log(x)
    '自作の対数関数
    Dim x2: x2 = (x - 1) / (x + 1)
    Dim d2: d2 = 2 * myLog(x2, x2, 1.0, x2)
    '標準関数との差異
    WScript.StdOut.Write Right(Space(5)  & FormatNumber(x,        2, -1, 0, 0),  5) & " : "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d1,      10, -1, 0, 0), 13) & " - "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d2,      10, -1, 0, 0), 13) & " = "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d1 - d2, 10, -1, 0, 0), 13) & vbNewLine
Next

'自作の対数関数
Private Function myLog(ByVal x2, ByVal numerator, ByVal denominator, ByVal y)
    denominator = denominator + 2
    numerator   = numerator   * x2 * x2
    Dim a: a    = numerator / denominator
    '十分な精度になったら処理を抜ける
    If (Abs(a) <= 0.00000000001) Then
        myLog = y
    Else
        myLog = y + myLog(x2, numerator, denominator, a)
    End If
End Function
