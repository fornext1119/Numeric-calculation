using System;

public class CS0704
{
    // データ点の数
    private const int N   =  7; 
    private const int Nx2 = 14; 

    public static void Main()
    {
        double[] x  = new double[N];
        double[] y  = new double[N];
        double[] yd = new double[N];

	    // 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
	    for (int i = 0; i < N; i++)
	    {
	        double d1 = i * 1.5 - 4.5;
            x[i]  = d1;
            y[i]  = f(d1);
            yd[i] = fd(d1);
        }

	    // 差分商の表を作る
        double[]  z = new double[Nx2];
        double[,] d = new double[Nx2,Nx2];
	    for (int i = 0; i < Nx2; i++)
	    {
	        int j  = i / 2;
	        z[i]   = x[j];
	        d[0,i] = y[j];
		}
	    for (int i = 1; i < Nx2; i++)
	    {
	        for (int j = 0; j < Nx2 - i; j++)
	        {
	            if (i == 1 && j % 2 == 0)
	                d[i,j] = yd[j / 2];
	            else
		            d[i,j] = (d[i-1,j+1] - d[i-1,j]) / (z[j+i] - z[j]);
		    }
	    }

	    // ｎ階差分商
        double[] a = new double[Nx2];
	    for (int j = 0; j < Nx2; j++)
	        a[j] = d[j,0];

	    // 0.5刻みで 与えられていない値を補間
	    for (int i = 0; i <= 18; i++)
	    {
	        double d1 = i * 0.5 - 4.5;
            double d2 = f(d1);
            double d3 = hermite(d1, z, a);

            // 元の関数と比較
            Console.WriteLine(string.Format("{0,5:F2}\t{1,8:F5}\t{2,8:F5}\t{3,8:F5}", d1, d2, d3, d2 - d3));
        }
    }

    // 元の関数
    private static double f(double x)
    {
	    return x - Math.Pow(x,3) / (3 * 2) + Math.Pow(x,5) / (5 * 4 * 3 * 2);
    }
	// 導関数
	private static double fd(double x)
	{
	    return 1 - Math.Pow(x,2) / 2 + Math.Pow(x,4) / (4 * 3 * 2); 
	}

	// Hermite (エルミート) 補間
    private static double hermite(double d, double[] z, double[] a)
    {
	    double sum = a[0];
	    for (int i = 1; i < Nx2; i++)
	    {
	        double prod = a[i];
	        for (int j = 0; j < i; j++)
	            prod *= (d - z[j]);
	        sum += prod;
	    }

	    return sum;
    }
}
