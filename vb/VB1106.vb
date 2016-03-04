Option Explicit

Module VB1106
    Private Const N As Integer = 3

	'ハウスホルダー変換とQR分解で固有値を求める
    Public Sub Main()
        Dim a(,) As Double = {{5.0, 4.0, 1.0, 1.0}, 
                              {4.0, 5.0, 1.0, 1.0}, 
                              {1.0, 1.0, 4.0, 2.0},
                              {1.0, 1.0, 2.0, 4.0}}
        Dim d()  As Double = New Double(N){}
        Dim e()  As Double = New Double(N){}

		'ハウスホルダー変換
		tridiagonalize(a, d, e)

		'QR分解
		decomp(a, d, e)

        Console.WriteLine()
        Console.WriteLine("eigenvalue")
		disp_vector(d)

        Console.WriteLine()
        Console.WriteLine("eigenvector")
		disp_matrix(a)
    End Sub

	'ハウスホルダー変換
	Private Sub tridiagonalize(ByRef a(,) As Double, ByRef d() As Double, ByRef e() As Double)
        Dim w() As Double = New Double(N){}
        Dim v() As Double = New Double(N){}

	    For k As Integer = 0 To N - 2
	        d(k) = a(k, k)

	        Dim t As Double =  0.0
	        For i As Integer = k + 1 To N
	            w(i) =  a(i, k)
	            t    += w(i) * w(i)
	        Next
	        Dim s As Double = Math.Sqrt(t) 
	        If w(k + 1) < 0 Then
	            s = -s
	        End If

	        If Math.Abs(s) < 0.00000000001 Then
	            e(k + 1) = 0.0
	        Else
	            e(k + 1)  = -s
	            w(k + 1) +=  s
	            s = 1 / Math.Sqrt(w(k + 1) * s)
	            For i As Integer = k + 1 To N
	                w(i) *= s
	            Next

	            For i As Integer = k + 1 To N
	                s = 0.0
	                For j As Integer = k + 1 To N
	                    If j <= i Then
	                        s += a(i, j) * w(j)
	                    Else
	                        s += a(j, i) * w(j)
	                    End If
	                Next
	                v(i) = s
	            Next

	            s = 0.0
	            For i As Integer = k + 1 To N
	                s += w(i) * v(i)
	            Next
	            s /= 2.0
	            For i As Integer = k + 1 To N
	                v(i) -= s * w(i)
	            Next
	            For i As Integer = k + 1 To N
	                For j As Integer = k + 1 To i
	                    a(i, j) -= w(i) * v(j) + w(j) * v(i)
	                Next
	            Next
	            '次の行は固有ベクトルを求めないなら不要
	            For i As Integer = k + 1 To N
	                a(i, k) = w(i)
	            Next
	        End If 
	    Next

	    d(N - 1) = a(N - 1, N - 1)
	    d(N)     = a(N, N)
	    
	    e(0)     = 0.0  
	    e(N)     = a(N, N - 1)
	    
	    '次の行は固有ベクトルを求めないなら不要
	    For k As Integer = N To 0 Step -1
	        w = {0.0 ,0.0 ,0.0 ,0.0}
	        If k < N - 1 Then
	            For i As Integer = k + 1 To N
	                w(i) = a(i, k)
	            Next
	            For i As Integer = k + 1 To N
	                Dim s As Double  = 0.0
	                For j As Integer = k + 1 To N
	                    s += a(i, j) * w(j)
	                Next
	                v(i) = s
	            Next
	            For i As Integer = k + 1 To N
	                For j As Integer = k + 1 To N
	                    a(i, j) -= v(i) * w(j)
	                Next
	            Next
	        End If
	        For i As Integer = 0 To N
	            a(i, k) = 0.0
	        Next
	        a(k, k) = 1.0
	    Next
	End Sub

	'QR分解
	Private Sub decomp(ByRef a(,) As Double, ByRef d() As Double, ByRef e() As Double)
	    e(0) = 1.0
	    Dim h As Integer = N
	    Do While (Math.Abs(e(h)) < 0.00000000001)
	        h -= 1
	    Loop

	    Do While h > 0
	        e(0) = 0.0
	        Dim l As Integer = h - 1
	        Do While (Math.Abs(e(l)) >= 0.00000000001)
	            l -= 1
	        Loop
	        For j As Integer = 1 To 100
	            Dim w As Double = (d(h - 1) - d(h)) / 2.0
	            Dim s As Double = Math.Sqrt(w * w + e(h) * e(h))
	            If w < 0.0 Then 
	                s = -s
	            End If

	            Dim x As Double = d(l) - d(h) + e(h) * e(h) / (w + s)
	            Dim y As Double = e(l + 1)
	            Dim z As Double = 0.0
	            Dim t As Double = 0.0
	            Dim u As Double = 0.0
	            For k As Integer = l To h - 1
	                If Math.Abs(x) >= Math.Abs(y) Then
	                    t = -y / x  
	                    u = 1 / Math.Sqrt(t * t + 1.0)  
	                    s = t * u
	                Else
	                    t = -x / y
	                    s = 1 / Math.Sqrt(t * t + 1.0)  
	                    If t < 0 Then 
	                        s = -s
	                    End If
	                    u = t * s
	                End If
	                w = d(k) - d(k + 1)
	                t = (w * s + 2 * u * e(k + 1)) * s
	                d(k    ) = d(k    ) - t  
	                d(k + 1) = d(k + 1) + t
	                e(k    ) = u * e(k) - s * z
	                e(k + 1) = e(k + 1) * (u * u - s * s) + w * s * u

	                '次の行は固有ベクトルを求めないなら不要
	                For i As Integer = 0 To N
	                    x = a(k    , i)  
	                    y = a(k + 1, i)
	                    a(k    , i) = u * x - s * y  
	                    a(k + 1, i) = s * x + u * y
	                Next

	                If k < N - 1 Then
	                    x = e(k + 1)  
	                    y = -s * e(k + 2)  
	                    z = y
	                    e(k + 2) = u * e(k + 2)
	                End If
	            Next

            	Console.Write(string.Format("{0,3:D}{1}", j, vbTab))
				Call disp_vector(d)

		        '収束判定
				If (Math.Abs(e(h)) < 0.00000000001) Then Exit For
	        Next

	        e(0) = 1.0  
	        Do While (Math.Abs(e(h)) < 0.00000000001)
	            h -= 1
	        Loop
	    Loop

	    '次の行は固有ベクトルを求めないなら不要
	    For k As Integer = 0 To N - 1
	        Dim l As Integer = k
	        For i As Integer = k + 1 To N 
	            If d(i) > d(l) Then 
	                l = i
	            End If
	        Next

	        Dim t As Double = d(k)  
	        d(k) = d(l)  
	        d(l) = t

			For i As Integer = 0 To N
		        t       = a(k, i)  
		        a(k, i) = a(l, i)  
		        a(l, i) = t
	        Next
	    Next
	End Sub

	'１次元配列を表示
	Private Sub disp_vector(ByVal row() As Double)
	    For Each col As Double In row
            Console.Write(string.Format("{0,14:F10}{1}", col, vbTab))
	    Next
        Console.WriteLine()
	End Sub

	'２次元配列を表示
	Private Sub disp_matrix(ByVal matrix(,) As Double)
	    For row As Integer = 0 To N
		    For col As Integer = 0 To N
	            Console.Write(string.Format("{0,14:F10}{1}", matrix(row, col), vbTab))
		    Next
	        Console.WriteLine()
	    Next
	End Sub
End Module
