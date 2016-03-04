using System;

public class CS1101
{
    private const int N = 4;

    // �x�L��@�ōő�ŗL�l�����߂�
    public static void Main()
    {
        double[,] a = {{5.0, 4.0, 1.0, 1.0}, 
                       {4.0, 5.0, 1.0, 1.0}, 
                       {1.0, 1.0, 4.0, 2.0},
                       {1.0, 1.0, 2.0, 4.0}};
        double[]  x  = {1.0 ,0.0 ,0.0 ,0.0};

        // �x�L��@
        double lambda = power(a, x);

        Console.WriteLine();
        Console.WriteLine("eigenvalue");
        Console.WriteLine(string.Format("{0,14:F10}", lambda));

        Console.WriteLine("eigenvector");
        disp_vector(x);
    }

    // �x�L��@
    private static double power(double[,] a, double[] x0)
    {
        double lambda = 0.0;
        
        // ���K�� (�x�N�g�� x0 �̒������P�ɂ���)
        normarize(x0);
        double e0 = 0.0;
        for (int i = 0; i < N; i++)
            e0 += x0[i];

        for (int k = 1; k <= 200; k++)
        {
            // �P�����z���\��
            Console.Write(string.Format("{0,3:D}\t", k));
            disp_vector(x0);

            // �s��̐� x1 = A �~ x0 
            double[] x1 = new double[N];
            for (int i = 0; i < N; i++)
                for (int j = 0; j < N; j++)
                    x1[i] += a[i, j] * x0[j];
            
            // ����
            double p0 = 0.0;
            double p1 = 0.0;
            for (int i = 0; i < N; i++)
            {
                p0 += x1[i] * x1[i];
                p1 += x1[i] * x0[i];
            }
            // �ŗL�l
            lambda = p0 / p1;

            // ���K�� (�x�N�g�� x1 �̒������P�ɂ���)
            normarize(x1);
            // ��������
            double e1 = 0.0;
            for (int i = 0; i < N; i++)
                e1 += x1[i];
            if (Math.Abs(e0 - e1) < 0.00000000001) break;

            for (int i = 0; i < N; i++)
                x0[i] = x1[i];
            e0 = e1;
        }
        return lambda;
    }
    
    // �P�����z���\��
    private static void disp_vector(double[] row)
    {
        foreach (double col in row)
            Console.Write(string.Format("{0,14:F10}\t", col));
        Console.WriteLine();
    }
    // ���K�� (�x�N�g���̒������P�ɂ���)
    private static void normarize(double[] x)
    {
        double s = 0.0;

        for (int i = 0; i < N; i++)
            s += x[i] * x[i];
        s = Math.Sqrt(s);
        
        for (int i = 0; i < N; i++)
            x[i] /= s;
    }
}
