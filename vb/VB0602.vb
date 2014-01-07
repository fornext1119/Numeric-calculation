Module VB0602
    Public Sub Main()
        Const a As Double = 0
        Const b As Double = 1

        'íÜì_ë•Ç≈êœï™
        Dim n As Integer = 2
        For j As Integer = 1 To 10
            Dim h As Double = (b - a) / n
            Dim s As Double = 0
            Dim x As Double = a + (h / 2)
            For i As Integer = 1 To n
                s += f(x)
                x += h
            Next
            s = h * s
            n *= 2

            'åãâ Ç ÉŒ Ç∆î‰är
            Console.WriteLine(String.Format("{0,2:D} : {1,13:F10}, {2,13:F10}", j, s, s - Math.PI))
        Next
    End Sub

    Private Function f(ByVal x As Double) As Double
        Return 4 / (1 + x * x)
    End Function
End Module
