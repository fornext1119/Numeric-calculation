Option Explicit

Dim i
For i = 1 To 20
    Dim x:  x  = i / 5.0
    '�W���̑ΐ��֐�
    Dim d1: d1 = Log(x)
    '����̑ΐ��֐�
    Dim x2: x2 = (x - 1) / (x + 1)
    Dim d2: d2 = 2 * myLog(x2, x2, 1.0, x2)
    '�W���֐��Ƃ̍���
    WScript.StdOut.Write Right(Space(5)  & FormatNumber(x,        2, -1, 0, 0),  5) & " : "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d1,      10, -1, 0, 0), 13) & " - "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d2,      10, -1, 0, 0), 13) & " = "
    WScript.StdOut.Write Right(Space(13) & FormatNumber(d1 - d2, 10, -1, 0, 0), 13) & vbNewLine
Next

'����̑ΐ��֐�
Private Function myLog(ByVal x2, ByVal numerator, ByVal denominator, ByVal y)
    denominator = denominator + 2
    numerator   = numerator   * x2 * x2
    Dim a: a    = numerator / denominator
    '�\���Ȑ��x�ɂȂ����珈���𔲂���
    If (Abs(a) <= 0.00000000001) Then
        myLog = y
    Else
        myLog = y + myLog(x2, numerator, denominator, a)
    End If
End Function
