Option Explicit
' ����:a, ����:a �� ���:lim �̐���̑��a��Ԃ��֐�
Private Function sn(a, lim)
    Dim n: n = lim \ a   ' ����:n  =  ���:lim / ����:a
    Dim l: l = n * a     ' ����:l  =  ����:n   * ����:a
    sn = (a + l) * n \ 2 ' ���a:sn = (����:a   + ����:l) * ����:n / 2
End Function

' 3 �̔{���̍��v
WScript.Echo sn(3, 999)
