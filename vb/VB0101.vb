Module VB0101
    Public Sub Main()
        Console.WriteLine(3 + 5)
        Console.WriteLine(3 - 5)
        Console.WriteLine(3 * 5)
        Console.WriteLine(3 ^ 5)
        Console.WriteLine(5 / 3)
        Console.WriteLine(5 \ 3)
        Console.WriteLine(5 Mod 3)

        Console.Write(3 * 5 & vbNewLine)

        Console.WriteLine(String.Format("{0,3:D}",    3 * 5))
        Console.WriteLine(String.Format("{0,23:F20}", 5 / 3))
    End Sub
End Module
