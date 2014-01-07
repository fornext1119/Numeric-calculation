using System;

public class CS0602
{
    private static double f(double x)
    {
        return 4 / (1 + x * x);
    }

    public static void Main()
    {
        const double a = 0;
        const double b = 1;

        // ’†“_‘¥‚ÅÏ•ª
        int n = 2;
        for (int j = 1; j <= 10; j++)
        {
            double h = (b - a) / n;  
            double s = 0;
            double x = a + (h / 2);
            for (int i = 1; i <= n; i++)
            {
                s += f(x);
                x += h;
            }
            s *= h;
            n *= 2;

            // Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
            Console.WriteLine(string.Format("{0,2:D} : {1,13:F10}, {2,13:F10}", j, s, s - Math.PI));
        }
    }
}
