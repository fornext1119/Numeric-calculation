Module VB0604
    Public Sub Main()
        Const a As Double = 0
        Const b As Double = 1

        Dim t(6, 6) As Double

        'ë‰å`ë•Ç≈êœï™
        Dim n As Integer = 2
        For i As Integer = 1 To 6
            Dim h As Double = (b - a) / n
            Dim s As Double = 0
            Dim x As Double = a
            For j As Integer = 1 To n - 1
                x += h
                s += f(x)
            Next
            'åãâ Çï€ë∂
            t(i,1) = h * ((f(a) + f(b)) / 2 + s)
            n *= 2
        Next

        'RichardsonÇÃï‚äOñ@
        n = 4
        For j As Integer = 2 To 6
            For i As Integer = j To 6
                t(i,j) = t(i, j - 1) + (t(i, j - 1) - t(i - 1, j - 1)) / (n - 1)
                If i = j Then
                    'åãâ Ç ÉŒ Ç∆î‰är
                    Console.WriteLine(String.Format("{0,2:D} : {1,13:F10}, {2,13:F10}", j, t(i,j), t(i,j) - Math.PI))
                End If
            Next
            n *= 4
        Next
    End Sub

    Private Function f(ByVal x As Double) As Double
        Return 4 / (1 + x * x)
    End Function
End Module
