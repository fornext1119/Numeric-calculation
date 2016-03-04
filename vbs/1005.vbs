Option Explicit

Private Const N = 4

Private a: a = Array(Array(-1,-2,7,-2),Array(1,-1,-2,6),Array(9,2,1,1),Array(2,8,-2,1))
Private b: b = Array(8,17,20,16)

'�s�{�b�g�I��
pivoting a,b

WScript.StdOut.WriteLine "pivoting"
WScript.StdOut.WriteLine "A"
disp_matrix a
WScript.StdOut.WriteLine "B"
disp_vector b
WScript.StdOut.WriteLine

'�O�i����
forward_elimination a,b

WScript.StdOut.WriteLine "LU"
disp_matrix a

'Ly=b ���� y �����߂� (�O�i���)
Private y: y = Array(0.0,0.0,0.0,0.0)
forward_substitution a,b,y

WScript.StdOut.WriteLine "Y"
disp_vector y

'Ux=y ���� x �����߂� (��ޑ��)
Private x: x = Array(0.0,0.0,0.0,0.0)
backward_substitution a,y,x

WScript.StdOut.WriteLine "X"
disp_vector x

'�O�i����
Private Sub forward_elimination(ByRef a, ByVal b)
    Dim pivot, row, col
    For pivot = 0 To (N - 2)
        For row = (pivot + 1) To (N - 1)
            Dim s: s = a(row)(pivot) / a(pivot)(pivot)
            For col = pivot To (N - 1)
                a(row)(col) = a(row)(col) - a(pivot)(col) * s '���ꂪ ��O�p�s��
            Next
            a(row)(pivot) = s                                 '���ꂪ ���O�p�s��
            'b(row) = b(row) - b(pivot) * s                   '���̒l�͕ύX���Ȃ�
        Next
    Next
End Sub
'�O�i���
Private Sub forward_substitution(ByVal a, ByVal b, ByRef y)
    Dim row, col
    For row = 0 To (N - 1)
        For col = 0 To row
            b(row) = b(row) - a(row)(col) * y(col)
        Next
        y(row) = b(row)
    Next
End Sub
'��ޑ��
Private Sub backward_substitution(ByVal a, ByVal y, ByRef x)
    Dim row, col
    For row = (N - 1) To 0 Step -1
        For col = (N - 1) To (row + 1) Step - 1
            y(row) = y(row) - a(row)(col) * x(col)
        Next
        x(row) = y(row) / a(row)(row)
    Next
End Sub
'�s�{�b�g�I��
Private Sub pivoting(ByRef a, ByRef b)
    Dim pivot, row, col
    For pivot = 0 To (N - 1)
        '�e��� ��Ԓl���傫���s�� �T��
        Dim max_row: max_row =   pivot
        Dim max_val: max_val =   0
        For row = pivot To (N - 1)
            If Abs(a(row)(pivot)) > max_val Then
                '��Ԓl���傫���s
                max_val =   Abs(a(row)(pivot))
                max_row =   row
            End If
        Next

        '��Ԓl���傫���s�Ɠ���ւ�
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
'�P�����z���\��
Private Sub disp_vector(ByVal row())
    Dim col
    For Each col In row
        WScript.StdOut.Write Right(Space(14) & FormatNumber(col, 10, -1, 0, 0), 14) & vbTab
    Next
    WScript.StdOut.WriteLine
End Sub
'�Q�����z���\��
Private Sub disp_matrix(ByVal matrix)
    Dim row, col
    For Each row In matrix
        For Each col In row
            WScript.StdOut.Write Right(Space(14) & FormatNumber(col, 10, -1, 0, 0), 14) & vbTab
        Next
        WScript.StdOut.WriteLine
    Next
End Sub
