Option Explicit

Dim x0: x0 = 1.0
Dim x1: x1 = 2.0
WScript.StdOut.Write Right(Space(12) & FormatNumber(secant(x0, x1), 10, -1, 0, 0), 12) & vbNewLine

Private Function secant(ByVal x0, ByVal x1)
	Dim x2
	Do While(True)
		x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0))
	    WScript.StdOut.Write Right(Space(12) & FormatNumber(x2,          10, -1, 0, 0), 12) & vbTab
	    WScript.StdOut.Write Right(Space(12) & FormatNumber(x2 - Sqr(2), 10, -1, 0, 0), 12) & vbNewLine

	    If Abs(x2 - x1) < 0.0000000001 Then Exit Do
	    x0 = x1
	    x1 = x2
	Loop

    secant = x2
End Function

Private Function f(ByVal x)
    f = x * x - 2
End Function
