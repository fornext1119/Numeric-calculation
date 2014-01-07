Module VB0409
    '組合せ
    Private Function Comb(ByVal n As Integer, ByVal r As Integer) As Integer
        If (r = 0) OrElse (r = n) Then
            Return 1
        ElseIf r = 1 Then
            Return n
        Else
            Return Comb(n - 1, r - 1) + Comb(n - 1, r)
        End If
    End Function

    Sub Main()
        '重複組合せ (異なる 10 個のものから重複を許して 5 個とる組合せの総数)
        Dim n As Integer = 10
        Dim r As Integer = 5
        Console.WriteLine(Comb(n + r - 1, r))
    End Sub
End Module
