Option Explicit

Private Const N = 4

Private a: a = Array(Array(9,2,1,1),Array(2,8,-2,1),Array(-1,-2,7,-2),Array(1,-1,-2,6))
Private b: b = Array(20,16,8,17)
Private c: c = Array(0,0,0,0)

'ヤコビの反復法
jacobi a,b,c

WScript.StdOut.WriteLine "X"
disp_vector c

'ヤコビの反復法
Private Sub jacobi(ByVal a, ByVal b, ByRef x0)
    Do While(True)
        Dim x1: x1 = Array(0,0,0,0)
        Dim finish: finish = True
        Dim i, j
        For i = 0 To (N - 1)
            x1(i) = 0
            For j = 0 To (N - 1)
                If i <> j Then
                    x1(i) = x1(i) + a(i)(j) * x0(j)
                End If
            Next
            x1(i) = (b(i) - x1(i)) / a(i)(i)
            If (Abs(x1(i) - x0(i)) > 0.0000000001) Then
                finish = False
            End If
        Next
        For i = 0 To (N - 1)
            x0(i) = x1(i)
        Next
        If (finish) Then
            Exit Sub
        End If

        disp_vector x0
    Loop
End Sub

'１次元配列を表示
Private Sub disp_vector(ByVal row())
    Dim col
    For Each col In row
        WScript.StdOut.Write Right(Space(14) & FormatNumber(col, 10, -1, 0, 0), 14) & vbTab
    Next
    WScript.StdOut.WriteLine
End Sub
