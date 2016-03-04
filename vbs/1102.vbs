Option Explicit

Private Const N = 3

'�t�x�L��@�ōŏ��ŗL�l�����߂�
Call Main

Private Sub Main()
	Dim a: a = Array(_
	           Array(5.0, 4.0, 1.0, 1.0), _
	           Array(4.0, 5.0, 1.0, 1.0), _
	           Array(1.0, 1.0, 4.0, 2.0), _
	           Array(1.0, 1.0, 2.0, 4.0))

	Dim x: x = Array(1.0 ,0.0 ,0.0 ,0.0)

	'LU����
	Call forward_elimination(a)

	'�t�x�L��@
	Dim lambda: lambda = inverse(a, x)

	WScript.StdOut.WriteLine
	WScript.StdOut.WriteLine "eigenvalue"
    WScript.StdOut.WriteLine Right(Space(14) & FormatNumber(lambda, 10, -1, 0, 0), 14)

	WScript.StdOut.WriteLine "eigenvector"
    Call disp_vector(x)
End Sub

'�t�x�L��@
Private Function inverse(ByVal a, ByRef x0)
    Dim i, j, k

    Dim lambda: lambda = 0.0

    '���K�� (�x�N�g�� x0 �̒������P�ɂ���)
    Call normarize(x0)
    Dim e0: e0 = 0.0
    For i = 0 To N
        e0 = e0 + x0(i)
    Next

    For k = 1 To 200
        '�P�����z���\��
        WScript.StdOut.Write Right(Space(3) & k, 3) & vbTab
        Call disp_vector(x0)

        'Ly = b ���� y �����߂� (�O�i���)
        Dim y: y = Array(0.0, 0.0, 0.0, 0.0)
        Call forward_substitution(a,y,x0)

        'Ux = y ���� x �����߂� (��ޑ��)
        Dim x1: x1 = Array(0.0, 0.0, 0.0, 0.0)
        Call backward_substitution(a,x1,y)

        '����
        Dim p0: p0 = 0.0
        Dim p1: p1 = 0.0
        For i = 0 To N
            p0 = p0 + x1(i) * x1(i)
            p1 = p1 + x1(i) * x0(i)
        Next
        '�ŗL�l
        lambda = p1 / p0

	    '���K�� (�x�N�g�� x1 �̒������P�ɂ���)
	    Call normarize(x1)
        '��������
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

'LU����
Private Sub forward_elimination(ByRef a)
    Dim pivot, row, col
    For pivot = 0 To (N - 1)
        For row = (pivot + 1) To N
            Dim s: s = a(row)(pivot) / a(pivot)(pivot)
            For col = pivot To N
                a(row)(col) = a(row)(col) - a(pivot)(col) * s '���ꂪ ��O�p�s��
            Next
            a(row)(pivot) = s                                 '���ꂪ ���O�p�s��
        Next
    Next
End Sub
'�O�i��� (Ly = b ���� y �����߂�)
Private Sub forward_substitution(ByVal a, ByRef y, ByVal b)
    Dim row, col
    For row = 0 To N
        For col = 0 To row
            b(row) = b(row) - a(row)(col) * y(col)
        Next
        y(row) = b(row)
    Next
End Sub
'��ޑ�� (Ux = y ���� x �����߂�)
Private Sub backward_substitution(ByVal a, ByRef x, ByVal y)
    Dim row, col
    For row = N To 0 Step -1
        For col = N To (row + 1) Step - 1
            y(row) = y(row) - a(row)(col) * x(col)
        Next
        x(row) = y(row) / a(row)(row)
    Next
End Sub

'�P�����z���\��
Private Sub disp_vector(ByVal row)
    Dim col
    For Each col In row
        WScript.StdOut.Write Right(Space(14) & FormatNumber(col, 10, -1, 0, 0), 14) & vbTab
    Next
	WScript.StdOut.WriteLine
End Sub

'���K�� (�x�N�g���̒������P�ɂ���)
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
