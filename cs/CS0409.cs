using System;

public class CS0409
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
        // 重複組合せ (異なる 10 個のものから重複を許して 5 個とる組合せの総数)
        int n = 10;
        int r = 5;
        Console.WriteLine(Comb(n + r - 1, r));
    }
}
