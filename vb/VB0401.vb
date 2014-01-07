Option Explicit

Module VB0401
    Sub Main()
        Dim a As Integer = 5  '‰€ 5
        Dim d As Integer = 3  'Œö· 3
        Dim n As Integer = 10 '€” 10
        Dim p As Long = 1     'Ï
        
        For i As Integer = 1 To n
            Dim m As Integer = a + (d * (i - 1))
            p *= m
        Next
        Console.WriteLine(p)
    End Sub
End Module
