Option Explicit

Private Const N = 3

'LR分解で固有値を求める
Call Main

Private Sub Main()
	Dim a: a = Array(_
	           Array(5.0, 4.0, 1.0, 1.0), _
	           Array(4.0, 5.0, 1.0, 1.0), _
	           Array(1.0, 1.0, 4.0, 2.0), _
	           Array(1.0, 1.0, 2.0, 4.0))

	Dim l: l = Array(_
	           Array(0.0, 0.0, 0.0, 0.0), _
	           Array(0.0, 0.0, 0.0, 0.0), _
	           Array(0.0, 0.0, 0.0, 0.0), _
	           Array(0.0, 0.0, 0.0, 0.0))

	Dim u: u = Array(_
	           Array(0.0, 0.0, 0.0, 0.0), _
	           Array(0.0, 0.0, 0.0, 0.0), _
	           Array(0.0, 0.0, 0.0, 0.0), _
	           Array(0.0, 0.0, 0.0, 0.0))

    Dim i, j, k
    For k = 1 To 200
	    'LU分解
	    Call decomp(a, l, u)
        '行列の積
        Call multiply(u, l, a)
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

'LU分解
Private Sub decomp(ByRef a, ByRef l, ByRef u)
    Dim i
    For i = 0 To N
        Dim j
        For j = 0 To N
            l(i)(j) = 0.0
            u(i)(j) = 0.0
        Next
    Next

    l(0)(0) = 1.0
    For j = 0 To N
        u(0)(j) = a(0)(j)
    Next

    For i = 1 To N
        u(i)(0) = 0.0
        l(0)(i) = 0.0
        l(i)(0) = a(i)(0) / u(0)(0)
    Next
    For i = 1 To N
        l(i)(i) = 1.0
        Dim t: t = a(i)(i)
        Dim k
        For k = 0 To i
            t = t - l(i)(k) * u(k)(i)
        Next
        u(i)(i) = t
        For j = i + 1 To N
            u(j)(i) = 0.0
            l(i)(j) = 0.0
            t = a(j)(i)
            For k = 0 To i
                t = t - l(j)(k) * u(k)(i)
            Next
            l(j)(i) = t / u(i)(i)
            t = a(i)(j)
            For k = 0 To i
                t = t - l(i)(k) * u(k)(j)
            Next
            u(i)(j) = t
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
