using System;

public class CS0507
{
    public static void Main()
    {
        for (int i = 1; i <= 20; i++)
        {
            double x  = i / 5.0;
            // 標準の対数関数
            double d1 = Math.Log(x);
            // 自作の対数関数
            double d2 = myLog(x - 1, 27, 0.0); // 27:必要な精度が得られる十分大きな奇数
            // 標準関数との差異
            Console.WriteLine(string.Format("{0,5:F2} : {1,13:F10} - {2,13:F10} = {3,13:F10}", x, d1, d2, d1 - d2));
        }
    }

    // 自作の対数関数
    private static double myLog(double x, int n, double t)
    {
        int    n2 = n;
        double x2 = x;
        if (n > 3)
        {
            if (n % 2 == 0)
                n2 = 2;
            x2 = x * (n / 2);
        }
        t = x2 / (n2 + t);

        if (n <= 2)
            return x / (1 + t);
        else
            return myLog(x, --n, t);
    }
}
