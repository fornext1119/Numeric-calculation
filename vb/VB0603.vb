Module VB0603
    Public Sub Main()
        Const a As Double = 0
        Const b As Double = 1

        'Simpsonë•Ç≈êœï™
        Dim n As Integer = 2
        For j As Integer = 1 To 5
            Dim h  As Double = (b - a) / n
            Dim s2 As Double = 0
            Dim s4 As Double = 0
            Dim x  As Double = a + h
            For i As Integer = 1 To n \ 2
                s4 += f(x)
                x  += h
                s2 += f(x)
                x  += h
            Next
            s2 = (s2 - f(b)) * 2 + f(a) + f(b)
            s4 *= 4
            Dim s As Double = (s2 + s4) * h / 3
            n *= 2

            'åãâ Ç ÉŒ Ç∆î‰är
            Console.WriteLine(String.Format("{0,2:D} : {1,13:F10}, {2,13:F10}", j, s, s - Math.PI))
        Next
    End Sub

    Private Function f(ByVal x As Double) As Double
        Return 4 / (1 + x * x)
    End Function
End Module
