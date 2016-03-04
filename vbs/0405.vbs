'ã¸ŠKæ™p
Private Function RisingFact(x, n)
    If n <= 1 Then
        RisingFact = x
    Else
        RisingFact = x * RisingFact(x + 1, n - 1)
    End If
End Function

'10 ‚©‚ç 14 ‚Ü‚Å‚Ì ‘æ
WScript.Echo(RisingFact(10, 5))
WScript.Echo(10 * 11 * 12 * 13 * 14)
