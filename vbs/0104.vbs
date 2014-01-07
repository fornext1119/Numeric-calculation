Option Explicit

Dim i
For i = 1 To 9
    If i Mod 3 = 0 Then
        WScript.StdOut.Write i & ", "
    End If
Next
WScript.StdOut.WriteLine
