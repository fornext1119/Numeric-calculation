Option Explicit

'‰€ 5, Œö· 3, €” 10 ‚Ì”—ñ‚ÌÏ‚ğ•\¦‚·‚é
WScript.Echo product(5, 3, 10)

Private Function product(m, d, n)
    If n = 0 Then
        product = 1
    Else
        product = m * product(m + d, d, n - 1)
    End If
End Function
