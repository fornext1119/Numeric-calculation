Module VB0506
    Public Sub Main()
        For i As Integer = 1 To 20
            Dim x As Double  = i / 5.0
            '標準の対数関数
            Dim d1 As Double = Math.Log(x)
            '自作の対数関数
            Dim x2 As Double = (x - 1) / (x + 1)
            Dim d2 As Double = 2 * myLog(x2, x2, 1.0, x2)
            '標準関数との差異
            Console.WriteLine(String.Format("{0,5:F2} : {1,13:F10} - {2,13:F10} = {3,13:F10}", x, d1, d2, d1 - d2))
        Next
    End Sub

    '自作の対数関数
    Private Function myLog(ByVal x2 As Double, ByVal numerator As Double, ByVal denominator As Double, ByVal y As Double) As Double
        denominator = denominator + 2
        numerator   = numerator   * x2 * x2
        Dim a As Double   = numerator / denominator
        '十分な精度になったら処理を抜ける
        If (Math.Abs(a) <= 0.00000000001) Then
            Return y
        Else
            Return y + myLog(x2, numerator, denominator, a)
        End If
    End Function
End Module
