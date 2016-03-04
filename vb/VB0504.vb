Module VB0504
    Public Sub Main()
        For i As Integer = 0 To 20
            Dim x As Double  = (i - 10) / 4.0
            '�W���̎w���֐�
            Dim d1 As Double = Math.Exp(x)
            '����̎w���֐�
            Dim d2 As Double = myExp(x, 1, 1.0, 1.0, 1.0)
            '�W���֐��Ƃ̍���
            Console.WriteLine(String.Format("{0,5:F2} : {1,13:F10} - {2,13:F10} = {3,13:F10}", x, d1, d2, d1 - d2))
        Next
    End Sub

    '����̎w���֐�
    Private Function myExp(ByVal x As Double, ByVal n As Integer, ByVal numerator As Double, ByVal denominator As Double, ByVal y As Double) As Double
        denominator     = denominator * n
        numerator       = numerator   * x
        Dim a As Double = numerator / denominator
        '�\���Ȑ��x�ɂȂ����珈���𔲂���
        If (Math.Abs(a) <= 0.00000000001) Then
            Return y
        Else
            Return y + myExp(x, n + 1, numerator, denominator, a)
        End If
    End Function
End Module
