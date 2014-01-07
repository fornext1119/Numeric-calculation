Option Explicit
' ‰€:a, Œö·:a ‚Å ãŒÀ:lim ‚Ì”—ñ‚Ì‘˜a‚ğ•Ô‚·ŠÖ”
Private Function sn(a, lim)
    Dim n: n = lim \ a   ' €”:n  =  ãŒÀ:lim / Œö·:a
    Dim l: l = n * a     ' ––€:l  =  €”:n   * Œö·:a
    sn = (a + l) * n \ 2 ' ‘˜a:sn = (‰€:a   + ––€:l) * €”:n / 2
End Function

' 3 ‚Ì”{”‚Ì‡Œv
WScript.Echo sn(3, 999)
