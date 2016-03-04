Option Explicit

'Private a: a = Array(Array(11.0, 7.0, -5.0),Array(0.0, 10.0, -1.0 ),Array(2.0, 8.0, 3.0))
'Private a: a = Array(Array(1.0, 7.0, -5.0),Array(0.0, 2.0, -1.0 ),Array(2.0, 8.0, 3.0))
'Private a: a = Array(Array(2.0, 2.0, -1.0),Array(0.0, -1.0, 0.0 ),Array(0.0, -5.0, 3.0))
'Private a: a = Array(Array(1.0, 0.0, 0.0),Array(0.0, 2.0, 0.0 ),Array(0.0, 0.0, 3.0))
'Private a: a = Array(Array(7.0, 0.0, 0.0),Array(0.0, 8.0, 0.0 ),Array(0.0, 0.0, 9.0))
'Private x: x = Array(1.0, 1.0, 1.0)

Const N = 2
Private a: a = Array(Array(2.0, -1.0, -2.0),Array(2.0, 5.0, 2.0 ),Array(-3.0, -3.0, 1.0))
Private x: x = Array(1.0, 1.0, 1.0)

'Const N = 3
'Private a: a = Array(Array(5.0, 4.0, 1.0, 1.0),Array(4.0, 5.0, 1.0, 1.0),Array(1.0, 1.0, 4.0, 2.0),Array(1.0, 1.0, 2.0, 4.0))
'Private x: x = Array(1.0, 1.0, 1.0, 1.0)
'Private y: y = Array(0.0, 0.0, 0.0, 0.0)

'Const N = 3
'Private a: a = Array(Array(5.0, 4.0, 1.0, 1.0), Array(4.0, 5.0, 1.0, 1.0), Array(1.0, 1.0, 4.0, 2.0), Array(1.0, 1.0, 2.0, 4.0))
'Private x: x = Array(1.0, 1.0, 1.0, 1.0)

'ベキ乗法 Power iteration
Call power(a, x)

'１次元配列を表示
Private Sub disp_vector(ByVal row)
    Dim col
    For Each col In row
        WScript.StdOut.Write Right(Space(14) & FormatNumber(col, 10, -1, 0, 0), 14) & vbTab
    Next
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

'ベキ乗法
Private Sub power(ByVal a, ByRef x0)
    Dim i, j, k
    
    Dim lambda0: lambda0 = 0.0
    For k = 0 To 200
        '正規化 (ベクトル x0 の長さを１にする)
        Call normarize(x0)
        disp_vector(x0)

        '行列の積 x1 = A × x0 
		Dim x1: x1 = Array(0.0, 0.0, 0.0)
        For i = 0 To N
            For j = 0 To N
                x1(i) = x1(i) + a(i)(j) * x0(j)
            Next
        Next

        '内積 inner product
        Dim p0: p0 = 0.0
        Dim p1: p1 = 0.0
        For i = 0 To N
            p0 = p0 + x1(i) * x1(i)
            p1 = p1 + x1(i) * x0(i)
        Next
        
        '固有値 eigenvalue
        Dim lambda1: lambda1 = p0 / p1
        WScript.StdOut.Write " lambda = "
        WScript.StdOut.Write Right(Space(14) & FormatNumber(lambda1, 10, -1, 0, 0), 14) & vbNewLine

        '収束判定
        If Abs(lambda0 - lambda1) < 0.00000000001 Then Exit For
        lambda0 = lambda1

        For i = 0 To N
            x0(i) = x1(i)
        Next
    Next
End Sub
