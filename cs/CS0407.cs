using System;

public class CS0407
{
    public static void Main()
    {
        // 重複順列 (異なる 10 個のものから重複を許して 5 個取ってできる順列の総数)
        int n = 10;
        int r = 5;
        Console.WriteLine(Math.Pow(n, r));
    }
}
