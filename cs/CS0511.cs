using System;

public class CS0511
{
    public static void Main()
    {
        for (int degree = -45; degree <= 45; degree += 15)
        {
            double radian = degree * Math.PI / 180.0;
            double x2     = radian * radian;
            // ����̋t���ڊ֐�
            double d1     = myAtan(radian, x2, 23, 0.0); // 23:�K�v�Ȑ��x��������\���傫�Ȋ
            // �W���̋t���ڊ֐�
            double d2     = Math.Atan(radian);
            // �W���֐��Ƃ̍���
            Console.WriteLine(string.Format("{0,3:D} : {1,13:F10} - {2,13:F10} = {3,13:F10}", degree, d1, d2, d1 - d2));
        }
    }

    // ����̋t���ڊ֐�
    private static double myAtan(double x, double x2, int n, double t)
    {
		int m = n / 2;
        t = (m * m * x2) / (n + t);
        n -= 2;  
        if (n <= 1) 
            return x / (1 + t);
        else
            return myAtan(x, x2, n, t);
    }
}