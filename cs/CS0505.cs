using System;

public class CS0505
{
    public static void Main()
    {
        for (int i = -10; i <= 10; i++)
        {
            double x  = i / 4.0;
            // 標準の指数関数
            double d1 = Math.Exp(x);
            // 自作の指数関数
            double x2 = x * x;
            double d2 = myExp(x, x2, 30, 0.0); // 30:必要な精度が得られるよう, 6から始めて4ずつ増加させる
            // 標準関数との差異
            Console.WriteLine(string.Format("{0,5:F2} : {1,13:F10} - {2,13:F10} = {3,13:F10}", x, d1, d2, d1 - d2));
        }
    }

    // 自作の指数関数
    private static double myExp(double x, double x2, int n, double t)
    {
        t = x2 / (n + t);
        n -= 4;  

        if (n < 6)
            return 1 + ((2 * x) / (2 - x + t));
        else
            return myExp(x, x2, n, t);
    }
}
