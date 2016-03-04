Option Explicit

Private Const N = 3

'�x�L��@�ōő�ŗL�l�����߂�
Call Main

Private Sub Main()
    Dim a: a = Array(_
               Array(5.0, 4.0, 1.0, 1.0), _
               Array(4.0, 5.0, 1.0, 1.0), _
               Array(1.0, 1.0, 4.0, 2.0), _
               Array(1.0, 1.0, 2.0, 4.0))

    Dim x: x = Array(1.0 ,0.0 ,0.0 ,0.0)

    '�x�L��@
    Dim lambda: lambda = power(a, x)

    WScript.StdOut.WriteLine
    WScript.StdOut.WriteLine "eigenvalue"
    WScript.StdOut.WriteLine Right(Space(14) & FormatNumber(lambda, 10, -1, 0, 0), 14)

    WScript.StdOut.WriteLine "eigenvector"
    Call disp_vector(x)
End Sub

'�x�L��@
Private Function power(ByVal a, ByRef x0)
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

        '�s��̐� x1 = A �~ x0 
        Dim x1: x1 = Array(0.0, 0.0, 0.0, 0.0)
        For i = 0 To N
            For j = 0 To N
                x1(i) = x1(i) + a(i)(j) * x0(j)
            Next
        Next

        '����
        Dim p0: p0 = 0.0
        Dim p1: p1 = 0.0
        For i = 0 To N
            p0 = p0 + x1(i) * x1(i)
            p1 = p1 + x1(i) * x0(i)
        Next
        '�ŗL�l
        lambda = p0 / p1

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

    power = lambda
End Function

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
