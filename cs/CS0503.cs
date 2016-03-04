using System;

public class CS0503
{
    public static void Main()
    {
        for (int degree = -90; degree <= 90; degree += 15)
        {
            if ((degree + 90) % 180 != 0)
            {
                double radian = degree * Math.PI / 180.0;
                double x2     = radian * radian;
                // ����̐��ڊ֐�
                double d1     = myTan(radian, x2, 15, 0.0); // 15:�K�v�Ȑ��x��������\���傫�Ȋ
                // �W���̐��ڊ֐�
                double d2     = Math.Tan(radian);
                // �W���֐��Ƃ̍���
                Console.WriteLine(string.Format("{0,3:D} : {1,13:F10} - {2,13:F10} = {3,13:F10}", degree, d1, d2, d1 - d2));
            }
        }
    }

    // ����̐��ڊ֐�
    private static double myTan(double x, double x2, int n, double t)
    {
        t = x2 / (n - t);
        n -= 2;  
        if (n <= 1) 
            return x / (1 - t);
        else
            return myTan(x, x2, n, t);
    }
}
