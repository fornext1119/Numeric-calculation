Option Explicit

Dim i
For i = 1 To 20
    Dim x:  x  = i / 5.0
    '標準の対数関数
    Dim d1: d1 = Log(x)
    '自作の対数関数
    Dim d2: d2 = myLog(x - 1, 27, 0.0) '27:必要な精度が得られる十分大きな奇数
    '標準関数との差異
    WScript.StdOut.Write Right(Space(5)  & FormatNumber(x,        2, -1, 0, 0),  5) & " : "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d1,      10, -1, 0, 0), 13) & " - "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d2,      10, -1, 0, 0), 13) & " = "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d1 - d2, 10, -1, 0, 0), 13) & vbNewLine
Next

'自作の対数関数
Private Function myLog(ByVal x, ByVal n, ByVal t)
    Dim n2: n2 = n
    Dim x2: x2 = x
    If (n > 3) Then
        If (n Mod 2 = 0) Then
            n2 = 2
        End If
        x2 = x * (n \ 2)
    End If
    t = x2 / (n2 + t)

    If (n <= 2) Then
        myLog = x / (1 + t)
    Else
        myLog = myLog(x, n - 1, t)
    End If
End Function
