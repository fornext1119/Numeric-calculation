'���~�K��p
Private Function FallingFact(x, n)
    If n <= 1 Then
        FallingFact = x
    Else
        FallingFact = x * FallingFact(x - 1, n - 1)
    End If
End Function

'10 ���� 6 �܂ł� ����
WScript.Echo(FallingFact(10, 5))
WScript.Echo(10 * 9 * 8 * 7 * 6)
