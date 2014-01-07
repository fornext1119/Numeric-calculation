using System;

public class CS0504
{
    public static void Main()
    {
        for (int i = -10; i <= 10; i++)
        {
            double x  = i / 4.0;
            // 標準の指数関数
            double d1 = Math.Exp(x);
            // 自作の指数関数
            double d2 = myExp(x, 1, 1.0, 1.0, 1.0);
            // 標準関数との差異
            Console.WriteLine(string.Format("{0,5:F2} : {1,13:F10} - {2,13:F10} = {3,13:F10}", x, d1, d2, d1 - d2));
        }
    }

    // 自作の指数関数
    private static double myExp(double x, int n, double numerator, double denominator, double y)
    {
        denominator = denominator * n;
        numerator   = numerator   * x;
        double a    = numerator / denominator;
        // 十分な精度になったら処理を抜ける
        if (Math.Abs(a) <= 0.00000000001)
            return y;
        else
            return y + myExp(x, ++n, numerator, denominator, a);
    }
}
