Module VB0409
    '�g����
    Private Function Comb(ByVal n As Integer, ByVal r As Integer) As Integer
        If (r = 0) OrElse (r = n) Then
            Return 1
        ElseIf r = 1 Then
            Return n
        Else
            Return Comb(n - 1, r - 1) + Comb(n - 1, r)
        End If
    End Function

    Sub Main()
        '�d���g���� (�قȂ� 10 �̂��̂���d���������� 5 �Ƃ�g�����̑���)
        Dim n As Integer = 10
        Dim r As Integer = 5
        Console.WriteLine(Comb(n + r - 1, r))
    End Sub
End Module
