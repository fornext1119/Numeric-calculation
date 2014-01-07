Module VB0704
	'データ点の数 - 1
    Private Const N   As Integer =  6
    Private Const Nx2 As Integer = 13

    Public Sub Main()
        Dim x(N)  As Double
        Dim y(N)  As Double
        Dim yd(N) As Double

        '1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
        For i As Integer = 0 To N
            Dim d1 As Double = i * 1.5 - 4.5
            x(i)  = d1
            y(i)  = f(d1)
            yd(i) = fd(d1)
        Next

	    '差分商の表を作る
        Dim z(Nx2)      As Double
        Dim d(Nx2, Nx2) As Double
	    For i As Integer = 0 To Nx2
			Dim j As Integer = i \ 2
	        z(i)   = x(j)
	        d(0,i) = y(j)
        Next

	    For i As Integer = 1 To Nx2
	        For j As Integer = 0 To (Nx2 - i)
	            If i = 1 AndAlso j mod 2 = 0 Then
	                d(i,j) = yd(j \ 2)
	            Else
	            	d(i,j) = (d(i-1,j+1) - d(i-1,j)) / (z(j+i) - z(j))
				End If
	        Next
        Next

	    'ｎ階差分商
        Dim a(Nx2) As Double
	    For j As Integer = 0 To Nx2
	        a(j) = d(j,0)
        Next

        '0.5刻みで 与えられていない値を補間 
        For i As Integer = 0 To 18
            Dim d1 As Double = i * 0.5 - 4.5
            Dim d2 As Double = f(d1)
            Dim d3 As Double = hermite(d1, z, a)

            '元の関数と比較
            Console.WriteLine(string.Format("{0,5:F2}{4}{1,8:F5}{4}{2,8:F5}{4}{3,8:F5}", d1, d2, d3, d2 - d3, vbTab))
        Next
    End Sub

    '元の関数
    Private Function f(ByVal x As Double) As Double
        Return x - (x ^ 3) / (3 * 2) + (x ^ 5) / (5 * 4 * 3 * 2)
    End Function
    '導関数
    Private Function fd(ByVal x As Double) As Double
        Return 1 - (x ^ 2) / 2 + (x ^ 4) / (4 * 3 * 2)
    End Function

    'Hermite (エルミート) 補間
    Private Function hermite(ByVal d As Double, ByVal z() As Double, ByVal a() As Double) As Double
        Dim sum As Double = a(0)
        For i As Integer = 1 To Nx2
            Dim prod As Double = a(i)
            For j As Integer = 0 To (i - 1)
                prod *= (d - z(j))
            Next
            sum += prod
        Next
        Return sum
    End Function
End Module
