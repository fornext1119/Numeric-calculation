Module VB0705
	'データ点の数 - 1
    Private Const N As Integer = 6

    Public Sub Main()
        Dim x(N) As Double
        Dim y(N) As Double

        '1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
        For i As Integer = 0 To N
            Dim d1 As Double = i * 1.5 - 4.5
            x(i) = d1
            y(i) = f(d1)
        Next

	    '３項方程式の係数の表を作る
        Dim a(N) As Double
        Dim b(N) As Double
        Dim c(N) As Double
        Dim d(N) As Double
	    For i As Integer = 1 To N - 1
	        a(i) =         x(i)   - x(i-1)
	        b(i) = 2.0 *  (x(i+1) - x(i-1))
	        c(i) =         x(i+1) - x(i)
	        d(i) = 6.0 * ((y(i+1) - y(i)) / (x(i+1) - x(i)) - (y(i) - y(i-1)) / (x(i) - x(i-1)))
	    Next
	    '３項方程式を解く (ト－マス法)
        Dim g(N) As Double
        Dim s(N) As Double
	    g(1) = b(1)
	    s(1) = d(1)
	    For i As Integer = 2 To N - 1
	        g(i) = b(i) - a(i) * c(i-1) / g(i-1)
	        s(i) = d(i) - a(i) * s(i-1) / g(i-1)
	    Next
        Dim z(N) As Double
	    z(0)   = 0
	    z(N)   = 0
	    z(N-1) = s(N-1) / g(N-1)
	    For i As Integer = N - 2 To 1 Step -1
	        z(i) = (s(i) - c(i) * z(i+1)) / g(i)
	    Next

        '0.5刻みで 与えられていない値を補間
        For i As Integer = 0 To 18
            Dim d1 As Double = i * 0.5 - 4.5
            Dim d2 As Double = f(d1)
            Dim d3 As Double = spline(d1, x, y, z)

            '元の関数と比較
            Console.WriteLine(string.Format("{0,5:F2}{4}{1,8:F5}{4}{2,8:F5}{4}{3,8:F5}", d1, d2, d3, d2 - d3, vbTab))
        Next
    End Sub

    '元の関数
    Private Function f(ByVal x As Double) As Double
        Return x - (x ^ 3) / (3 * 2) + (x ^ 5) / (5 * 4 * 3 * 2)
    End Function

    'Spline (スプライン) 補間
    Private Function spline(ByVal d As Double, ByVal x() As Double, ByVal y() As Double, ByVal z() As Double) As Double
	    '補間関数値がどの区間にあるか
	    Dim k As Integer = -1
	    For i As Integer = 1 To N
	        if d <= x(i) Then
	            k = i - 1
	            Exit For
	        End If
	    Next
        If (k < 0) Then k = N

	    Dim d1 As Double = x(k+1) - d
	    Dim d2 As Double = d      - x(k)
	    Dim d3 As Double = x(k+1) - x(k)
	    return            (z(k) * (d1 ^ 3) + z(k+1) * (d2 ^ 3)) / (6.0 * d3) +
	                      (y(k)   / d3 - z(k)   * d3 / 6.0) * d1             +
	                      (y(k+1) / d3 - z(k+1) * d3 / 6.0) * d2
    End Function
End Module
