Option Explicit

Dim sum: sum = 0
Dim i
For i = 1 To 99
    If i Mod 3 = 0 Then
        sum = sum + i
    End If
Next
WScript.Echo sum
