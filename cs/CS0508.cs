using System;

public class CS0508
{
    public static void Main()
    {
        for (int x = -10; x <= 10; x++)
        {
            // Ž©ì‚Ì‘o‹Èü³Œ·ŠÖ”
            double d1 = mySinh(x, 1, x, 1.0, x);
            // •W€‚Ì‘o‹Èü³Œ·ŠÖ”
            double d2 = Math.Sinh(x);
            // •W€ŠÖ”‚Æ‚Ì·ˆÙ
            Console.WriteLine(string.Format("{0,3:D} : {1,17:F10} - {2,17:F10} = {3,13:F10}", x, d1, d2, d1 - d2));
        }
    }

    // Ž©ì‚Ì‘o‹Èü³Œ·ŠÖ”
    private static double mySinh(double x, int n, double numerator, double denominator, double y)
    {
        int m       = 2 * n;
        denominator = denominator * (m + 1) * m;
        numerator   = numerator   * x * x;
        double a    = numerator / denominator;
        // \•ª‚È¸“x‚É‚È‚Á‚½‚çˆ—‚ð”²‚¯‚é
        if (Math.Abs(a) <= 0.00000000001) 
            return y;
        else
            return y + mySinh(x, ++n, numerator, denominator, a);
    }
}
