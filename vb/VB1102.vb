Option Explicit

Module VB1102
    Private Const N As Integer = 3

	'逆ベキ乗法で最小固有値を求める
    Public Sub Main()
        Dim a(,) As Double = {{5.0, 4.0, 1.0, 1.0}, 
                              {4.0, 5.0, 1.0, 1.0}, 
                              {1.0, 1.0, 4.0, 2.0},
                              {1.0, 1.0, 2.0, 4.0}}
        Dim x()  As Double =  {1.0 ,0.0 ,0.0 ,0.0}

		'LU分解
		forward_elimination(a)

		'逆ベキ乗法
        Dim lambda As Double = inverse(a, x)

        Console.WriteLine()
        Console.WriteLine("eigenvalue")
        Console.WriteLine(string.Format("{0,14:F10}", lambda))

        Console.WriteLine("eigenvector")
        disp_vector(x)
    End Sub

	'逆ベキ乗法
    Private Function inverse(ByVal a(,) As Double, ByRef x0() As Double) As Double
	    Dim lambda As Double = 0.0

        '正規化 (ベクトル x0 の長さを１にする)
        normarize(x0)
	    Dim e0 As Double = 0.0
	    For i As Integer = 0 To N
	        e0 += x0(i)
	    Next

    	For k As Integer = 1 To 100
	        '１次元配列を表示
	        Console.Write(string.Format("{0,3:D}{1}", k, vbTab))
	        disp_vector(x0)

	        'Ly = b から y を求める (前進代入)
        	Dim b() As Double = New Double(N){}
        	Dim y() As Double = New Double(N){}
	        For i As Integer = 0 To N
	            b(i) = x0(i)
	        Next
	        forward_substitution(a,y,b)
	        'Ux = y から x を求める (後退代入)
        	Dim x1() As Double = New Double(N){}
	        backward_substitution(a,x1,y)

	        '内積
	        Dim p0 As Double = 0.0
	        Dim p1 As Double = 0.0
            For i As Integer = 0 To N
	            p0 += x1(i) * x1(i)
	            p1 += x1(i) * x0(i)
	        Next
	        '固有値
	        lambda = p1 / p0

	        '正規化 (ベクトル x1 の長さを１にする)
	        normarize(x1)
	        '収束判定
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

	'LU分解
	Private Sub forward_elimination(ByRef a(,) As Double)
	    For pivot As Integer = 0 To (N - 1)
	        For row As Integer = (pivot + 1) To N
	            Dim s As Double = a(row, pivot) / a(pivot, pivot)
	            For col As Integer = pivot To N
	                a(row, col) -= a(pivot, col) * s 'これが 上三角行列
	            Next
	            a(row, pivot) = s                    'これが 下三角行列
	        Next
	    Next
	End Sub
	'前進代入 (Ly = b から y を求める)
	Private Sub forward_substitution(ByVal a(,) As Double, ByRef y() As Double, ByVal b() As Double)
	    For row As Integer = 0 To N
	        For col As Integer = 0 To row
	            b(row) -= a(row, col) * y(col)
	        Next
	        y(row) = b(row)
	    Next
	End Sub
	'後退代入 (Ux = y から x を求める)
	Private Sub backward_substitution(ByVal a(,) As Double, ByRef x() As Double, ByVal y() As Double)
	    For row As Integer = N To 0 Step -1
	        For col As Integer = N To (row + 1) Step - 1
	            y(row) -= a(row, col) * x(col)
	        Next
	        x(row) = y(row) / a(row, row)
	    Next
	End Sub

	'１次元配列を表示
	Private Sub disp_vector(ByVal row() As Double)
	    For Each col As Double In row
            Console.Write(string.Format("{0,14:F10}{1}", col, vbTab))
	    Next
        Console.WriteLine()
	End Sub

	'正規化 (ベクトルの長さを１にする)
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
