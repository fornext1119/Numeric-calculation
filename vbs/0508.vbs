Option Explicit

Dim i
For i = 0 To 20
    Dim x:  x  = i - 10
    '����̑o�Ȑ������֐�
    Dim d1: d1 = mySinh(x, 1, x, 1.0, x)
    '�W���̑o�Ȑ������֐��͂Ȃ�
    Dim d2: d2 = (Exp(x) - Exp(-x)) / 2
    '�W���֐��Ƃ̍���
    WScript.StdOut.Write Right(Space(3)  & x,                                    3) & " : "
    WScript.StdOut.Write Right(Space(17) & FormatNumber(d1,      10, -1, 0, 0), 17) & " - "
    WScript.StdOut.Write Right(Space(17) & FormatNumber(d2,      10, -1, 0, 0), 17) & " = "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d1 - d2, 10, -1, 0, 0), 13) & vbNewLine
Next

'����̑o�Ȑ������֐�
Private Function mySinh(ByVal x, ByVal n, ByVal numerator, ByVal denominator, ByVal y)
    Dim m: m    = 2 * n
    denominator = denominator * (m + 1) * m
    numerator   = numerator   * x * x
    Dim a: a    = numerator / denominator
    '�\���Ȑ��x�ɂȂ����珈���𔲂���
    If (Abs(a) <= 0.00000000001) Then
        mySinh = y
    Else
        mySinh = y + mySinh(x, n + 1, numerator, denominator, a)
    End If
End Function
