Option Explicit

Const PI = 3.14159265359
Dim degree
For degree = 0 To 360 Step 15
    If (degree Mod 30 = 0 Or degree Mod 45 = 0) Then
        Dim radian: radian = degree * PI / 180.0
        '����̗]���֐�
        Dim d1: d1         = myCos(radian, 1, False, 1.0, 1.0, 1.0)
        '�W���̗]���֐�
        Dim d2: d2         = Cos(radian)
        '�W���֐��Ƃ̍���
        WScript.StdOut.Write Right(Space(3)  & degree,                               3) & " : "
        WScript.StdOut.Write Right(Space(13) & FormatNumber(d1,      10, -1, 0, 0), 13) & " - "
        WScript.StdOut.Write Right(Space(13) & FormatNumber(d2,      10, -1, 0, 0), 13) & " = "
        WScript.StdOut.Write Right(Space(13) & FormatNumber(d1 - d2, 10, -1, 0, 0), 13) & vbNewLine
    End If
Next

'����̗]���֐�
Private Function myCos(ByVal x, ByVal n, ByVal nega, ByVal numerator, ByVal denominator, ByVal y)
    Dim m: m    = 2 * n
    denominator = denominator * m * (m - 1)
    numerator   = numerator * x * x
    Dim a: a    = numerator / denominator

    '�\���Ȑ��x�ɂȂ����珈���𔲂���
    If (a <= 0.00000000001) Then
        myCos = y
    Else
        If Not nega Then a = -a
        myCos = y + myCos(x, n + 1, Not nega, numerator, denominator, a)
    End If
End Function
