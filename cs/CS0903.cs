using System;

public class CS0903
{
    public static void Main()
    {
        double x = 1;
        Console.WriteLine(string.Format("{0,12:F10}", iterative(x)));
    }

    private static double iterative(double x0)
    {
        double x1;
        while (true)
        {
            x1 = g(x0);
            Console.WriteLine(string.Format("{0,12:F10}\t{1,13:F10}", x1, x1 - Math.Sqrt(2)));

            if (Math.Abs(x1 - x0) < 0.0000000001) break;
            x0 = x1;
        }
        return x1;
    }
    
    private static double g(double x)
    {
        return (x / 2) + (1 / x);
    }
}
