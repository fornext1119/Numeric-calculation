Option Explicit

'�f�[�^�_�̐� - 1
Private Const N = 6

Dim x(): ReDim x(N)
Dim y(): ReDim y(N)

'1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
Dim i
For i = 0 To N
    Dim d: d = i * 1.5 - 4.5
    x(i) = d
    y(i) = f(d)
Next

'0.5���݂� �^�����Ă��Ȃ��l���� 
For i = 0 To 18
    d = i * 0.5 - 4.5
    Dim d1: d1 = f(d)
    Dim d2: d2 = lagrange(d, x, y)

    '���̊֐��Ɣ�r
    WScript.StdOut.Write     Right(Space(5) & FormatNumber(d,       2, -1, 0, 0), 5) & vbTab
    WScript.StdOut.Write     Right(Space(8) & FormatNumber(d1,      5, -1, 0, 0), 8) & vbTab
    WScript.StdOut.Write     Right(Space(8) & FormatNumber(d2,      5, -1, 0, 0), 8) & vbTab
    WScript.StdOut.WriteLine Right(Space(8) & FormatNumber(d1 - d2, 5, -1, 0, 0), 8)
Next

'���̊֐�
Private Function f(ByVal x)
    f = x - (x ^ 3) / (3 * 2) + (x ^ 5) / (5 * 4 * 3 * 2)
End Function

'Lagrange (���O�����W��) ���
Private Function lagrange(ByVal d, ByVal x(), ByVal y())
    Dim sum: sum = 0
	Dim i, j
    For i = 0 To N
        Dim prod: prod = y(i)
        For j = 0 To N
            If j <> i Then
                prod = prod * (d - x(j)) / (x(i) - x(j))
            End If
        Next
        sum = sum + prod
    Next
    lagrange = sum
End Function
