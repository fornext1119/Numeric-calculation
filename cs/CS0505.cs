using System;

public class CS0505
{
    public static void Main()
    {
        for (int i = -10; i <= 10; i++)
        {
            double x  = i / 4.0;
            // �W���̎w���֐�
            double d1 = Math.Exp(x);
            // ����̎w���֐�
            double x2 = x * x;
            double d2 = myExp(x, x2, 30, 0.0); // 30:�K�v�Ȑ��x��������悤, 6����n�߂�4������������
            // �W���֐��Ƃ̍���
            Console.WriteLine(string.Format("{0,5:F2} : {1,13:F10} - {2,13:F10} = {3,13:F10}", x, d1, d2, d1 - d2));
        }
    }

    // ����̎w���֐�
    private static double myExp(double x, double x2, int n, double t)
    {
        t = x2 / (n + t);
        n -= 4;  

        if (n < 6)
            return 1 + ((2 * x) / (2 - x + t));
        else
            return myExp(x, x2, n, t);
    }
}
