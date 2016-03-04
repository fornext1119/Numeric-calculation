using System;

public class CS0508
{
    public static void Main()
    {
        for (int x = -10; x <= 10; x++)
        {
            // ����̑o�Ȑ������֐�
            double d1 = mySinh(x, 1, x, 1.0, x);
            // �W���̑o�Ȑ������֐�
            double d2 = Math.Sinh(x);
            // �W���֐��Ƃ̍���
            Console.WriteLine(string.Format("{0,3:D} : {1,17:F10} - {2,17:F10} = {3,13:F10}", x, d1, d2, d1 - d2));
        }
    }

    // ����̑o�Ȑ������֐�
    private static double mySinh(double x, int n, double numerator, double denominator, double y)
    {
        int m       = 2 * n;
        denominator = denominator * (m + 1) * m;
        numerator   = numerator   * x * x;
        double a    = numerator / denominator;
        // �\���Ȑ��x�ɂȂ����珈���𔲂���
        if (Math.Abs(a) <= 0.00000000001) 
            return y;
        else
            return y + mySinh(x, ++n, numerator, denominator, a);
    }
}
