Option Explicit

Private Const N  = 3

'ハウスホルダー変換とQR分解で固有値を求める
Call Main

Private Sub Main()
	Dim a: a = Array(_
	           Array(5.0, 4.0, 1.0, 1.0), _
	           Array(4.0, 5.0, 1.0, 1.0), _
	           Array(1.0, 1.0, 4.0, 2.0), _
	           Array(1.0, 1.0, 2.0, 4.0))

	Dim d: d = Array(0.0 ,0.0 ,0.0 ,0.0)
	Dim e: e = Array(0.0 ,0.0 ,0.0 ,0.0)

	'ハウスホルダー変換
	Call tridiagonalize(a, d, e)

	'QR分解
	Call decomp(a, d, e)

	WScript.StdOut.WriteLine
	WScript.StdOut.WriteLine "eigenvalue"
	Call disp_vector(d)

	WScript.StdOut.WriteLine
	WScript.StdOut.WriteLine "eigenvector"
	Call disp_matrix(a)
End Sub

'ハウスホルダー変換
Private Sub tridiagonalize(ByRef a, ByRef d, ByRef e)
    Dim v: v = Array(0.0 ,0.0 ,0.0 ,0.0)

    Dim i, j, k
    For k = 0 To N - 2
        d(k) = a(k)(k)

        Dim t: t = 0.0
        Dim w: w = Array(0.0, 0.0, 0.0, 0.0)
        For i = k + 1 To N
            w(i) = a(i)(k)
            t    = t + w(i) * w(i)
        Next

        Dim s: s = Sqr(t) 
        If w(k + 1) < 0 Then
            s = -s
        End If

        If Abs(s) < 0.00000000001 Then
            e(k + 1) = 0.0
        Else
            e(k + 1) = -s
            w(k + 1) = w(k + 1) + s
            s = 1 / Sqr(w(k + 1) * s)
            For i = k + 1 To N
                w(i) = w(i) * s
            Next

            For i = k + 1 To N
                s = 0.0
                For j = k + 1 To N
                    If j <= i Then
                        s = s + a(i)(j) * w(j)
                    Else
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
            '次の行は固有ベクトルを求めないなら不要
            For i = k + 1 To N
                a(i)(k) = w(i)
            Next
        End If 
    Next

    d(N - 1) = a(N - 1)(N - 1)
    d(N)     = a(N)(N)
    
    e(0)     = 0.0  
    e(N)     = a(N)(N - 1)
    
    '次の行は固有ベクトルを求めないなら不要
    For k = N To 0 Step -1
        If k < N - 1 Then
            For i = k + 1 To N
                w(i) = a(i)(k)
            Next
            For i = k + 1 To N
                s = 0.0
                For j = k + 1 To N
                    s = s + a(i)(j) * w(j)
                Next
                v(i) = s
            Next
            For i = k + 1 To N
                For j = k + 1 To N
                    a(i)(j) = a(i)(j) - v(i) * w(j)
                Next
            Next
        End If
        For i = 0 To N
            a(i)(k) = 0.0
        Next
        a(k)(k) = 1.0
    Next
End Sub

'QR分解
Private Sub decomp(ByRef a, ByRef d, ByRef e)
	Dim i, j, k

    e(0) = 1.0
    Dim h: h = N
    Do While (Abs(e(h)) < 0.00000000001)
        h = h - 1
    Loop

    Do While h > 0
        e(0) = 0.0
        Dim l: l = h - 1
        Do While (Abs(e(l)) >= 0.00000000001)
            l = l - 1
        Loop
        For j = 1 To 100
            Dim w: w = (d(h - 1) - d(h)) / 2.0
            Dim s: s = Sqr(w * w + e(h) * e(h))
            If w < 0.0 Then 
                s = - s
            End If

            Dim x: x = d(l) - d(h) + e(h) * e(h) / (w + s)
            Dim y: y = e(l + 1)
            Dim z: z = 0.0
            Dim t, u
            For k = l To h - 1
                If Abs(x) >= Abs(y) Then
                    t = -y / x  
                    u = 1 / Sqr(t * t + 1.0)  
                    s = t * u
                Else
                    t = -x / y
                    s = 1 / Sqr(t * t + 1.0)  
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
                For i = 0 To N
                    x = a(k    )(i)  
                    y = a(k + 1)(i)
                    a(k    )(i) = u * x - s * y  
                    a(k + 1)(i) = s * x + u * y
                Next

                If k < N - 1 Then
                    x = e(k + 1)  
                    y = -s * e(k + 2)  
                    z = y
                    e(k + 2) = u * e(k + 2)
                End If
            Next

	        WScript.StdOut.Write Right(Space(3) & j, 3) & vbTab
			Call disp_vector(d)

	        '収束判定
			If (Abs(e(h)) < 0.00000000001) Then Exit For
        Next

        e(0) = 1.0  
        Do While (Abs(e(h)) < 0.00000000001)
            h = h - 1
        Loop
    Loop

    '次の行は固有ベクトルを求めないなら不要
    For k = 0 To N - 1
        l = k
        For i = k + 1 To N 
            If d(i) > d(l) Then 
                l = i
            End If
        Next

        t    = d(k)  
        d(k) = d(l)  
        d(l) = t

		For i = 0 To N
	        t       = a(k)(i)  
	        a(k)(i) = a(l)(i)  
	        a(l)(i) = t
        Next
    Next
End Sub

'１次元配列を表示
Private Sub disp_vector(ByVal row())
    Dim col
    For Each col In row
        WScript.StdOut.Write Right(Space(14) & FormatNumber(col, 10, -1, 0, 0), 14) & vbTab
    Next
    WScript.StdOut.WriteLine
End Sub

'２次元配列を表示
Private Sub disp_matrix(ByVal matrix())
    Dim row, col
    For Each row In matrix
        For Each col In row
            WScript.StdOut.Write Right(Space(14) & FormatNumber(col, 10, -1, 0, 0), 14) & vbTab
        Next
        WScript.StdOut.WriteLine
    Next
End Sub
