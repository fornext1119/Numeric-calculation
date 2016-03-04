Module VB0601
    Public Sub Main()
        Const a As Double = 0
        Const b As Double = 1

        'ë‰å`ë•Ç≈êœï™
        Dim n As Integer = 2
        For j As Integer = 1 To 10
            Dim h As Double = (b - a) / n
            Dim s As Double = 0
            Dim x As Double = a
            For i As Integer = 1 To n - 1
                x += h
                s += f(x)
            Next
            s = h * ((f(a) + f(b)) / 2 + s)
            n *= 2

            'åãâ Ç ÉŒ Ç∆î‰är
            Console.WriteLine(String.Format("{0,2:D} : {1,13:F10}, {2,13:F10}", j, s, s - Math.PI))
        Next
    End Sub

    Private Function f(ByVal x As Double) As Double
        Return 4 / (1 + x * x)
    End Function
End Module
