'ŠKæ‚ğ‹‚ß‚éŠÖ”
Private Function Fact(n)
    If n <= 1 Then
        Fact = 1
    Else
        Fact = n * Fact(n - 1)
    End If
End Function

'10‚ÌŠKæ
WScript.Echo(Fact(10))
WScript.Echo(10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1)
