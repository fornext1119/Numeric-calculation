Option Explicit

Module VB0906
    Public Sub Main()
        Dim x0 As Double = 1.0
        Dim x1 As Double = 2.0
        Console.WriteLine(string.Format("{0,12:F10}", secant(x0, x1)))
    End Sub

	Private Function secant(ByVal x0 As Double, ByVal x1 As Double)
        Dim x2 As Double
        Do While(True)
			x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0))
            Console.WriteLine(String.Format("{0,12:F10}{2}{1,13:F10}", x2, x2 - Math.Sqrt(2), vbTab))

            If Math.Abs(x2 - x1) < 0.0000000001 Then Exit Do
			x0 = x1
			x1 = x2
        Loop

	    Return x2
    End Function

    Private Function f(ByVal x As Double) As Double
        Return x * x - 2
    End Function
End Module
