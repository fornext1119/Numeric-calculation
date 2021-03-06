using System;

public class CS0512
{
    public static void Main()
    {
        for (int i = 11; i <= 31; i += 2)
        {
            double radian = 1; // degree * Math.PI / 180.0;
            double x2     = radian * radian;
            // 自作の逆正接関数
            double d1     = myAtan(radian, x2, i, 0.0); // i:必要な精度が得られる十分大きな奇数
            // 標準の逆正接関数
            //double d2     = Math.Atan(radian);
            // 標準関数との差異
            Console.WriteLine(string.Format("{0,2:D} : {1,13:F10}, {2,13:F10}", i, d1 * 4, d1 * 4 - Math.PI));
            //Console.WriteLine(string.Format("{0,2D} : {1,13:F10}", i, d1));
            //Console.WriteLine(string.Format("{0,2:D}", i));
            //Console.WriteLine(string.Format("{0,13:F10}, {1,13:F10}, {2,13:F10}", d1 * 4, d2 * 4, Math.PI));
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