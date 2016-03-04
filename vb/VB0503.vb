Module VB0503
    Public Sub Main()
        For i As Integer = 0 To 180 Step 15
            If (i Mod 180 <> 0) Then
                Dim degree As Integer = i - 90
                Dim radian As Double = degree * Math.PI / 180.0
                Dim x2 As Double     = radian * radian
                '����̐��ڊ֐�
                Dim d1 As Double     = myTan(radian, x2, 15, 0.0) '15:�K�v�Ȑ��x��������\���傫�Ȋ
                '�W���̐��ڊ֐�
                Dim d2 As Double     = Math.Tan(radian)
                '�W���֐��Ƃ̍���
                Console.WriteLine(String.Format("{0,3:D} : {1,13:F10} - {2,13:F10} = {3,13:F10}", degree, d1, d2, d1 - d2))
            End If
        Next
    End Sub

    '����̐��ڊ֐�
    Private Function myTan(ByVal x As Double, ByVal x2 As Double, ByVal n As Integer, ByVal t As Double) As Double
        t = x2 / (n - t)
        n -= 2
        If (n <= 1) Then
            Return x / (1 - t)
        Else
            Return myTan(x, x2, n, t)
        End If
    End Function
End Module
