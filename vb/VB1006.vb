Option Explicit

Module VB1006
    Private Const N As Integer = 3
    
    Public Sub Main()
	    Dim a(,) As Double = {{5,2,3,4},{2,10,6,7},{3,6,15,9},{4,7,9,20}}
	    Dim b()  As Double = {34,68,96,125}

		Console.WriteLine("A")
		disp_matrix(a)
		Console.WriteLine("B")
		disp_vector(b)
		Console.WriteLine

		'�O�i����
		forward_elimination(a,b)

		Console.WriteLine("LL^T")
		disp_matrix(a)

		'Ly=b ���� y �����߂� (�O�i���)
        Dim y()  As Double = {0,0,0,0}
		forward_substitution(a,b,y)

        Console.WriteLine("Y")
		disp_vector(y)

		'L^Tx=y ���� x �����߂� (��ޑ��)
        Dim x()  As Double = {0,0,0,0}
		backward_substitution(a,y,x)

        Console.WriteLine("X")
		disp_vector(x)
    End Sub
    
    '�P�����z��̕\��
    Private Sub disp_vector(ByVal row() As Double)
        For Each col As Double In row
            Console.Write(string.Format("{0,14:F10}{1}", col, vbTab))
        Next
        Console.WriteLine()
    End Sub
    
    '�Q�����z��̕\��
    Private Sub disp_matrix(ByVal matrix(,) As Double)
		Dim i As Integer = 0
        For Each col As Double In matrix
            Console.Write(string.Format("{0,14:F10}{1}", col, vbTab))
			i += 1
			If i > N Then
				i = 0
		        Console.WriteLine()
			End If
        Next
    End Sub
    
	'�O�i����
	Private Sub forward_elimination(ByRef a(,) As Double, ByRef b() As Double)
	    For pivot As Integer = 0 To N
	        Dim s As Double = 0
	        For col As Integer = 0 To (pivot - 1)
	            s += a(pivot,col) * a(pivot,col)
	        Next
	        '�����ō����̒������̒l�ɂȂ�ƌv�Z�ł��Ȃ��I
	        a(pivot,pivot) = Math.Sqrt(a(pivot,pivot) - s)
	        
	        For row As Integer = (pivot + 1) To N
	            s = 0
	            For col As Integer = 0 To (pivot - 1)
	                s += a(row,col) * a(pivot,col)
	            Next
	            a(row,pivot) = (a(row,pivot) - s) / a(pivot,pivot)
	            a(pivot,row) = a(row,pivot)
	        Next
	    Next
	End Sub

	'�O�i���
	Private Sub forward_substitution(ByVal a(,) As Double, ByVal b() As Double, ByRef y() As Double)
	    For row As Integer = 0 To N
	        For col As Integer = 0 To row
	            b(row) -= a(row,col) * y(col)
	        Next
	        y(row) = b(row) / a(row,row)
	    Next
	End Sub

	'��ޑ��
	Private Sub backward_substitution(ByVal a(,) As Double, ByVal y() As Double, ByRef x() As Double)
	    For row As Integer = N To 0 Step -1
	        For col As Integer = N To (row + 1) Step - 1
	            y(row) -= a(row,col) * x(col)
	        Next
	        x(row) = y(row) / a(row,row)
	    Next
	End Sub
End Module
