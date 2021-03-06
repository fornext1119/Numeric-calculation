using System;

public class CS040101
{
    // 組合せ
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
        // 組合せ (異なる 10 個のものから 5 個取ってできる組合せの総数)
        int n = 10;
        int r = 5;
        Console.WriteLine(Comb(n, r));
    }
}
