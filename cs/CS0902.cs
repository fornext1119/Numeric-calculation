using System;

public class CS0902
{
    public static void Main()
    {
        double a = 1;
        double b = 2;
        Console.WriteLine(string.Format("{0,12:F10}", falseposition(a, b)));
    }

    private static double falseposition(double a, double b)
    {
        double c;
        while (true)
        {
	        // �_ (a,f(a)) �� �_ (b,f(b)) �����Ԓ����� x���̌�_ c
	        c = (a * f(b) - b * f(a)) / (f(b) - f(a));
            Console.WriteLine(string.Format("{0,12:F10}\t{1,13:F10}", c, c - Math.Sqrt(2)));

            double fc = f(c);
            if (Math.Abs(fc) < 0.0000000001) break;

            if (fc < 0)
            {
                // f(c) < 0 �ł����, ���͋�� (c, b) �̒��ɑ���
                a = c;
            }
            else
            {
                // f(c) > 0 �ł����, ���͋�� (a, c) �̒��ɑ���
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
