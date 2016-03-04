using System;

public class CS0702
{
    // �f�[�^�_�̐�
    private const int N = 7; 

    public static void Main()
    {
        double[] x = new double[N];
        double[] y = new double[N];

	    // 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
	    for (int i = 0; i < N; i++)
	    {
	        double d = i * 1.5 - 4.5;
            x[i] = d;
            y[i] = f(d);
        }

	    // 0.5���݂� �^�����Ă��Ȃ��l����
	    for (int i = 0; i <= 18; i++)
	    {
	        double d  = i * 0.5 - 4.5;
            double d1 = f(d);
            double d2 = neville(d, x, y);

            // ���̊֐��Ɣ�r
            Console.WriteLine(string.Format("{0,5:F2}\t{1,8:F5}\t{2,8:F5}\t{3,8:F5}", d, d1, d2, d1 - d2));
        }
    }

    // ���̊֐�
    private static double f(double x)
    {
	    return x - Math.Pow(x,3) / (3 * 2) + Math.Pow(x,5) / (5 * 4 * 3 * 2);
    }

	// Neville (�l���B��) ���
    private static double neville(double d, double[] x, double[] y)
    {
        double[,] w = new double[N,N];
	    for (int i = 0; i < N; i++)
	        w[0,i] = y[i];

	    for (int j = 1; j < N; j++)
	    {
	        for (int i = 0; i < N - j; i++)
				w[j,i] = w[j-1,i+1] + (w[j-1,i+1] - w[j-1,i]) * (d - x[i+j]) / (x[i+j] - x[i]);
	    }

	    return w[N-1,0];
    }
}
