using System;

public class CS0901
{
    public static void Main()
    {
        double a = 1;
        double b = 2;
        Console.WriteLine(string.Format("{0,12:F10}", bisection(a, b)));
    }

    private static double bisection(double a, double b)
    {
        double c;
        while (true)
        {
            // 区間 (a, b) の中点 c = (a + b) / 2
            c = (a + b) / 2;
            Console.WriteLine(string.Format("{0,12:F10}\t{1,13:F10}", c, c - Math.Sqrt(2)));

            double fc = f(c);
            if (Math.Abs(fc) < 0.0000000001) break;

            if (fc < 0)
            {
                // f(c) < 0 であれば, 解は区間 (c, b) の中に存在
                a = c;
            }
            else
            {
                // f(c) > 0 であれば, 解は区間 (a, c) の中に存在
                b = c;
            }
        }
        return c;
    }

    private static double f(double x)
    {
        return x * x - 2;  
    }
}
