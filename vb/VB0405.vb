Module VB0405
    '�㏸�K��p
    Private Function RisingFact(ByVal x As Integer, ByVal n As Integer) As Integer
        If n <= 1 Then
            Return x
        Else
            Return x * RisingFact(x + 1, n - 1)
        End If
    End Function

    Sub Main()
        '10 ���� 14 �܂ł� ����
        Console.WriteLine(RisingFact(10, 5))
        Console.WriteLine(10 * 11 * 12 * 13 * 14)
    End Sub
End Module
