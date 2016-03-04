Module VB0105
    Public Sub Main()
        Dim sum As Integer = 0
        For i As Integer = 1 To 99
            If i Mod 3 = 0 Then
                sum += i
            End If
        Next
        Console.WriteLine(sum)
    End Sub
End Module
