using System;

public class CS1102
{
    private const int N = 4;

	// �t�x�L��@�ōŏ��ŗL�l�����߂�
    public static void Main()
    {
        double[,] a = {{5.0, 4.0, 1.0, 1.0}, 
                       {4.0, 5.0, 1.0, 1.0}, 
                       {1.0, 1.0, 4.0, 2.0},
                       {1.0, 1.0, 2.0, 4.0}};
		double[]  x  = {1.0 ,0.0 ,0.0 ,0.0};

		// LU����
		forward_elimination(a);
		
        // �t�x�L��@
        double lambda = inverse(a, x);

        Console.WriteLine();
        Console.WriteLine("eigenvalue");
        Console.WriteLine(string.Format("{0,14:F10}", lambda));

        Console.WriteLine("eigenvector");
        disp_vector(x);
    }

    // �t�x�L��@
    private static double inverse(double[,] a, double[] x0)
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

	        // Ly = b ���� y �����߂� (�O�i���)
            double[] b = new double[N];
            double[] y = new double[N];
            for (int i = 0; i < N; i++)
	            b[i] = x0[i];
	        forward_substitution(a,y,b);
	        // Ux = y ���� x �����߂� (��ޑ��)
            double[] x1 = new double[N];
	        backward_substitution(a,x1,y);

	        // ����
	        double p0 = 0.0;
	        double p1 = 0.0;
            for (int i = 0; i < N; i++)
            {
	            p0 += x1[i] * x1[i];
	            p1 += x1[i] * x0[i];
	        }
	        // �ŗL�l
	        lambda = p1 / p0;

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
    
	// LU����
    private static void forward_elimination(double[,] a)
    {
        for (int pivot = 0; pivot < N - 1; pivot++)
        {
            for (int row = pivot + 1; row < N; row++)
            {
                double s = a[row,pivot] / a[pivot,pivot];
                for (int col = pivot; col < N; col++)
                    a[row,col] -= a[pivot,col] * s; // ���ꂪ ��O�p�s��
                a[row,pivot] = s;                   // ���ꂪ ���O�p�s��
            }
        }
    }
    // �O�i���
    private static void forward_substitution(double[,] a, double[] y, double[] b)
    {
        for (int row = 0; row < N; row++)
        {
            for (int col = 0; col < row; col++)
                b[row] -= a[row,col] * y[col];
            y[row] = b[row];
        }
    }
    // ��ޑ��
    private static void backward_substitution(double[,] a, double[] x, double[] y)
    {
        for (int row = N - 1; row >= 0; row--)
        {
            for (int col = N - 1; col > row; col--)
                y[row] -= a[row,col] * x[col];
            x[row] = y[row] / a[row,row];
        }
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
