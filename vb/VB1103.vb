Option Explicit

Module VB1103
    Private Const N As Integer = 3

	'LR分解で固有値を求める
    Public Sub Main()
        Dim a(,) As Double = {{5.0, 4.0, 1.0, 1.0}, 
                              {4.0, 5.0, 1.0, 1.0}, 
                              {1.0, 1.0, 4.0, 2.0},
                              {1.0, 1.0, 2.0, 4.0}}
        Dim l(,) As Double = New Double(N,N){}
        Dim u(,) As Double = New Double(N,N){}

	    For k As Integer= 1 To 200
		    'LU分解
		    decomp(a, l, u)
	        '行列の積
	        multiply(u, l, a)
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

	'LU分解
	Private Sub decomp(ByRef a(,) As Double, ByRef l(,) As Double, ByRef u(,) As Double)
	    For i As Integer = 0 To N
	        For j As Integer = 0 To N
	            l(i, j) = 0.0
	            u(i, j) = 0.0
	        Next
	    Next

	    l(0, 0) = 1.0
	    For j As Integer = 0 To N
	        u(0, j) = a(0, j)
	    Next

	    For i As Integer = 1 To N
	        u(i, 0) = 0.0
	        l(0, i) = 0.0
	        l(i, 0) = a(i, 0) / u(0, 0)
	    Next
	    For i As Integer = 1 To N
	        l(i, i) = 1.0
	        Dim t As Double = a(i, i)
	        For k As Integer = 0 To i
	            t -= l(i, k) * u(k, i)
	        Next
	        u(i, i) = t
	        For j As Integer = i + 1 To N
	            u(j, i) = 0.0
                l(i, j) = 0.0
	            t       = a(j, i)
	            For k As Integer = 0 To i
	                t -= l(j, k) * u(k, i)
	            Next
	            l(j, i) = t / u(i, i)
	            t       = a(i, j)
	            For k As Integer = 0 To i
	                t -= l(i, k) * u(k, j)
	            Next
	            u(i, j) = t
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
