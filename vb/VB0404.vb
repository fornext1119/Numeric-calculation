Module VB0404
    '‰º~ŠKæ™p
    Private Function FallingFact(ByVal x As Integer, ByVal n As Integer) As Integer
        If n <= 1 Then
            Return x
        Else
            Return x * FallingFact(x - 1, n - 1)
        End If
    End Function

    Sub Main()
        '10 ‚©‚ç 6 ‚Ü‚Å‚Ì ‘æ
        Console.WriteLine(FallingFact(10, 5))
        Console.WriteLine(10 * 9 * 8 * 7 * 6)
    End Sub
End Module
