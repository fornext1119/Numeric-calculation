using System;

public class CS0511
{
    public static void Main()
    {
        for (int degree = -45; degree <= 45; degree += 15)
        {
            double radian = degree * Math.PI / 180.0;
            double x2     = radian * radian;
            // 自作の逆正接関数
            double d1     = myAtan(radian, x2, 23, 0.0); // 23:必要な精度が得られる十分大きな奇数
            // 標準の逆正接関数
            double d2     = Math.Atan(radian);
            // 標準関数との差異
            Console.WriteLine(string.Format("{0,3:D} : {1,13:F10} - {2,13:F10} = {3,13:F10}", degree, d1, d2, d1 - d2));
        }
    }

    // 自作の逆正接関数
    private static double myAtan(double x, double x2, int n, double t)
    {
		int m = n / 2;
        t = (m * m * x2) / (n + t);
        n -= 2;  
        if (n <= 1) 
            return x / (1 + t);
        else
            return myAtan(x, x2, n, t);
    }
}