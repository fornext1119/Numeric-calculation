Module VB0104
    Public Sub Main()
        For i As Integer = 1 To 9
            If i Mod 3 = 0 Then
                Console.Write(i & ", ")
            End If
        Next
        Console.WriteLine()
    End Sub
End Module
