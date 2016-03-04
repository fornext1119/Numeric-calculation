Module VB0406
    'ŠKæ
    Private Function Fact(ByVal n As Integer) As Integer
        If n <= 1 Then
            Return 1
        Else
            Return n * Fact(n - 1)
        End If
    End Function

    '‰º~ŠKæ™p
    Private Function FallingFact(ByVal x As Integer, ByVal n As Integer) As Integer
        If n <= 1 Then
            Return x
        Else
            Return x * FallingFact(x - 1, n - 1)
        End If
    End Function

    Sub Main()
        '‡—ñ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‡—ñ‚Ì‘”)
        Dim n As Integer = 10
        Dim r As Integer = 5
        Console.WriteLine(Fact(n) / Fact(n - r))
        Console.WriteLine(FallingFact(n, r))
    End Sub
End Module
