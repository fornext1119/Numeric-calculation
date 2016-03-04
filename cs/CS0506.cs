using System;

public class CS0506
{
    public static void Main()
    {
        for (int i = 1; i <= 20; i++)
        {
            double x  = i / 5.0;
            // �W���̑ΐ��֐�
            double d1 = Math.Log(x);
            // ����̑ΐ��֐�
            double x2 = (x - 1) / (x + 1);  
            double d2 = 2 * myLog(x2, x2, 1.0, x2);
            // �W���֐��Ƃ̍���
            Console.WriteLine(string.Format("{0,5:F2} : {1,13:F10} - {2,13:F10} = {3,13:F10}", x, d1, d2, d1 - d2));
        }
    }

    // ����̑ΐ��֐�
    private static double myLog(double x2, double numerator, double denominator, double y)
    {
        denominator = denominator + 2;
        numerator   = numerator   * x2 * x2;
        double a    = numerator / denominator;
        // �\���Ȑ��x�ɂȂ����珈���𔲂���
        if (Math.Abs(a) <= 0.00000000001)
            return y;
        else
            return y + myLog(x2, numerator, denominator, a);
    }
}
