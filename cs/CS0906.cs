using System;

public class CS0906
{
    public static void Main()
    {
        double x0 = 1;
        double x1 = 2;
        Console.WriteLine(string.Format("{0,12:F10}", secant(x0, x1)));
    }

    private static double secant(double x0, double x1)
    {
        double x2;
        while (true)
        {
            x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0));
            Console.WriteLine(string.Format("{0,12:F10}\t{1,13:F10}", x2, x2 - Math.Sqrt(2)));

            if (Math.Abs(x2 - x1) < 0.0000000001) break;
            x0 = x1;
            x1 = x2;
        }
        return x2;
    }
    
    private static double f(double x)
    {
        return x * x - 2;  
    }
}
