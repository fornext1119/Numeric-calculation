Option Explicit

Module VB1105
    Private Const N As Integer = 3

	'���R�r�@�ŌŗL�l�����߂�
    Public Sub Main()
        Dim a(,) As Double = {{5.0, 4.0, 1.0, 1.0}, 
                              {4.0, 5.0, 1.0, 1.0}, 
                              {1.0, 1.0, 4.0, 2.0},
                              {1.0, 1.0, 2.0, 4.0}}
        Dim v(,) As Double = {{1.0 ,0.0 ,0.0 ,0.0},
                              {0.0 ,1.0 ,0.0 ,0.0},
                              {0.0 ,0.0 ,1.0 ,0.0},
                              {0.0 ,0.0 ,0.0 ,1.0}}

		'���R�r�@
		jacobi(a, v)

        Console.WriteLine()
        Console.WriteLine("eigenvalue")
		disp_eigenvalue(a)

        Console.WriteLine()
        Console.WriteLine("eigenvector")
		disp_eigenvector(v)
    End Sub

	'���R�r�@
	Private Sub jacobi(ByRef a(,) As Double, ByRef v(,) As Double)

	    For k As Integer = 1 To 100
	        '�ő�l��T��
	        Dim p, q As Integer
	        Dim max_val As Double = 0.0
	        For i As Integer = 0 To N
	            For j As Integer = i + 1 To N
	                If (max_val < Math.Abs(a(i, j))) Then
	                    max_val = Math.Abs(a(i, j))
	                    p = i
	                    q = j
	                End If
	            Next
	        Next

	        '�� �����߂�
	        Dim t As Double = 0.0
	        If Math.Abs(a(p, p) - a(q, q)) < 0.00000000001 Then
	            'a_{pp} �� a_{qq} �̂Ƃ��A��]�p������/4�ɂ���
	            t = Math.PI / 4.0
	            If (a(p, p) < 0) Then
	                t = -t
				End if
	        Else
	            'a_{pp} �� a_{qq} �̂Ƃ�
	            t = Math.Atan(2.0 * a(p, q) / (a(p, p) - a(q, q))) / 2.0
	        End If

	        '�� ���g���� �s�� U ���쐬���AA = U^t �~ A �~ U
	        Dim c As Double = Math.Cos(t)
	        Dim s As Double = Math.Sin(t)
	        'U^t �~ A
	        Dim t1 As Double = 0.0
	        Dim t2 As Double = 0.0
	        For i As Integer = 0 To N
	            t1      =  a(p, i) * c + a(q, i) * s
	            t2      = -a(p, i) * s + a(q, i) * c
	            a(p, i) = t1
	            a(q, i) = t2
	            '�ŗL�x�N�g��
	            t1      =  v(p, i) * c + v(q, i) * s
	            t2      = -v(p, i) * s + v(q, i) * c
	            v(p, i) = t1
	            v(q, i) = t2
	        Next
	        'A �~ U
	        For i As Integer = 0 To N
	            t1      =  a(i, p) * c + a(i, q) * s
	            t2      = -a(i, p) * s + a(i, q) * c
	            a(i, p) = t1
	            a(i, q) = t2
	        Next

	        '�Ίp�v�f��\��
	        Console.Write(string.Format("{0,3:D}{1}", k, vbTab))
	        disp_eigenvalue(a)

	        '��������
        	If max_val < 0.00000000001 Then Exit For
	    Next
	End Sub

	'�Ίp�v�f��\��
	Private Sub disp_eigenvalue(ByVal a(,) As Double)
	    For i As Integer = 0 To N
            Console.Write(string.Format("{0,14:F10}{1}", a(i, i), vbTab))
	    Next
        Console.WriteLine()
	End Sub

	'�ŗL�x�N�g����\��
	Private Sub disp_eigenvector(ByVal matrix(,) As Double)
	    For i As Integer = 0 To N
	        Dim row() As Double = New Double(N){}
		    For j As Integer = 0 To N
				row(j) = matrix(i, j)
		    Next
	        normarize(row)
	        disp_vector(row)
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
