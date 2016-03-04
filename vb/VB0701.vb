Module VB0701
	'�f�[�^�_�̐� - 1
    Private Const N As Integer = 6

    Public Sub Main()
        Dim x(N) As Double
        Dim y(N) As Double

        '1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
        For i As Integer = 0 To N
            Dim d As Double = i * 1.5 - 4.5
            x(i) = d
            y(i) = f(d)
        Next

        '0.5���݂� �^�����Ă��Ȃ��l���� 
        For i As Integer = 0 To 18
            Dim d  As Double = i * 0.5 - 4.5
            Dim d1 As Double = f(d)
            Dim d2 As Double = lagrange(d, x, y)

            '���̊֐��Ɣ�r
            Console.WriteLine(string.Format("{0,5:F2}{4}{1,8:F5}{4}{2,8:F5}{4}{3,8:F5}", d, d1, d2, d1 - d2, vbTab))
        Next
    End Sub

    '���̊֐�
    Private Function f(ByVal x As Double) As Double
        Return x - (x ^ 3) / (3 * 2) + (x ^ 5) / (5 * 4 * 3 * 2)
    End Function

    'Lagrange (���O�����W��) ���
    Private Function lagrange(ByVal d As Double, ByVal x() As Double, ByVal y() As Double) As Double
        Dim sum As Double = 0
        For i As Integer = 0 To N
            Dim prod As Double = y(i)
            For j As Integer = 0 To N
                If j <> i Then
                    prod *= (d - x(j)) / (x(i) - x(j))
                End If
            Next
            sum += prod
        Next
        Return sum
    End Function
End Module
