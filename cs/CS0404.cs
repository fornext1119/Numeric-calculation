using System;

public class CS0404
{
    // ‰º~ŠKæ™p
    private static int FallingFact(int x, int n)
    {
        if (n <= 1)
            return x;
        else
            return x * FallingFact(x - 1, n - 1);
    }

    public static void Main()
    {
        // 10 ‚©‚ç 6 ‚Ü‚Å‚Ì ‘æ
        Console.WriteLine(FallingFact(10, 5));
        Console.WriteLine(10 * 9 * 8 * 7 * 6);
    }
}
