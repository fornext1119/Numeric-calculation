using System;

public class CS0502
{
    public static void Main()
    {
        for (int degree = 0; degree <= 360; degree += 15)
        {
            if (degree % 30 == 0 || degree % 45 == 0)
            {
                double radian = degree * Math.PI / 180.0;
                // ����̗]���֐�
                double d1     = myCos(radian, 1, false, 1.0, 1.0, 1.0);
                // �W���̗]���֐�
                double d2     = Math.Cos(radian);
                // �W���֐��Ƃ̍���
                Console.WriteLine(string.Format("{0,3:D} : {1,13:F10} - {2,13:F10} = {3,13:F10}", degree, d1, d2, d1 - d2));
            }
        }
    }

    // ����̗]���֐�
    private static double myCos(double x, int n, bool nega, double numerator, double denominator, double y)
    {
        int m       = 2 * n;
        denominator = denominator * m * (m - 1);
        numerator   = numerator   * x * x;
        double a    = numerator / denominator;
        // �\���Ȑ��x�ɂȂ����珈���𔲂���
        if (a <= 0.00000000001) 
            return y;
        else
            return y + myCos(x, ++n, !nega, numerator, denominator, nega ? a : -a);
    }
}
