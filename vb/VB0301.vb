Module VB0301
    Public Sub Main()
        ' 3 ‚Ì”{”‚Ì‡Œv
        Console.WriteLine( sn(3, 999) )
    End Sub

    ' ‰€:a, Œö·:a ‚Å, ãŒÀ:lim ‚Ì”—ñ‚Ì‘˜a‚ğ•Ô‚·ŠÖ”
    Private Function sn(ByVal a As Integer, ByVal lim As Integer) As Integer
        Dim n As Integer = lim \ a   ' €”:n  =  ãŒÀ:lim / Œö·:a
        Dim l As Integer = n * a     ' ––€:l  =  €”:n   * Œö·:a
        Return (a + l) * n \ 2       ' ‘˜a:sn = (‰€:a   + ––€:l) * €”:n / 2
    End Function
End Module
