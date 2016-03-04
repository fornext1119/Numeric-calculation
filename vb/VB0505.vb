Module VB0505
    Public Sub Main()
        For i As Integer = 0 To 20
            Dim x As Double  = (i - 10) / 4.0
            '標準の指数関数
            Dim d1 As Double = Math.Exp(x)
            '自作の指数関数
            Dim x2 As Double = x * x
            Dim d2 As Double = myExp(x, x2, 30, 0.0) '30:必要な精度が得られるよう, 6から始めて4ずつ増加させる
            '標準関数との差異
            Console.WriteLine(String.Format("{0,5:F2} : {1,13:F10} - {2,13:F10} = {3,13:F10}", x, d1, d2, d1 - d2))
        Next
    End Sub

    '自作の指数関数
    Private Function myExp(ByVal x As Double, ByVal x2 As Double, ByVal n As Integer, ByVal t As Double) As Double
        t = x2 / (n + t)
        n -= 4  

        If (n < 6) Then
            Return 1 + ((2 * x) / (2 - x + t))
        Else
            Return myExp(x, x2, n, t)
        End If
    End Function
End Module
