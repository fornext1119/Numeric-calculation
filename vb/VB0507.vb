Module VB0507
    Public Sub Main()
        For i As Integer = 1 To 20
            Dim x As Double  = i / 5.0
            '�W���̑ΐ��֐�
            Dim d1 As Double = Math.Log(x)
            '����̑ΐ��֐�
            Dim d2 As Double = myLog(x - 1, 27, 0.0) '27:�K�v�Ȑ��x��������\���傫�Ȋ
            '�W���֐��Ƃ̍���
            Console.WriteLine(String.Format("{0,5:F2} : {1,13:F10} - {2,13:F10} = {3,13:F10}", x, d1, d2, d1 - d2))
        Next
    End Sub

    '����̑ΐ��֐�
    Private Function myLog(ByVal x As Double, ByVal n As Integer, ByVal t As Double) As Double
        Dim n2 As Integer = n
        Dim x2 As Double  = x
        If (n > 3) Then
            If (n Mod 2 = 0) Then
                n2 = 2
            End If
            x2 = x * (n \ 2)
        End If
        t = x2 / (n2 + t)

        If (n <= 2) Then
            Return x / (1 + t)
        Else
            Return myLog(x, n - 1, t)
        End If
    End Function
End Module
