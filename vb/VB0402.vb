Option Explicit

Module VB0402
    Sub Main()
        '���� 5, ���� 3, ���� 10 �̐���̐ς�\������
        Console.WriteLine(product(5, 3, 10))
    End Sub
    
    Private Function product(ByVal m As Integer, ByVal d As Integer, ByVal n As Integer) As Long 
        If n = 0 Then
            Return 1
        Else
            Return m * product(m + d, d, n - 1)
        End If
    End Function
End Module
