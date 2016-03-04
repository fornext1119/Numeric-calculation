Option Explicit

Module VB0905
    Public Sub Main()
        Dim x As Double = 2.0
        Console.WriteLine(string.Format("{0,12:F10}", bailey(x)))
    End Sub

	Private Function bailey(ByVal x0 As Double)
        Dim x1 As Double
        Do While(True)
			x1 = x0 - (f0(x0) / (f1(x0) - (f0(x0) * f2(x0) / (2 * f1(x0)))))
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

    Private Function f2(ByVal x As Double) As Double
        Return 2
    End Function
End Module
