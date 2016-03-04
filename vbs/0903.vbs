Option Explicit

Dim x: x = 1.0
WScript.StdOut.Write Right(Space(12) & FormatNumber(iterative(x), 10, -1, 0, 0), 12) & vbNewLine

Private Function iterative(ByVal x0)
	Dim x1
	Do While(True)
		x1 = g(x0)
	    WScript.StdOut.Write Right(Space(12) & FormatNumber(x1,          10, -1, 0, 0), 12) & vbTab
	    WScript.StdOut.Write Right(Space(12) & FormatNumber(x1 - Sqr(2), 10, -1, 0, 0), 12) & vbNewLine

	    If Abs(x1 - x0) < 0.0000000001 Then Exit Do
	    x0 = x1
	Loop

    iterative = x1
End Function

Private Function g(ByVal x)
    g = (x / 2) + (1 / x)
End Function
