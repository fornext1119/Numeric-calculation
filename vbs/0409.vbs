'�g����
Private Function Comb(n, r)
    If (r = 0) Or (r = n) Then
        Comb = 1
    ElseIf r = 1 Then
        Comb = n
    Else
        Comb = Comb(n - 1, r - 1) + Comb(n - 1, r)
    End If
End Function

'�d���g���� (�قȂ� 10 �̂��̂���d���������� 5 �Ƃ�g�����̑���)
Dim n: n = 10
Dim r: r = 5
WScript.Echo(Comb(n + r - 1, r))
