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
    Dim d2: d2 = neville(d, x, y)

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

'Neville (�l���B��) ���
Private Function neville(ByVal d, ByVal x(), ByVal y())
    Dim w(): ReDim w(N, N)
	Dim i
    For i = 0 To N
        w(0,i) = y(i)
	Next

	Dim j
    For j = 1 To N
        For i = 0 To N - j
			w(j,i) = w(j-1,i+1) + (w(j-1,i+1) - w(j-1,i)) * (d - x(i+j)) / (x(i+j) - x(i))
		Next
	Next

    neville = w(N,0)
End Function
