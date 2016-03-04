using System;

public class CS1005 
{
    private const int N = 4; 

	// LU分解
    public static void Main()
    {
	    double[,] a = {{-1,-2,7,-2},{1,-1,-2,6},{9,2,1,1},{2,8,-2,1}}; 
	    double[]  b = {8,17,20,16};

	    // ピボット選択
	    pivoting(a,b);
	    
	    Console.WriteLine("pivoting");
	    Console.WriteLine("A");
    	disp_matrix(a);
	    Console.WriteLine("B");
	    disp_vector(b);
	    Console.WriteLine();

	    // 前進消去
	    forward_elimination(a,b);
	    
	    Console.WriteLine("LU");
    	disp_matrix(a);

	    // Ly=b から y を求める (前進代入)
	    double[] y = {0,0,0,0};
	    forward_substitution(a,b,y);

	    Console.WriteLine("Y");
	    disp_vector(y);

	    // Ux=y から x を求める (後退代入)
	    double[] x = {0,0,0,0};
	    backward_substitution(a,y,x);

	    Console.WriteLine("X");
	    disp_vector(x);
	}
	// 前進消去
	private static void forward_elimination(double[,] a, double[] b) 
	{
	    for (int pivot = 0; pivot < N - 1; pivot++) 
	    {
	        for (int row = pivot + 1; row < N; row++) 
	        {
	            double s = a[row,pivot] / a[pivot,pivot];
	            for (int col = pivot; col < N; col++)
	                a[row,col] -= a[pivot,col] * s; // これが 上三角行列
	            a[row,pivot] = s;                   // これが 下三角行列
	            // b[row]   -= b[pivot] * s;        // この値は変更しない
	        }
	    }
	}
    // 前進代入
	private static void forward_substitution(double[,] a, double[] b, double[] y) 
	{
	    for (int row = 0; row < N; row++) 
	    {
	        for (int col = 0; col < row; col++)
	            b[row] -= a[row,col] * y[col];
	        y[row] = b[row];
	    }
	}
    // 後退代入
	private static void backward_substitution(double[,] a, double[] y, double[] x) 
	{
	    for (int row = N - 1; row >= 0; row--)
	    {
	        for (int col = N - 1; col > row; col--)
	            y[row] -= a[row,col] * x[col];
	        x[row] = y[row] / a[row,row];
	    }
	}
	// ピボット選択
	private static void pivoting(double[,] a, double[] b) 
	{
	    for(int pivot = 0; pivot < N; pivot++) 
	    {
	        // 各列で 一番値が大きい行を 探す
	        int     max_row =   pivot;
	        double  max_val =   0;
	        for (int row = pivot; row < N; row++) 
	        {
	            if (Math.Abs(a[row,pivot]) > max_val) 
	            {
	                // 一番値が大きい行
	                max_val =   Math.Abs(a[row,pivot]);
	                max_row =   row;
	            }
	        }

	        // 一番値が大きい行と入れ替え
	        if (max_row != pivot) 
	        {
	            double tmp;
	            for (int col = 0; col < N; col++) 
	            {
	                tmp            =   a[max_row,col];
	                a[max_row,col] =   a[pivot,col];
	                a[pivot,col]   =   tmp;
	            }
	            tmp         =   b[max_row];
	            b[max_row]  =   b[pivot];
	            b[pivot]    =   tmp;
	        }
	    }
	}
	// １次元配列を表示
	private static void disp_vector(double[] row)
	{
        foreach (double col in row)
        	Console.Write(string.Format("{0,14:F10}\t", col));
    	Console.WriteLine();
	}
	// ２次元配列を表示
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
