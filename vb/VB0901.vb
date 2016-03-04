Option Explicit

Module VB0901
    Public Sub Main()
        Dim a As Double = 1.0
        Dim b As Double = 2.0
        Console.WriteLine(string.Format("{0,12:F10}", bisection(a, b)))
    End Sub

	Private Function bisection(ByVal a As Double, ByVal b As Double)
        Dim c As Double
        Do While(True)
            '��� (a, b) �̒��_ c = (a + b) / 2
            c = (a + b) / 2
            Console.WriteLine(String.Format("{0,12:F10}{2}{1,13:F10}", c, c - Math.Sqrt(2), vbTab))

            Dim fc As Double = f(c)
            If Math.Abs(fc) < 0.0000000001 Then Exit Do
          
            If fc < 0 Then
                'f(c) < 0 �ł����, ���͋�� (c, b) �̒��ɑ���
                a = c
            Else
                'f(c) > 0 �ł����, ���͋�� (a, c) �̒��ɑ���
                b = c
            End If
        Loop

	    Return c
    End Function

    Private Function f(ByVal x As Double) As Double
        Return x * x - 2.0
    End Function
End Module
