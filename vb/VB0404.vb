Module VB0404
    '���~�K��p
    Private Function FallingFact(ByVal x As Integer, ByVal n As Integer) As Integer
        If n <= 1 Then
            Return x
        Else
            Return x * FallingFact(x - 1, n - 1)
        End If
    End Function

    Sub Main()
        '10 ���� 6 �܂ł� ����
        Console.WriteLine(FallingFact(10, 5))
        Console.WriteLine(10 * 9 * 8 * 7 * 6)
    End Sub
End Module
