'組合せ
Private Function Comb(n, r)
    If (r = 0) Or (r = n) Then
        Comb = 1
    ElseIf r = 1 Then
        Comb = n
    Else
        Comb = Comb(n - 1, r - 1) + Comb(n - 1, r)
    End If
End Function

'重複組合せ (異なる 10 個のものから重複を許して 5 個とる組合せの総数)
Dim n: n = 10
Dim r: r = 5
WScript.Echo(Comb(n + r - 1, r))
