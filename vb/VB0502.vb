Module VB0502
    Public Sub Main()
        For degree As Integer = 0 To 360 Step 15
            If (degree Mod 30 = 0 OrElse degree Mod 45 = 0) Then
                Dim radian As Double = degree * Math.PI / 180.0
                '自作の余弦関数
                Dim d1 As Double     = myCos(radian, 1, False, 1.0, 1.0, 1.0)
                '標準の余弦関数
                Dim d2 As Double     = Math.Cos(radian)
                '標準関数との差異
                Console.WriteLine(String.Format("{0,3:D} : {1,13:F10} - {2,13:F10} = {3,13:F10}", degree, d1, d2, d1 - d2))
            End If
        Next
    End Sub

    '自作の余弦関数
    Private Function myCos(ByVal x As Double, ByVal n As Integer, ByVal nega As Boolean, ByVal numerator As Double, ByVal denominator As Double, ByVal y As Double) As Double
        Dim m As Integer = 2 * n
        denominator      = denominator * m * (m - 1)
        numerator        = numerator   * x * x
        Dim a As Double  = numerator / denominator
        '十分な精度になったら処理を抜ける
        If (a <= 0.00000000001) Then
            Return y
        Else
            Return y + myCos(x, n + 1, Not nega, numerator, denominator, If(nega, a, -a))
        End If
    End Function
End Module
