using System;

public class CS0402
{
    public static void Main()
    {
        // ‰€ 5, Œö· 3, €” 10 ‚Ì”—ñ‚ÌÏ‚ğ•\¦‚·‚é
        Console.WriteLine(product(5, 3, 10));
    }

    private static long product(int m, int d, int n) 
    {
        if (n == 0)
            return 1;
        else
            return m * product(m + d, d, n - 1);
    }
}
