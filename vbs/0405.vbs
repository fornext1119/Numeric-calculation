'�㏸�K��p
Private Function RisingFact(x, n)
    If n <= 1 Then
        RisingFact = x
    Else
        RisingFact = x * RisingFact(x + 1, n - 1)
    End If
End Function

'10 ���� 14 �܂ł� ����
WScript.Echo(RisingFact(10, 5))
WScript.Echo(10 * 11 * 12 * 13 * 14)
