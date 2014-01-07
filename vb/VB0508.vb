Module VB0508
    Public Sub Main()
        For i As Integer = 0 To 20
            Dim x As Integer = i - 10
            '©ì‚Ì‘o‹Èü³Œ·ŠÖ”
            Dim d1 As Double = mySinh(x, 1, x, 1.0, x)
            '•W€‚Ì‘o‹Èü³Œ·ŠÖ”
            Dim d2 As Double = Math.Sinh(x)
            '•W€ŠÖ”‚Æ‚Ì·ˆÙ
            Console.WriteLine(String.Format("{0,3:D} : {1,17:F10} - {2,17:F10} = {3,13:F10}", x, d1, d2, d1 - d2))
        Next
    End Sub

    '©ì‚Ì‘o‹Èü³Œ·ŠÖ”
    Private Function mySinh(ByVal x As Double, ByVal n As Integer, ByVal numerator As Double, ByVal denominator As Double, ByVal y As Double) As Double
        Dim m As Integer = 2 * n
        denominator      = denominator * (m + 1) * m
        numerator        = numerator   * x * x
        Dim a As Double  = numerator / denominator
        '\•ª‚È¸“x‚É‚È‚Á‚½‚çˆ—‚ğ”²‚¯‚é
        If (Math.Abs(a) <= 0.00000000001) Then
            Return y
        Else
            Return y + mySinh(x, n + 1, numerator, denominator, a)
        End If
    End Function
End Module
