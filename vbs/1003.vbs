Option Explicit

Private Const N = 4

Private a: a = Array(Array(-1,-2,7,-2),Array(1,-1,-2,6),Array(9,2,1,1),Array(2,8,-2,1))
Private b: b = Array(8,17,20,16)

'ピボット選択
pivoting a,b

WScript.StdOut.WriteLine "pivoting"
WScript.StdOut.WriteLine "A"
disp_matrix a
WScript.StdOut.WriteLine "B"
disp_vector b
WScript.StdOut.WriteLine

'前進消去
forward_elimination a,b

WScript.StdOut.WriteLine "forward elimination"
WScript.StdOut.WriteLine "A"
disp_matrix a
WScript.StdOut.WriteLine "B"
disp_vector b
WScript.StdOut.WriteLine

'後退代入
backward_substitution a,b

WScript.StdOut.WriteLine "X"
disp_vector b

'前進消去
Private Sub forward_elimination(ByRef a, ByRef b)
    Dim pivot, row, col
    For pivot = 0 To (N - 2)
        For row = (pivot + 1) To (N - 1)
            Dim s: s = a(row)(pivot) / a(pivot)(pivot)
            For col = pivot To (N - 1)
                a(row)(col) = a(row)(col) - a(pivot)(col) * s
            Next
            b(row) = b(row) - b(pivot) * s
        Next
    Next
End Sub
'後退代入
Private Sub backward_substitution(ByVal a, ByRef b)
    Dim row, col
    For row = (N - 1) To 0 Step -1
        For col = (N - 1) To (row + 1) Step - 1
            b(row) = b(row) - a(row)(col) * b(col)
        Next
        b(row) = b(row) / a(row)(row)
    Next
End Sub
'ピボット選択
Private Sub pivoting(ByRef a, ByRef b)
    Dim pivot, row, col
    For pivot = 0 To (N - 1)
        '各列で 一番値が大きい行を 探す
        Dim max_row: max_row =   pivot
        Dim max_val: max_val =   0
        For row = pivot To (N - 1)
            If Abs(a(row)(pivot)) > max_val Then
                '一番値が大きい行
                max_val =   Abs(a(row)(pivot))
                max_row =   row
            End If
        Next

        '一番値が大きい行と入れ替え
        If max_row <> pivot Then
            Dim tmp
            For col = 0 To (N - 1)
                tmp             =   a(max_row)(col)
                a(max_row)(col) =   a(pivot)(col)
                a(pivot)(col)   =   tmp
            Next
            tmp         =   b(max_row)
            b(max_row)  =   b(pivot)
            b(pivot)    =   tmp
        End If
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
