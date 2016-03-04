'1.0 ,2.0 ,1.0 
'2.0 ,1.0 ,0.0 
'1.0 ,0.0 ,1.0 
'
'3.236 ,-1.236 ,1.000 

Option Explicit

Const PI = 3.1415926535

'Const N = 2
'Private a: a = Array(Array(1.0 ,2.0 ,1.0),Array(2.0 ,1.0 ,0.0),Array(1.0 ,0.0 ,1.0))
'Private v: v = Array(Array(1.0 ,0.0 ,0.0),Array(0.0 ,1.0 ,0.0),Array(0.0 ,0.0 ,1.0))

Const N = 2
Private a: a = Array(Array(1.0 ,-2.0 ,-2.0),Array(-2.0 ,2.0 ,0.0),Array(-2.0 ,0.0 ,0.0))

'Const N = 3
'Private a: a = Array(Array(5.0 ,4.0 ,1.0 ,1.0),Array(4.0 ,5.0 ,1.0 ,1.0),Array(1.0 ,1.0 ,4.0 ,2.0),Array(1.0 ,1.0 ,2.0 ,4.0))
'Private v: v = Array(Array(1.0 ,0.0 ,0.0 ,0.0),Array(0.0 ,1.0 ,0.0 ,0.0),Array(0.0 ,0.0 ,1.0 ,0.0),Array(0.0 ,0.0 ,0.0 ,1.0))

disp_matrix a

'ハウスホルダー法
Call householder(a)

WScript.StdOut.WriteLine "三重対角化"
disp_matrix a

'WScript.StdOut.WriteLine "固有ベクトル"
'Call disp_eigen_vector(v)
'disp_eigen_vector a

'行列の対角要素を表示
Private Sub disp_diagonal_element(ByVal x)
    Dim i
    For i = 0 To N
        WScript.StdOut.Write Right(Space(14) & FormatNumber(x(i)(i), 10, -1, 0, 0), 14) & vbTab
    Next
    WScript.StdOut.WriteLine ""
End Sub
'固有ベクトルを表示
Private Sub disp_eigen_vector(ByVal matrix)
    Dim row, col
    For Each row In matrix
        Dim min_val:min_val = 10.0
        For Each col In row
            If Abs(col) > 0.00000000001 Then
                If Abs(col) < min_val Then
                    min_val = Abs(col)
                End If
            End If
        Next
        For Each col In row
            If Abs(col) > 0.00000000001 Then
                WScript.StdOut.Write Right(Space(14) & FormatNumber(col / min_val, 10, -1, 0, 0), 14) & vbTab
            Else
                WScript.StdOut.Write Right(Space(14) & FormatNumber(0            , 10, -1, 0, 0), 14) & vbTab
            End If
        Next
        WScript.StdOut.WriteLine
    Next
End Sub
'２次元配列を表示
Private Sub disp_matrix(ByVal matrix)
    Dim row, col
    For Each row In matrix
        For Each col In row
            WScript.StdOut.Write Right(Space(14) & FormatNumber(col, 10, -1, 0, 0), 14) & vbTab
        Next
        WScript.StdOut.WriteLine
    Next
End Sub

'ハウスホルダー法
Private Sub householder(ByRef a)
        '内積
        Dim p: p = 0.0
        For i = 0 To N
            p = p + x(i) * x(i)
        Next
        '内積の平方根
    	Dim s: s = 0.0
		If p <> 0.0 Then
			s = Sqr(p)
			If x(0) < 0.0 Then
				s = -s
			End If
			x(0) = x(0) + s
			t = 1 / Sqr(x(0) * s)
			For i = 0 To N
				x(i) = x(i) * t
			Next
		End If





    Dim i, j, k
    Dim s
	'対角成分
	Dim d: d = Array(0.0 ,0.0 ,0.0 ,0.0)
	'対角成分の隣
	Dim e: e = Array(0.0 ,0.0 ,0.0 ,0.0)

	Dim v: v = Array(0.0 ,0.0 ,0.0 ,0.0)
	Dim w: w = Array(0.0 ,0.0 ,0.0 ,0.0)



	For i = N To 2 Step -1
		Dim l:l = i - 1
		Dim h:h = 0.0
		Dim scalse: scalse = 0.0
		If l <= 1 Then
			e(k) = a(k)(k)

	For k = 0 To N - 2
		d(k) = A(k)(k)

		s = 0
		For i = k + 1 To N
			w(i) = a(i)(k)
			s    = s + w(i) * w(i)
		Next
		If s = 0 Then
			e(k + 1) = 0
		Else
			If w(k + 1) >= 0 Then 
				s = Sqr(s) 
			Else 
				s = -Sqr(s)
			End If
			e(k + 1) = -s  
			w(k + 1) = w(k + 1) + s
			s = 1 / Sqr(w(k + 1) * s)
			For i = k + 1 To N 
				w(i) = w(i) * s
			Next
			For i = k + 1 to N
				s = 0
				For j = k + 1 To N
					If j < i Then
						s = s + a(i)(j) * w(j)
					ElseIf j > i Then
						s = s + a(j)(i) * w(j)
					End If
				Next
				v(i) = s
			Next

			s = 0
			For i = k + 1 To N
				s = s + w(i) * v(i)
			Next
			s = s / 2
			For i = k + 1 To N
				v(i) = v(i) - s * w(i)
			Next
			For i = k + 1 To N
				For j = k + 1 To i
					a(i)(j) = a(i)(j) - w(i) * v(j) - w(j) * v(i)
				Next
			Next
			'固有ベクトル
'			For i = k + 1 To N
'				a(i)(k) = w(i)
'			Next
		End If
	Next
	d(N - 1) = a(N - 1)(N - 1)
	d(N)     = a(N)(N)
	e(1)     = 0
	e(N)     = a(N)(N - 1)
	'固有ベクトル
'	For k = N To 0 Step -1
'		If k < N - 1 Then
'			For i = k + 1 To N
'				w(i) = a(i)(k)
'			Next
'			For i = k + 1 To N
'				s = 0
'				For j = k + 1 To N
'					s = s + a(i)(j) * w(j)
'				Next
'				v(i) = s
'			Next
'			For i = k + 1 To N
'				For j = k + 1 To N
'					a(i)(j) = a(i)(j) - v(i) * w(j)
'				Next
'			Next
'		End If
'		For i = 0 To N
'			a(i)(k) = 0
'		Next
'		a(k)(k) = 1
'	Next



'    For k = 1 To 200
'        '最大値を探す
'        max_val = 0.0
'        For i = 0 To N
'            For j = i + 1 To N
'                If (max_val < Abs(a(i)(j))) Then
'                    max_val = Abs(a(i)(j))
'                    p = i
'                    q = j
'                End If
'            Next
'        Next
'
'        'θ を求める
'        Dim t
'        If (a(p)(p) = a(q)(q)) Then
'            'a_{pp} ≠ a_{qq} のとき
'            t = Sgn(a(p)(q)) * PI / 4.0
'        Else
'            'a_{pp} ＝ a_{qq} のとき
'            t = Atn(2.0 * a(p)(q) / (a(p)(p) - a(q)(q))) / 2.0
'        End If
'
'        'θ を使って 行列 U を作成し、A = U^t × A × U
'        Dim c: c = Cos(t)
'        Dim s: s = Sin(t)
'        'U^t × A
'        Dim t1, t2
'        For i = 0 To N
'            t1 =  a(p)(i) * c + a(q)(i) * s
'            t2 = -a(p)(i) * s + a(q)(i) * c
'            a(p)(i) = t1
'            a(q)(i) = t2
'            '固有ベクトル
'            t1 =  v(p)(i) * c + v(q)(i) * s
'            t2 = -v(p)(i) * s + v(q)(i) * c
'            v(p)(i) = t1
'            v(q)(i) = t2
'        Next
'        'A × U
'        For i = 0 To N
'            t1 =  a(i)(p) * c + a(i)(q) * s
'            t2 = -a(i)(p) * s + a(i)(q) * c
'            a(i)(p) = t1
'            a(i)(q) = t2
'        Next
'
'        '行列の対角要素を表示
'        Call disp_diagonal_element(a)
'
'        '収束判定
'        If max_val < 0.00000000001 Then Exit For
'    Next
End Sub
