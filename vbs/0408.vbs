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

'組合せ (異なる 10 個のものから 5 個取ってできる組合せの総数)
Dim n: n = 10
Dim r: r = 5
WScript.Echo(Comb(n, r))
