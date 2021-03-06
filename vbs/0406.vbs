'階乗
Private Function Fact(n)
    If n <= 1 Then
        Fact = 1
    Else
        Fact = n * Fact(n - 1)
    End If
End Function

'下降階乗冪
Private Function FallingFact(x, n)
    If n <= 1 Then
        FallingFact = x
    Else
        FallingFact = x * FallingFact(x - 1, n - 1)
    End If
End Function

'順列 (異なる 10 個のものから 5 個取ってできる順列の総数)
Dim n: n = 10
Dim r: r = 5
WScript.Echo(Fact(n) / Fact(n - r))
WScript.Echo(FallingFact(n, r))
