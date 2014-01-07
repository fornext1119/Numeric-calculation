Option Explicit

Dim i
For i = 0 To 20
    Dim x:  x  = (i - 10) / 4.0
    '�W���̎w���֐�
    Dim d1: d1 = Exp(x)
    '����̎w���֐�
    Dim d2: d2 = myExp(x, 1, 1.0, 1.0, 1.0)
    '�W���֐��Ƃ̍���
    WScript.StdOut.Write Right(Space(5)  & FormatNumber(x,        2, -1, 0, 0),  5) & " : "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d1,      10, -1, 0, 0), 13) & " - "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d2,      10, -1, 0, 0), 13) & " = "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d1 - d2, 10, -1, 0, 0), 13) & vbNewLine
Next

'����̎w���֐�
Private Function myExp(ByVal x, ByVal n, ByVal numerator, ByVal denominator, ByVal y)
    denominator     = denominator * n
    numerator       = numerator   * x
    Dim a: a = numerator / denominator
    '�\���Ȑ��x�ɂȂ����珈���𔲂���
    If (Abs(a) <= 0.00000000001) Then
        myExp = y
    Else
        myExp = y + myExp(x, n + 1, numerator, denominator, a)
    End If
End Function
