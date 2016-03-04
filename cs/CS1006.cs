using System;

public class CS1006 
{
    private const int N = 4; 

	// �R���X�L�[�@
    public static void Main()
    {
	    double[,] a = {{5,2,3,4},{2,10,6,7},{3,6,15,9},{4,7,9,20}}; 
	    double[]  b = {34,68,96,125};
	    
	    Console.WriteLine("A");
    	disp_matrix(a);
	    Console.WriteLine("B");
	    disp_vector(b);
	    Console.WriteLine();

	    // �O�i����
	    forward_elimination(a,b);
	    
	    Console.WriteLine("LL^T");
    	disp_matrix(a);

	    // Ly=b ���� y �����߂� (�O�i���)
	    double[] y = {0,0,0,0};
	    forward_substitution(a,b,y);

	    Console.WriteLine("Y");
	    disp_vector(y);

	    // L^Tx=y ���� x �����߂� (��ޑ��)
	    double[] x = {0,0,0,0};
	    backward_substitution(a,y,x);

	    Console.WriteLine("X");
	    disp_vector(x);
	}
	// �O�i����
	private static void forward_elimination(double[,] a, double[] b) 
	{
	    for (int pivot = 0; pivot < N; pivot++) 
	    {
	        double s = 0;
	        for (int col = 0; col < pivot; col++)
	            s += a[pivot,col] * a[pivot,col];
	        // �����ō����̒������̒l�ɂȂ�ƌv�Z�ł��Ȃ��I
	        a[pivot,pivot] = Math.Sqrt(a[pivot,pivot] - s);

	        for (int row = pivot + 1; row < N; row++) 
	        {
	            s = 0;
	            for (int col = 0; col < pivot; col++)
	                s += a[row,col] * a[pivot,col];
	            a[row,pivot] =  (a[row,pivot] - s) / a[pivot,pivot];
	            a[pivot,row] =  a[row,pivot];
	        } 
	    }
	}
    // �O�i���
	private static void forward_substitution(double[,] a, double[] b, double[] y) 
	{
	    for (int row = 0; row < N; row++) 
	    {
	        for (int col = 0; col < row; col++)
	            b[row] -= a[row,col] * y[col];
	        y[row] = b[row] / a[row,row];
	    }
	}
    // ��ޑ��
	private static void backward_substitution(double[,] a, double[] y, double[] x) 
	{
	    for (int row = N - 1; row >= 0; row--) 
	    {
	        for (int col = N - 1; col > row; col--)
	            y[row] -= a[col,row] * x[col];
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
	// �Q�����z���\��
	private static void disp_matrix(double[,] matrix)
	{
		int i = 0;
        foreach (double col in matrix)
        {
        	Console.Write(string.Format("{0,14:F10}\t", col));
        	if (++i >= N)
        	{
				i = 0;
	    		Console.WriteLine();
	    	}
	    }
	}
}
