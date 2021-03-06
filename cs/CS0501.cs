using System;

public class CS0501
{
    public static void Main()
    {
        for (int degree = 0; degree <= 360; degree += 15)
        {
            if (degree % 30 == 0 || degree % 45 == 0)
            {
                double radian = degree * Math.PI / 180.0;
                // 自作の正弦関数
                double d1     = mySin(radian, 1, false, radian, 1.0, radian);
                // 標準の正弦関数
                double d2     = Math.Sin(radian);
                // 標準関数との差異
                Console.WriteLine(string.Format("{0,3:D} : {1,13:F10} - {2,13:F10} = {3,13:F10}", degree, d1, d2, d1 - d2));
            }
        }
    }

    // 自作の正弦関数
    private static double mySin(double x, int n, bool nega, double numerator, double denominator, double y)
    {
        int m       = 2 * n;
        denominator = denominator * (m + 1) * m;
        numerator   = numerator   * x * x;
        double a    = numerator / denominator;
        // 十分な精度になったら処理を抜ける
        if (a <= 0.00000000001) 
            return y;
        else
            return y + mySin(x, ++n, !nega, numerator, denominator, nega ? a : -a);
    }
}
