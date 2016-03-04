Option Explicit

Module VB0903
    Public Sub Main()
        Dim x As Double = 1.0
        Console.WriteLine(string.Format("{0,12:F10}", iterative(x)))
    End Sub

	Private Function iterative(ByVal x0 As Double)
        Dim x1 As Double
        Do While(True)
		    x1 = g(x0)
            Console.WriteLine(String.Format("{0,12:F10}{2}{1,13:F10}", x1, x1 - Math.Sqrt(2), vbTab))

            If Math.Abs(x1 - x0) < 0.0000000001 Then Exit Do
			x0 = x1
        Loop

	    Return x1
    End Function

    Private Function g(ByVal x As Double) As Double
        Return (x / 2) + (1 / x)
    End Function
End Module
