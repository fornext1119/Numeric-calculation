Module VB0301
    Public Sub Main()
        ' 3 �̔{���̍��v
        Console.WriteLine( sn(3, 999) )
    End Sub

    ' ����:a, ����:a ��, ���:lim �̐���̑��a��Ԃ��֐�
    Private Function sn(ByVal a As Integer, ByVal lim As Integer) As Integer
        Dim n As Integer = lim \ a   ' ����:n  =  ���:lim / ����:a
        Dim l As Integer = n * a     ' ����:l  =  ����:n   * ����:a
        Return (a + l) * n \ 2       ' ���a:sn = (����:a   + ����:l) * ����:n / 2
    End Function
End Module
