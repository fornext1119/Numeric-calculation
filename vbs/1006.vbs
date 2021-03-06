Option Explicit

Private Const N = 4

Private a: a = Array(Array(5.0,2.0,3.0,4.0),Array(2.0,10.0,6.0,7.0),Array(3.0,6.0,15.0,9.0),Array(4.0,7.0,9.0,20.0))
Private b: b = Array(34.0,68.0,96.0,125.0)

WScript.StdOut.WriteLine "A"
disp_matrix a
WScript.StdOut.WriteLine "B"
disp_vector b
WScript.StdOut.WriteLine

'前進消去
forward_elimination a,b

WScript.StdOut.WriteLine "LL^T"
disp_matrix a

'Ly=b から y を求める (前進代入)
Private y: y = Array(0.0,0.0,0.0,0.0)
forward_substitution a,b,y

WScript.StdOut.WriteLine "Y"
disp_vector y

'L^Tx=y から x を求める (後退代入)
Private x: x = Array(0.0,0.0,0.0,0.0)
backward_substitution a,y,x

WScript.StdOut.WriteLine "X"
disp_vector x

'前進消去
Private Sub forward_elimination(ByRef a, ByVal b)
    Dim pivot, row, col
    For pivot = 0 To (N - 1)
        Dim s: s = 0
        For col = 0 To (pivot - 1)
            s = s + a(pivot)(col) * a(pivot)(col)
        Next
        'ここで根号の中が負の値になると計算できない！
        a(pivot)(pivot) = Sqr(a(pivot)(pivot) - s)
        
        For row = (pivot + 1) To (N - 1)
            s = 0
            For col = 0 To (pivot - 1)
                s = s + a(row)(col) * a(pivot)(col)
            Next
            a(row)(pivot) = (a(row)(pivot) - s) / a(pivot)(pivot)
            a(pivot)(row) = a(row)(pivot)
        Next
    Next
End Sub
'前進代入
Private Sub forward_substitution(ByVal a, ByVal b, ByRef y)
    Dim row, col
    For row = 0 To (N - 1)
        For col = 0 To row
            b(row) = b(row) - a(row)(col) * y(col)
        Next
        y(row) = b(row) / a(row)(row)
    Next
End Sub
'後退代入
Private Sub backward_substitution(ByVal a, ByVal y, ByRef x)
    Dim row, col
    For row = (N - 1) To 0 Step -1
        For col = (N - 1) To (row + 1) Step - 1
            y(row) = y(row) - a(row)(col) * x(col)
        Next
        x(row) = y(row) / a(row)(row)
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
Private Sub disp_matrix(ByVal matrix)
    Dim row, col
    For Each row In matrix
        For Each col In row
            WScript.StdOut.Write Right(Space(14) & FormatNumber(col, 10, -1, 0, 0), 14) & vbTab
        Next
        WScript.StdOut.WriteLine
    Next
End Sub
