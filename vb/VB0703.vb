Module VB0703
	'�f�[�^�_�̐� - 1
    Private Const N As Integer = 6

    Public Sub Main()
        Dim x(N) As Double
        Dim y(N) As Double

        '1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
        For i As Integer = 0 To N
            Dim d1 As Double = i * 1.5 - 4.5
            x(i) = d1
            y(i) = f(d1)
        Next

	    '�������̕\�����
        Dim d(N, N) As Double
	    For j As Integer = 0 To N
	        d(0,j) = y(j)
        Next

	    For i As Integer = 1 To N
	        For j As Integer = 0 To (N - i)
	            d(i,j) = (d(i-1,j+1) - d(i-1,j)) / (x(j+i) - x(j))
	        Next
        Next

	    '���K������
        Dim a(N) As Double
	    For j As Integer = 0 To N
	        a(j) = d(j,0)
        Next

        '0.5���݂� �^�����Ă��Ȃ��l���� 
        For i As Integer = 0 To 18
            Dim d1 As Double = i * 0.5 - 4.5
            Dim d2 As Double = f(d1)
            Dim d3 As Double = newton(d1, x, a)

            '���̊֐��Ɣ�r
            Console.WriteLine(string.Format("{0,5:F2}{4}{1,8:F5}{4}{2,8:F5}{4}{3,8:F5}", d1, d2, d3, d2 - d3, vbTab))
        Next
    End Sub

    '���̊֐�
    Private Function f(ByVal x As Double) As Double
        Return x - (x ^ 3) / (3 * 2) + (x ^ 5) / (5 * 4 * 3 * 2)
    End Function

    'Newton (�j���[�g��) ���
    Private Function newton(ByVal d As Double, ByVal x() As Double, ByVal a() As Double) As Double
        Dim sum As Double = a(0)
        For i As Integer = 1 To N
            Dim prod As Double = a(i)
            For j As Integer = 0 To (i - 1)
                If j <> i Then
                    prod *= (d - x(j))
                End If
            Next
            sum += prod
        Next
        Return sum
    End Function
End Module
