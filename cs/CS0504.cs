using System;

public class CS0504
{
    public static void Main()
    {
        for (int i = -10; i <= 10; i++)
        {
            double x  = i / 4.0;
            // �W���̎w���֐�
            double d1 = Math.Exp(x);
            // ����̎w���֐�
            double d2 = myExp(x, 1, 1.0, 1.0, 1.0);
            // �W���֐��Ƃ̍���
            Console.WriteLine(string.Format("{0,5:F2} : {1,13:F10} - {2,13:F10} = {3,13:F10}", x, d1, d2, d1 - d2));
        }
    }

    // ����̎w���֐�
    private static double myExp(double x, int n, double numerator, double denominator, double y)
    {
        denominator = denominator * n;
        numerator   = numerator   * x;
        double a    = numerator / denominator;
        // �\���Ȑ��x�ɂȂ����珈���𔲂���
        if (Math.Abs(a) <= 0.00000000001)
            return y;
        else
            return y + myExp(x, ++n, numerator, denominator, a);
    }
}
