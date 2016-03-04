Option Explicit

Dim x: x = 2.0
WScript.StdOut.Write Right(Space(12) & FormatNumber(newton(x), 10, -1, 0, 0), 12) & vbNewLine

Private Function newton(ByVal x0)
	Dim x1
	Do While(True)
		x1 = x0 - (f0(x0) / f1(x0))
	    WScript.StdOut.Write Right(Space(12) & FormatNumber(x1,          10, -1, 0, 0), 12) & vbTab
	    WScript.StdOut.Write Right(Space(12) & FormatNumber(x1 - Sqr(2), 10, -1, 0, 0), 12) & vbNewLine

	    If Abs(x1 - x0) < 0.0000000001 Then Exit Do
	    x0 = x1
	Loop

    newton = x1
End Function

Private Function f0(ByVal x)
    f0 = x * x - 2
End Function

Private Function f1(ByVal x)
    f1 = 2 * x
End Function
