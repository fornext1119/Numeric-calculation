Option Explicit

Dim a: a = 1.0
Dim b: b = 2.0
WScript.StdOut.Write Right(Space(12) & FormatNumber(falseposition(a, b), 10, -1, 0, 0), 12) & vbNewLine

Private Function falseposition(ByVal a, ByVal b)
    Dim c
	Do While(True)
	    '“_ (a,f(a)) ‚Æ “_ (b,f(b)) ‚ğŒ‹‚Ô’¼ü‚Æ x²‚ÌŒğ“_
	    c = (a * f(b) - b * f(a)) / (f(b) - f(a))
	    WScript.StdOut.Write Right(Space(12) & FormatNumber(c,          10, -1, 0, 0), 12) & vbTab
	    WScript.StdOut.Write Right(Space(12) & FormatNumber(c - Sqr(2), 10, -1, 0, 0), 12) & vbNewLine

	    Dim fc: fc = f(c)
	    If Abs(fc) < 0.0000000001 Then Exit Do

	    If fc < 0 Then
	        'f(c) < 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (c, b) ‚Ì’†‚É‘¶İ
	        a = c
	    Else
	        'f(c) > 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (a, c) ‚Ì’†‚É‘¶İ
	        b = c
	    End If
	Loop

    falseposition = c
End Function

Private Function f(ByVal x)
    f = x * x - 2.0
End Function
