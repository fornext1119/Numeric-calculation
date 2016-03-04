Option Explicit

Private Const N = 3

'逆ベキ乗法で最小固有値を求める
Call Main

Private Sub Main()
	Dim a: a = Array(_
	           Array(5.0, 4.0, 1.0, 1.0), _
	           Array(4.0, 5.0, 1.0, 1.0), _
	           Array(1.0, 1.0, 4.0, 2.0), _
	           Array(1.0, 1.0, 2.0, 4.0))

	Dim x: x = Array(1.0 ,0.0 ,0.0 ,0.0)

	'LU分解
	Call forward_elimination(a)

	'逆ベキ乗法
	Dim lambda: lambda = inverse(a, x)

	WScript.StdOut.WriteLine
	WScript.StdOut.WriteLine "eigenvalue"
    WScript.StdOut.WriteLine Right(Space(14) & FormatNumber(lambda, 10, -1, 0, 0), 14)

	WScript.StdOut.WriteLine "eigenvector"
    Call disp_vector(x)
End Sub

'逆ベキ乗法
Private Function inverse(ByVal a, ByRef x0)
    Dim i, j, k

    Dim lambda: lambda = 0.0

    '正規化 (ベクトル x0 の長さを１にする)
    Call normarize(x0)
    Dim e0: e0 = 0.0
    For i = 0 To N
        e0 = e0 + x0(i)
    Next

    For k = 1 To 200
        '１次元配列を表示
        WScript.StdOut.Write Right(Space(3) & k, 3) & vbTab
        Call disp_vector(x0)

        'Ly = b から y を求める (前進代入)
        Dim y: y = Array(0.0, 0.0, 0.0, 0.0)
        Call forward_substitution(a,y,x0)

        'Ux = y から x を求める (後退代入)
        Dim x1: x1 = Array(0.0, 0.0, 0.0, 0.0)
        Call backward_substitution(a,x1,y)

        '内積
        Dim p0: p0 = 0.0
        Dim p1: p1 = 0.0
        For i = 0 To N
            p0 = p0 + x1(i) * x1(i)
            p1 = p1 + x1(i) * x0(i)
        Next
        '固有値
        lambda = p1 / p0

	    '正規化 (ベクトル x1 の長さを１にする)
	    Call normarize(x1)
        '収束判定
        Dim e1: e1 = 0.0
        For i = 0 To N
            e1 = e1 + x1(i)
        Next
        If Abs(e1 - e0) < 0.00000000001 Then Exit For

        x0 = x1
        e0 = e1
    Next

	inverse = lambda
End Function

'LU分解
Private Sub forward_elimination(ByRef a)
    Dim pivot, row, col
    For pivot = 0 To (N - 1)
        For row = (pivot + 1) To N
            Dim s: s = a(row)(pivot) / a(pivot)(pivot)
            For col = pivot To N
                a(row)(col) = a(row)(col) - a(pivot)(col) * s 'これが 上三角行列
            Next
            a(row)(pivot) = s                                 'これが 下三角行列
        Next
    Next
End Sub
'前進代入 (Ly = b から y を求める)
Private Sub forward_substitution(ByVal a, ByRef y, ByVal b)
    Dim row, col
    For row = 0 To N
        For col = 0 To row
            b(row) = b(row) - a(row)(col) * y(col)
        Next
        y(row) = b(row)
    Next
End Sub
'後退代入 (Ux = y から x を求める)
Private Sub backward_substitution(ByVal a, ByRef x, ByVal y)
    Dim row, col
    For row = N To 0 Step -1
        For col = N To (row + 1) Step - 1
            y(row) = y(row) - a(row)(col) * x(col)
        Next
        x(row) = y(row) / a(row)(row)
    Next
End Sub

'１次元配列を表示
Private Sub disp_vector(ByVal row)
    Dim col
    For Each col In row
        WScript.StdOut.Write Right(Space(14) & FormatNumber(col, 10, -1, 0, 0), 14) & vbTab
    Next
	WScript.StdOut.WriteLine
End Sub

'正規化 (ベクトルの長さを１にする)
Private Sub normarize(ByRef x())
    Dim s: s = 0.0

    Dim i
    For i = 0 To N
        s = s + x(i) * x(i)
    Next
    s = Sqr(s)
    
    For i = 0 To N
        x(i) = x(i) / s
    Next
End Sub
