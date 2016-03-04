Module VB0509
    Public Sub Main()
        For i As Integer = 0 To 20
            Dim x As Integer = i - 10
            '����̑o�Ȑ��]���֐�
            Dim d1 As Double = myCosh(x, 1, 1.0, 1.0, 1.0)
            '�W���̑o�Ȑ��]���֐�
            Dim d2 As Double = Math.Cosh(x)
            '�W���֐��Ƃ̍���
            Console.WriteLine(String.Format("{0,3:D} : {1,17:F10} - {2,17:F10} = {3,13:F10}", x, d1, d2, d1 - d2))
        Next
    End Sub

    '����̑o�Ȑ��]���֐�
    Private Function myCosh(ByVal x As Double, ByVal n As Integer, ByVal numerator As Double, ByVal denominator As Double, ByVal y As Double) As Double
        Dim m As Integer = 2 * n
        denominator      = denominator * m * (m - 1) 
        numerator        = numerator   * x * x
        Dim a As Double  = numerator / denominator
        '�\���Ȑ��x�ɂȂ����珈���𔲂���
        If (Math.Abs(a) <= 0.00000000001) Then
            Return y
        Else
            Return y + myCosh(x, n + 1, numerator, denominator, a)
        End If
    End Function
End Module
