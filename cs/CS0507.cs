using System;

public class CS0507
{
    public static void Main()
    {
        for (int i = 1; i <= 20; i++)
        {
            double x  = i / 5.0;
            // �W���̑ΐ��֐�
            double d1 = Math.Log(x);
            // ����̑ΐ��֐�
            double d2 = myLog(x - 1, 27, 0.0); // 27:�K�v�Ȑ��x��������\���傫�Ȋ
            // �W���֐��Ƃ̍���
            Console.WriteLine(string.Format("{0,5:F2} : {1,13:F10} - {2,13:F10} = {3,13:F10}", x, d1, d2, d1 - d2));
        }
    }

    // ����̑ΐ��֐�
    private static double myLog(double x, int n, double t)
    {
        int    n2 = n;
        double x2 = x;
        if (n > 3)
        {
            if (n % 2 == 0)
                n2 = 2;
            x2 = x * (n / 2);
        }
        t = x2 / (n2 + t);

        if (n <= 2)
            return x / (1 + t);
        else
            return myLog(x, --n, t);
    }
}
