'‘g‡‚¹
Private Function Comb(n, r)
    If (r = 0) Or (r = n) Then
        Comb = 1
    ElseIf r = 1 Then
        Comb = n
    Else
        Comb = Comb(n - 1, r - 1) + Comb(n - 1, r)
    End If
End Function

'‘g‡‚¹ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‘g‡‚¹‚Ì‘”)
Dim n: n = 10
Dim r: r = 5
WScript.Echo(Comb(n, r))
