using System;

public class CS0509
{
    public static void Main()
    {
        for (int x = -10; x <= 10; x++)
        {
            // 自作の双曲線余弦関数
            double d1 = myCosh(x, 1, 1.0, 1.0, 1.0);
            // 標準の双曲線余弦関数
            double d2 = Math.Cosh(x);
            // 標準関数との差異
            Console.WriteLine(string.Format("{0,3:D} : {1,17:F10} - {2,17:F10} = {3,13:F10}", x, d1, d2, d1 - d2));
        }
    }

    // 自作の双曲線余弦関数
    private static double myCosh(double x, int n, double numerator, double denominator, double y)
    {
        int m       = 2 * n;
        denominator = denominator * m * (m - 1);
        numerator   = numerator   * x * x;
        double a    = numerator / denominator;
        // 十分な精度になったら処理を抜ける
        if (Math.Abs(a) <= 0.00000000001) 
            return y;
        else
            return y + myCosh(x, ++n, numerator, denominator, a);
    }
}
