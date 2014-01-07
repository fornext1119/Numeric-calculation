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

'�R���������̌W���̕\�����
Dim a(): ReDim a(N)
Dim b(): ReDim b(N)
Dim c(): ReDim c(N)
Dim d(): ReDim d(N)
For i = 1 To N - 1
    a(i) =         x(i)   - x(i-1)
    b(i) = 2.0 *  (x(i+1) - x(i-1))
    c(i) =         x(i+1) - x(i)
    d(i) = 6.0 * ((y(i+1) - y(i)) / (x(i+1) - x(i)) - (y(i) - y(i-1)) / (x(i) - x(i-1)))
Next
'�R�������������� (�g�|�}�X�@)
Dim g(): ReDim g(N)
Dim s(): ReDim s(N)
g(1) = b(1)
s(1) = d(1)
For i = 2 To N - 1
    g(i) = b(i) - a(i) * c(i-1) / g(i-1)
    s(i) = d(i) - a(i) * s(i-1) / g(i-1)
Next
Dim z(): ReDim z(N)
z(0)   = 0
z(N)   = 0
z(N-1) = s(N-1) / g(N-1)
For i = N - 2 To 1 Step -1
    z(i) = (s(i) - c(i) * z(i+1)) / g(i)
Next

'0.5���݂� �^�����Ă��Ȃ��l���� 
For i = 0 To 18
    d1         = i * 0.5 - 4.5
    Dim d2: d2 = f(d1)
    Dim d3: d3 = spline(d1, x, y, z)

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

'Spline (�X�v���C��) ���
Private Function spline(ByVal d, ByVal x(), ByVal y(), ByVal z())
    '��Ԋ֐��l���ǂ̋�Ԃɂ��邩
    Dim k: k = -1
	Dim i
    For i = 1 To N
        If d <= x(i) Then
            k = i - 1
            Exit For
        End If
    Next
    If k < 0 Then k = N

    Dim d1: d1 =  x(k+1) - d
    Dim d2: d2 =  d      - x(k)
    Dim d3: d3 =  x(k+1) - x(k)
    spline     = (z(k) * (d1 ^ 3) + z(k+1) * (d2 ^ 3)) / (6.0 * d3) + _
                 (y(k)   / d3 - z(k)   * d3 / 6.0) * d1             + _
                 (y(k+1) / d3 - z(k+1) * d3 / 6.0) * d2
End Function
