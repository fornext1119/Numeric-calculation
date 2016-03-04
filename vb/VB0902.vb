Option Explicit

Module VB0902
    Public Sub Main()
        Dim a As Double = 1.0
        Dim b As Double = 2.0
        Console.WriteLine(string.Format("{0,12:F10}", falseposition(a, b)))
    End Sub

	Private Function falseposition(ByVal a As Double, ByVal b As Double)
        Dim c As Double
        Do While(True)
		    '“_ (a,f(a)) ‚Æ “_ (b,f(b)) ‚ğŒ‹‚Ô’¼ü‚Æ x²‚ÌŒğ“_
		    c = (a * f(b) - b * f(a)) / (f(b) - f(a))
            Console.WriteLine(String.Format("{0,12:F10}{2}{1,13:F10}", c, c - Math.Sqrt(2), vbTab))

            Dim fc As Double = f(c)
            If Math.Abs(fc) < 0.0000000001 Then Exit Do
          
            If fc < 0 Then
                'f(c) < 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (c, b) ‚Ì’†‚É‘¶İ
                a = c
            Else
                'f(c) > 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (a, c) ‚Ì’†‚É‘¶İ
                b = c
            End If
        Loop

	    Return c
    End Function

    Private Function f(ByVal x As Double) As Double
        Return x * x - 2.0
    End Function
End Module
