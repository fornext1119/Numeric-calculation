Option Explicit

Private Const N  = 3
Private Const PI = 3.14159265358979

'���R�r�@�ŌŗL�l�����߂�
Call Main

Private Sub Main()
	Dim a: a = Array(_
	           Array(5.0, 4.0, 1.0, 1.0), _
	           Array(4.0, 5.0, 1.0, 1.0), _
	           Array(1.0, 1.0, 4.0, 2.0), _
	           Array(1.0, 1.0, 2.0, 4.0))

	Dim v: v = Array(_
               Array(1.0 ,0.0 ,0.0 ,0.0), _
               Array(0.0 ,1.0 ,0.0 ,0.0), _
               Array(0.0 ,0.0 ,1.0 ,0.0), _
               Array(0.0 ,0.0 ,0.0 ,1.0))

	'���R�r�@
	Call jacobi(a, v)

	WScript.StdOut.WriteLine
	WScript.StdOut.WriteLine "eigenvalue"
	Call disp_eigenvalue(a)

	WScript.StdOut.WriteLine
	WScript.StdOut.WriteLine "eigenvector"
	Call disp_eigenvector(v)
End Sub

'���R�r�@
Private Sub jacobi(ByRef a, ByRef v)
    Dim i, j, k
    Dim max_val
    Dim p, q
    For k = 1 To 100
        '�ő�l��T��
        max_val = 0.0
        For i = 0 To N
            For j = i + 1 To N
                If (max_val < Abs(a(i)(j))) Then
                    max_val = Abs(a(i)(j))
                    p = i
                    q = j
                End If
            Next
        Next

        '�� �����߂�
        Dim t
        If Abs(a(p)(p) - a(q)(q)) < 0.00000000001 Then
            'a_{pp} �� a_{qq} �̂Ƃ��A��]�p������/4�ɂ���
            t = PI / 4.0
			If (a(p)(p) < 0) Then
				t = -t
			End If
        Else
            'a_{pp} �� a_{qq} �̂Ƃ�
            t = Atn(2.0 * a(p)(q) / (a(p)(p) - a(q)(q))) / 2.0
        End If

        '�� ���g���� �s�� U ���쐬���AA = U^t �~ A �~ U
        Dim c: c = Cos(t)
        Dim s: s = Sin(t)
        'U^t �~ A
        Dim t1, t2
        For i = 0 To N
            t1 =  a(p)(i) * c + a(q)(i) * s
            t2 = -a(p)(i) * s + a(q)(i) * c
            a(p)(i) = t1
            a(q)(i) = t2
            '�ŗL�x�N�g��
            t1 =  v(p)(i) * c + v(q)(i) * s
            t2 = -v(p)(i) * s + v(q)(i) * c
            v(p)(i) = t1
            v(q)(i) = t2
        Next
        'A �~ U
        For i = 0 To N
            t1 =  a(i)(p) * c + a(i)(q) * s
            t2 = -a(i)(p) * s + a(i)(q) * c
            a(i)(p) = t1
            a(i)(q) = t2
        Next

        '�s��̑Ίp�v�f��\�� (�ŗL�l)
        WScript.StdOut.Write Right(Space(3) & k, 3) & vbTab
        Call disp_eigenvalue(a)

        '��������
       If max_val < 0.00000000001 Then Exit For
    Next
End Sub

'�s��̑Ίp�v�f��\��
Private Sub disp_eigenvalue(ByVal x)
    Dim i
    For i = 0 To N
        WScript.StdOut.Write Right(Space(14) & FormatNumber(x(i)(i), 10, -1, 0, 0), 14) & vbTab
    Next
    WScript.StdOut.WriteLine
End Sub
'�ŗL�x�N�g����\��
Private Sub disp_eigenvector(ByVal matrix)
    Dim row, col
    For Each row In matrix
        normarize(row)
        disp_vector(row)
        WScript.StdOut.WriteLine
    Next
End Sub
'�P�����z���\��
Private Sub disp_vector(ByVal row)
    Dim col
    For Each col In row
        WScript.StdOut.Write Right(Space(14) & FormatNumber(col, 10, -1, 0, 0), 14) & vbTab
    Next
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
