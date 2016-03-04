Option Explicit

Module VB1004
    Private Const N As Integer = 3
    
    Public Sub Main()
        Dim a(,) As Double = {{-1,-2,7,-2},{1,-1,-2,6},{9,2,1,1},{2,8,-2,1}}
        Dim b()  As Double = {8,17,20,16}

		'�s�{�b�g�I��
		pivoting(a,b)

		Console.WriteLine("pivoting")
		Console.WriteLine("A")
		disp_matrix(a)
		Console.WriteLine("B")
		disp_vector(b)
		Console.WriteLine

		'�O�i����
		forward_elimination(a,b)

		Console.WriteLine("forward elimination")
		Console.WriteLine("A")
		disp_matrix(a)
		Console.WriteLine("B")
		disp_vector(b)
		Console.WriteLine

		'��ޑ��
		backward_substitution(a,b)

        Console.WriteLine("X")
		disp_vector(b)
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
	        For row As Integer = 0 To N
                If row = pivot Then Continue For

	            Dim s As Double = a(row,pivot) / a(pivot,pivot)
	            For col As Integer = pivot To N
	                a(row,col) -= a(pivot,col) * s
	            Next
	            b(row) -= b(pivot) * s
	        Next
	    Next
	End Sub

	'��ޑ��
	Private Sub backward_substitution(ByVal a(,) As Double, ByRef b() As Double)
	    For pivot As Integer = 0 To N
	        b(pivot) /= a(pivot,pivot)
	    Next
	End Sub

	'�s�{�b�g�I��
	Private Sub pivoting(ByRef a(,) As Double, ByRef b() As Double)
	    For pivot As Integer = 0 To N
	        '�e��� ��Ԓl���傫���s�� �T��
	        Dim max_row As Integer = pivot
	        Dim max_val As Double = 0
	        For row As Integer = pivot To N
	            If Math.Abs(a(row,pivot)) > max_val Then
	                '��Ԓl���傫���s
	                max_val =   Math.Abs(a(row,pivot))
	                max_row =   row
	            End If
	        Next

	        '��Ԓl���傫���s�Ɠ���ւ�
	        If max_row <> pivot Then
	            Dim tmp As Double
	            For col As Integer = 0 To N
	                tmp            =   a(max_row,col)
	                a(max_row,col) =   a(pivot,col)
	                a(pivot,col)   =   tmp
	            Next
	            tmp         =   b(max_row)
	            b(max_row)  =   b(pivot)
	            b(pivot)    =   tmp
	        End If
	    Next
	End Sub
End Module
