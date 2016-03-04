Option Explicit

Module VB0904
    Public Sub Main()
        Dim x As Double = 2.0
        Console.WriteLine(string.Format("{0,12:F10}", newton(x)))
    End Sub

	Private Function newton(ByVal x0 As Double)
        Dim x1 As Double
        Do While(True)
		    x1 = x0 - (f0(x0) / f1(x0))
            Console.WriteLine(String.Format("{0,12:F10}{2}{1,13:F10}", x1, x1 - Math.Sqrt(2), vbTab))

            If Math.Abs(x1 - x0) < 0.0000000001 Then Exit Do
			x0 = x1
        Loop

	    Return x1
    End Function

    Private Function f0(ByVal x As Double) As Double
        Return x * x - 2
    End Function

    Private Function f1(ByVal x As Double) As Double
        Return 2 * x
    End Function
End Module
