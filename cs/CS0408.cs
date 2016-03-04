using System;

public class CS040101
{
    // ‘g‡‚¹
    private static int Comb(int n, int r)
    {
        if (r == 0 || r == n)
            return 1;
        else if (r == 1)
            return n;
        else
            return Comb(n - 1, r - 1) + Comb(n - 1, r);
    }

    public static void Main()
    {
        // ‘g‡‚¹ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‘g‡‚¹‚Ì‘”)
        int n = 10;
        int r = 5;
        Console.WriteLine(Comb(n, r));
    }
}
