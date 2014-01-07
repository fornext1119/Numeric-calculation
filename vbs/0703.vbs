Option Explicit

'�f�[�^�_�̐� - 1
Private Const N = 6

Dim x(): ReDim x(N)
Dim y(): ReDim y(N)

'1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
Dim i
For i = 0 To N
    Dim d1: d1 = i * 1.5 - 4.5
    x(i) = d1
    y(i) = f(d1)
Next

'�������̕\�����
Dim d(): ReDim d(N, N)
Dim j
For j = 0 To N
    d(0,j) = y(j)
Next

For i = 1 To N
    For j = 0 To (N - i)
        d(i,j) = (d(i-1,j+1) - d(i-1,j)) / (x(j+i) - x(j))
    Next
Next

'���K������
Dim a(): ReDim a(N)
For j = 0 To N
    a(j) = d(j,0)
Next

'0.5���݂� �^�����Ă��Ȃ��l���� 
For i = 0 To 18
    d1 = i * 0.5 - 4.5
    Dim d2: d2 = f(d1)
    Dim d3: d3 = newton(d1, x, a)

    '���̊֐��Ɣ�r
    WScript.StdOut.Write     Right(Space(5) & FormatNumber(d1,      2, -1, 0, 0), 5) & vbTab
    WScript.StdOut.Write     Right(Space(8) & FormatNumber(d2,      5, -1, 0, 0), 8) & vbTab
    WScript.StdOut.Write     Right(Space(8) & FormatNumber(d3,      5, -1, 0, 0), 8) & vbTab
    WScript.StdOut.WriteLine Right(Space(8) & FormatNumber(d2 - d3, 5, -1, 0, 0), 8)
Next

'���̊֐�
Private Function f(ByVal x)
    f = x - (x ^ 3) / (3 * 2) + (x ^ 5) / (5 * 4 * 3 * 2)
End Function

'Newton (�j���[�g��) ���
Private Function newton(ByVal d, ByVal x(), ByVal a())
    Dim sum: sum = a(0)
	Dim i, j
    For i = 1 To N
        Dim prod: prod = a(i)
        For j = 0 To (i - 1)
            If j <> i Then
                prod = prod * (d - x(j))
            End If
        Next
        sum = sum + prod
    Next
    newton = sum
End Function
