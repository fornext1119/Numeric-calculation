using System;

public class CS0904
{
    public static void Main()
    {
        double x = 2;
        Console.WriteLine(string.Format("{0,12:F10}", newton(x)));
    }

    private static double newton(double x0)
    {
        double x1;
        while (true)
        {
	        x1 = x0 - (f0(x0) / f1(x0));
            Console.WriteLine(string.Format("{0,12:F10}\t{1,13:F10}", x1, x1 - Math.Sqrt(2)));

            if (Math.Abs(x1 - x0) < 0.0000000001) break;
            x0 = x1;
        }
        return x1;
    }
    
	private static double f0(double x)
	{
	    return x * x - 2;  
	}
	private static double f1(double x)
	{
	    return 2 * x;  
	}
}
