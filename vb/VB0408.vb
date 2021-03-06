Module VB040101

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
        '組合せ (異なる 10 個のものから 5 個取ってできる組合せの総数)
        Dim n As Integer = 10
        Dim r As Integer = 5
        Console.WriteLine(Comb(n, r))
    End Sub
End Module
