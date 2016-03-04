Option Explicit

Module VB1005
    Private Const N As Integer = 3
    
    Public Sub Main()
        Dim a(,) As Double = {{-1,-2,7,-2},{1,-1,-2,6},{9,2,1,1},{2,8,-2,1}}
        Dim b()  As Double = {8,17,20,16}

		'ピボット選択
		pivoting(a,b)

		Console.WriteLine("pivoting")
		Console.WriteLine("A")
		disp_matrix(a)
		Console.WriteLine("B")
		disp_vector(b)
		Console.WriteLine

		'前進消去
		forward_elimination(a,b)

		Console.WriteLine("LU")
		disp_matrix(a)

		'Ly=b から y を求める (前進代入)
        Dim y()  As Double = {0,0,0,0}
		forward_substitution(a,b,y)

        Console.WriteLine("Y")
		disp_vector(y)

		'Ux=y から x を求める (後退代入)
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
	    For pivot As Integer = 0 To (N - 1)
	        For row As Integer = (pivot + 1) To N
	            Dim s As Double = a(row,pivot) / a(pivot,pivot)
	            For col As Integer = pivot To N
	                a(row,col) -= a(pivot,col) * s 'これが 上三角行列
	            Next
                a(row,pivot) = s                   'これが 下三角行列
	            'b(row) -= b(pivot) * s            'この値は変更しない
	        Next
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
	            y(row) -= a(row,col) * x(col)
	        Next
	        x(row) = y(row) / a(row,row)
	    Next
	End Sub

	'ピボット選択
	Private Sub pivoting(ByRef a(,) As Double, ByRef b() As Double)
	    For pivot As Integer = 0 To N
	        '各列で 一番値が大きい行を 探す
	        Dim max_row As Integer = pivot
	        Dim max_val As Double = 0
	        For row As Integer = pivot To N
	            If Math.Abs(a(row,pivot)) > max_val Then
	                '一番値が大きい行
	                max_val =   Math.Abs(a(row,pivot))
	                max_row =   row
	            End If
	        Next

	        '一番値が大きい行と入れ替え
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
