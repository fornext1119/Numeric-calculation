Option Explicit

Module VB1104
    Private Const N As Integer = 3

	'QR分解で固有値を求める
    Public Sub Main()
        Dim a(,) As Double = {{5.0, 4.0, 1.0, 1.0}, 
                              {4.0, 5.0, 1.0, 1.0}, 
                              {1.0, 1.0, 4.0, 2.0},
                              {1.0, 1.0, 2.0, 4.0}}
        Dim q(,) As Double = New Double(N,N){}
        Dim r(,) As Double = New Double(N,N){}

	    For k As Integer= 1 To 100
        	'QR分解
		    decomp(a, q, r)
	        '行列の積
	        multiply(r, q, a)
	        '対角要素を表示
	        Console.Write(string.Format("{0,3:D}{1}", k, vbTab))
	        disp_eigenvalue(a)

	        '収束判定
	        Dim e As Double = 0.0
	        For i As Integer = 1 To N
	            For j As Integer = 0 To i - 1
	                e += Math.Abs(a(i, j))
	            Next
	        Next
	        If e < 0.00000000001 Then Exit For
	    Next

        Console.WriteLine()
        Console.WriteLine("eigenvalue")
        disp_eigenvalue(a)
    End Sub

	'QR分解
	Private Sub decomp(ByRef a(,) As Double, ByRef q(,) As Double, ByRef r(,) As Double)
        Dim x() As Double = New Double(N){}

	    For k As Integer = 0 To N
	        For i As Integer = 0 To N
	            x(i) = a(i, k)
	        Next
	        For j As Integer = 0 To k - 1
	            Dim t As Double = 0.0
	            For i As Integer = 0 To N
	                t += a(i, k) * q(i, j)
	            Next
	            r(j, k) = t
	            r(k, j) = 0.0
	            For i As Integer = 0 To N
	                x(i) -= t * q(i, j)
	            Next
	        Next

	        Dim s As Double = 0.0
	        For i As Integer = 0 To N
	            s += x(i) * x(i)
	        Next
	        r(k, k) = Math.Sqrt(s)
	        For i As Integer = 0 To N
	            q(i, k) = x(i) / r(k, k)
	        Next
	    Next
	End Sub

	'行列の積
	Private Sub multiply(ByRef a(,) As Double, ByRef b(,) As Double, ByRef c(,) As Double)
	    For i As Integer = 0 To N
	        For j As Integer = 0 To N
	            Dim s As Double = 0.0
	            For k As Integer = 0 To N
	                s += a(i, k) * b(k, j)
	            Next
	            c(i, j) = s
	        Next
	    Next
	End Sub

	'対角要素を表示
	Private Sub disp_eigenvalue(ByVal a(,) As Double)
	    For i As Integer = 0 To N
            Console.Write(string.Format("{0,14:F10}{1}", a(i, i), vbTab))
	    Next
        Console.WriteLine()
	End Sub

End Module
