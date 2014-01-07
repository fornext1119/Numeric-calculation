Module VB0403
    'ŠKæ‚ğ‹‚ß‚éŠÖ”
    Private Function Fact(ByVal n As Integer) As Integer
        If n <= 1 Then
            Return 1
        Else
            Return n * Fact(n - 1)
        End If
    End Function

    Sub Main()
        '10‚ÌŠKæ
        Console.WriteLine(Fact(10))
        Console.WriteLine(10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1)
    End Sub
End Module
