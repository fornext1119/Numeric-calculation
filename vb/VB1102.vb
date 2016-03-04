Option Explicit

Module VB1102
    Private Const N As Integer = 3

	'�t�x�L��@�ōŏ��ŗL�l�����߂�
    Public Sub Main()
        Dim a(,) As Double = {{5.0, 4.0, 1.0, 1.0}, 
                              {4.0, 5.0, 1.0, 1.0}, 
                              {1.0, 1.0, 4.0, 2.0},
                              {1.0, 1.0, 2.0, 4.0}}
        Dim x()  As Double =  {1.0 ,0.0 ,0.0 ,0.0}

		'LU����
		forward_elimination(a)

		'�t�x�L��@
        Dim lambda As Double = inverse(a, x)

        Console.WriteLine()
        Console.WriteLine("eigenvalue")
        Console.WriteLine(string.Format("{0,14:F10}", lambda))

        Console.WriteLine("eigenvector")
        disp_vector(x)
    End Sub

	'�t�x�L��@
    Private Function inverse(ByVal a(,) As Double, ByRef x0() As Double) As Double
	    Dim lambda As Double = 0.0

        '���K�� (�x�N�g�� x0 �̒������P�ɂ���)
        normarize(x0)
	    Dim e0 As Double = 0.0
	    For i As Integer = 0 To N
	        e0 += x0(i)
	    Next

    	For k As Integer = 1 To 100
	        '�P�����z���\��
	        Console.Write(string.Format("{0,3:D}{1}", k, vbTab))
	        disp_vector(x0)

	        'Ly = b ���� y �����߂� (�O�i���)
        	Dim b() As Double = New Double(N){}
        	Dim y() As Double = New Double(N){}
	        For i As Integer = 0 To N
	            b(i) = x0(i)
	        Next
	        forward_substitution(a,y,b)
	        'Ux = y ���� x �����߂� (��ޑ��)
        	Dim x1() As Double = New Double(N){}
	        backward_substitution(a,x1,y)

	        '����
	        Dim p0 As Double = 0.0
	        Dim p1 As Double = 0.0
            For i As Integer = 0 To N
	            p0 += x1(i) * x1(i)
	            p1 += x1(i) * x0(i)
	        Next
	        '�ŗL�l
	        lambda = p1 / p0

	        '���K�� (�x�N�g�� x1 �̒������P�ɂ���)
	        normarize(x1)
	        '��������
		    Dim e1 As Double = 0.0
		    For i As Integer = 0 To N
		        e1 += x1(i)
		    Next
	        If Math.Abs(e1 - e0) < 0.00000000001 Then Exit For

	        For i As Integer = 0 To N
	            x0(i) = x1(i)
	        Next
	        e0 = e1
    	Next

		Return lambda
    End Function

	'LU����
	Private Sub forward_elimination(ByRef a(,) As Double)
	    For pivot As Integer = 0 To (N - 1)
	        For row As Integer = (pivot + 1) To N
	            Dim s As Double = a(row, pivot) / a(pivot, pivot)
	            For col As Integer = pivot To N
	                a(row, col) -= a(pivot, col) * s '���ꂪ ��O�p�s��
	            Next
	            a(row, pivot) = s                    '���ꂪ ���O�p�s��
	        Next
	    Next
	End Sub
	'�O�i��� (Ly = b ���� y �����߂�)
	Private Sub forward_substitution(ByVal a(,) As Double, ByRef y() As Double, ByVal b() As Double)
	    For row As Integer = 0 To N
	        For col As Integer = 0 To row
	            b(row) -= a(row, col) * y(col)
	        Next
	        y(row) = b(row)
	    Next
	End Sub
	'��ޑ�� (Ux = y ���� x �����߂�)
	Private Sub backward_substitution(ByVal a(,) As Double, ByRef x() As Double, ByVal y() As Double)
	    For row As Integer = N To 0 Step -1
	        For col As Integer = N To (row + 1) Step - 1
	            y(row) -= a(row, col) * x(col)
	        Next
	        x(row) = y(row) / a(row, row)
	    Next
	End Sub

	'�P�����z���\��
	Private Sub disp_vector(ByVal row() As Double)
	    For Each col As Double In row
            Console.Write(string.Format("{0,14:F10}{1}", col, vbTab))
	    Next
        Console.WriteLine()
	End Sub

	'���K�� (�x�N�g���̒������P�ɂ���)
	Private Sub normarize(ByRef x() As Double)
	    Dim s As Double = 0.0

	    For i As Integer = 0 To N
	        s += x(i) * x(i)
	    Next
	    s = Math.Sqrt(s)
	    
	    For i As Integer = 0 To N
	        x(i) /= s
	    Next
	End Sub

End Module
