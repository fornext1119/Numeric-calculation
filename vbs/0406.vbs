'�K��
Private Function Fact(n)
    If n <= 1 Then
        Fact = 1
    Else
        Fact = n * Fact(n - 1)
    End If
End Function

'���~�K��p
Private Function FallingFact(x, n)
    If n <= 1 Then
        FallingFact = x
    Else
        FallingFact = x * FallingFact(x - 1, n - 1)
    End If
End Function

'���� (�قȂ� 10 �̂��̂��� 5 ����Ăł��鏇��̑���)
Dim n: n = 10
Dim r: r = 5
WScript.Echo(Fact(n) / Fact(n - r))
WScript.Echo(FallingFact(n, r))
