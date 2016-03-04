Option Explicit

Module VB1007
    Private Const N As Integer = 3
    
    Public Sub Main()
	    Dim a(,) As Double = {{5,2,3,4},{2,10,6,7},{3,6,15,9},{4,7,9,20}}
	    Dim b()  As Double = {34,68,96,125}

		Console.WriteLine("A")
		disp_matrix(a)
		Console.WriteLine("B")
		disp_vector(b)
		Console.WriteLine

		'前進消去
		forward_elimination(a,b)

		Console.WriteLine("LDL^T")
		disp_matrix(a)

		'Ly=b から y を求める (前進代入)
        Dim y()  As Double = {0,0,0,0}
		forward_substitution(a,b,y)

        Console.WriteLine("Y")
		disp_vector(y)

		'DL^Tx=y から x を求める (後退代入)
        Dim x()  As Double = {0,0,0,0}
		backward_substitution(a,y,x)

        Console.WriteLine("X")
		disp_vector(x)
    End Sub
    
    '１次元配列の表示
    Private Sub disp_vector(ByVal row() As Double)
        For Each col As Double In row
            Console.Write(string.Format("{0,14:F10}{1}", col, vbTab))
        Next
        Console.WriteLine()
    End Sub
    
    '２次元配列の表示
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
    
	'前進消去
	Private Sub forward_elimination(ByRef a(,) As Double, ByRef b() As Double)
	    For pivot As Integer = 0 To N
	        'pivot < k の場合
	        Dim s As Double = 0
	        For col As Integer = 0 To (pivot - 1)
	            s = a(pivot,col)
	            For k As Integer = 0 To (col - 1)
	                s -= a(pivot,k) * a(col,k) * a(k,k)
	            Next
	            a(pivot,col) = s / a(col,col)
	            a(col,pivot) = a(pivot,col)
	        Next
	        
	        'pivot == k の場合
	        s = a(pivot,pivot)
	        For k As Integer = 0 To (pivot - 1)
	            s -= a(pivot,k) * a(pivot,k) * a(k,k)
	        Next
	        a(pivot,pivot) = s
	    Next
	End Sub

	'前進代入
	Private Sub forward_substitution(ByVal a(,) As Double, ByVal b() As Double, ByRef y() As Double)
	    For row As Integer = 0 To N
	        For col As Integer = 0 To row
	            b(row) -= a(row,col) * y(col)
	        Next
	        y(row) = b(row)
	    Next
	End Sub

	'後退代入
	Private Sub backward_substitution(ByVal a(,) As Double, ByVal y() As Double, ByRef x() As Double)
	    For row As Integer = N To 0 Step -1
	        For col As Integer = N To (row + 1) Step - 1
	            y(row) -= a(row,col) * a(row,row) * x(col)
	        Next
	        x(row) = y(row) / a(row,row)
	    Next
	End Sub
End Module
