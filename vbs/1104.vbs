Option Explicit

Private Const N = 3

'QR分解で固有値を求める
Call Main

Private Sub Main()
	Dim a: a = Array(_
	           Array(5.0, 4.0, 1.0, 1.0), _
	           Array(4.0, 5.0, 1.0, 1.0), _
	           Array(1.0, 1.0, 4.0, 2.0), _
	           Array(1.0, 1.0, 2.0, 4.0))

	Dim q: q = Array(_
	           Array(0.0, 0.0, 0.0, 0.0), _
	           Array(0.0, 0.0, 0.0, 0.0), _
	           Array(0.0, 0.0, 0.0, 0.0), _
	           Array(0.0, 0.0, 0.0, 0.0))

	Dim r: r = Array(_
	           Array(0.0, 0.0, 0.0, 0.0), _
	           Array(0.0, 0.0, 0.0, 0.0), _
	           Array(0.0, 0.0, 0.0, 0.0), _
	           Array(0.0, 0.0, 0.0, 0.0))

    Dim i, j, k
    For k = 1 To 200
        'QR分解
        Call decomp(a, q, r)
        '行列の積
        Call multiply(r, q, a)
        '対角要素を表示
        WScript.StdOut.Write Right(Space(3) & k, 3) & vbTab
        Call disp_eigenvalue(a)

        '収束判定
        Dim e: e = 0.0
        For i = 1 To N
            For j = 0 To i - 1
                e = e + Abs(a(i)(j))
            Next
        Next
       If e < 0.00000000001 Then Exit For
    Next

	WScript.StdOut.WriteLine
	WScript.StdOut.WriteLine "eigenvalue"
	Call disp_eigenvalue(a)
End Sub

'対角要素を表示
Private Sub disp_eigenvalue(ByVal a)
    Dim i
    For i = 0 To N
        WScript.StdOut.Write Right(Space(14) & FormatNumber(a(i)(i), 10, -1, 0, 0), 14) & vbTab
    Next
	WScript.StdOut.WriteLine
End Sub

'QR分解
Private Sub decomp(ByRef a, ByRef q, ByRef r)
    Dim x: x = Array(0.0, 0.0, 0.0, 0.0)

    Dim k
    For k = 0 To N
        Dim i
        For i = 0 To N
            x(i) = a(i)( k)
        Next
        Dim j
        For j = 0 To k - 1
            Dim t: t = 0
            For i = 0 To N
                t = t + a(i)(k) * q(i)(j)
            Next
            r(j)(k) = t
            r(k)(j) = 0
            For i = 0 To N
                x(i) = x(i) - t * q(i)(j)
            Next
        Next

        t = 0
        For i = 0 To N
            t = t + x(i) * x(i)
        Next
        r(k)(k) = Sqr(t)
        For i = 0 To N
            q(i)(k) = x(i) / r(k)(k)
        Next
    Next
End Sub

'行列の積
Private Sub multiply(ByRef a, ByRef b, ByRef c)
    Dim i
    For i = 0 To N
        Dim j
        For j = 0 To N
            Dim s: s = 0.0
            Dim k
            For k = 0 To N
                s = s + a(i)(k) * b(k)(j)
            Next
            c(i)(j) = s
        Next
    Next
End Sub
