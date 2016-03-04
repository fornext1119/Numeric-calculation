using System;

public class CS1106
{
    private const int N = 4;

	// ハウスホルダー変換とQR分解で固有値を求める
    public static void Main()
    {
        double[,] a = {{5.0, 4.0, 1.0, 1.0}, 
                       {4.0, 5.0, 1.0, 1.0}, 
                       {1.0, 1.0, 4.0, 2.0},
                       {1.0, 1.0, 2.0, 4.0}};
        double[] d = new double[N]; 
        double[] e = new double[N]; 

        // ハウスホルダー変換
        tridiagonalize(a, d, e);

		// QR分解
		decomp(a, d, e);

        Console.WriteLine();
        Console.WriteLine("eigenvalue");
		disp_vector(d);

        Console.WriteLine();
        Console.WriteLine("eigenvector");
		disp_matrix(a);
    }

    // ハウスホルダー変換
    private static void tridiagonalize(double[,] a, double[] d, double[] e)
    {
        double[] w = new double[N]; 
        double[] v = new double[N]; 

        for (int k = 0; k < N - 2; k++)
        {
	        d[k] = a[k, k];

	        double t = 0.0;
	        for (int i = k + 1; i < N; i++)
	        {
	            w[i] =  a[i, k];
	            t    += w[i] * w[i];
	        }
	        double s = Math.Sqrt(t);
	        if (w[k + 1] < 0)
	            s = -s;

	        if (Math.Abs(s) < 0.00000000001)
	            e[k + 1] = 0.0;
	        else
	        {
	            e[k + 1]  = -s;
	            w[k + 1] +=  s;
	            s = 1 / Math.Sqrt(w[k + 1] * s);
	        	for (int i = k + 1; i < N; i++)
	                w[i] *= s;

	        	for (int i = k + 1; i < N; i++)
	        	{
	                s = 0.0;
		        	for (int j = k + 1; j < N; j++)
		        	{
	                    if (j <= i)
	                        s += a[i, j] * w[j];
	                    else
	                        s += a[j, i] * w[j];
	                }
	                v[i] = s;
	            }

	            s = 0.0;
	        	for (int i = k + 1; i < N; i++)
	                s += w[i] * v[i];
	            s /= 2.0;
	        	for (int i = k + 1; i < N; i++)
	                v[i] -= s * w[i];
	        	for (int i = k + 1; i < N; i++)
		        	for (int j = k + 1; j <= i; j++)
	                    a[i, j] -= w[i] * v[j] + w[j] * v[i];
	            // 次の行は固有ベクトルを求めないなら不要
	        	for (int i = k + 1; i < N; i++)
	                a[i, k] = w[i];
	        } 
	    }

	    d[N - 2] = a[N - 2, N - 2];
	    d[N - 1] = a[N - 1, N - 1];
	    
	    e[0]     = 0.0;  
	    e[N - 1] = a[N - 1, N - 2];

	    // 次の行は固有ベクトルを求めないなら不要
    	for (int k = N - 1; k >= 0; k--)
	    {
	        w = new double[] {0.0 ,0.0 ,0.0 ,0.0};
	        if (k < N - 2)
	        {
    			for (int i = k + 1; i < N; i++)
	                w[i] = a[i, k];
    			for (int i = k + 1; i < N; i++)
	            {
	                double s = 0.0;
	    			for (int j = k + 1; j < N; j++)
	                    s += a[i, j] * w[j];
	                v[i] = s;
	            }
    			for (int i = k + 1; i < N; i++)
	    			for (int j = k + 1; j < N; j++)
	                    a[i, j] -= v[i] * w[j];
	        }
			for (int i = 0; i < N; i++)
	            a[i, k] = 0.0;
	        a[k, k] = 1.0;
	    }
	}

	// QR分解
    private static void decomp(double[,] a, double[] d, double[] e)
    {
	    e[0] = 1.0;
	    int h = N - 1;
	    while (Math.Abs(e[h]) < 0.00000000001) h--;

	    while (h > 0)
	    {
	        e[0] = 0.0;
	        int l = h - 1;
	        while (Math.Abs(e[l]) >= 0.00000000001) l--;
	        
	        for (int j = 1; j <= 100; j++)
	        {
	            double w = (d[h - 1] - d[h]) / 2.0;
	            double s = Math.Sqrt(w * w + e[h] * e[h]);
	            if (w < 0.0)
	                s = -s;

	            double x = d[l] - d[h] + e[h] * e[h] / (w + s);
	            double y = e[l + 1];
	            double z = 0.0;
	            double t = 0.0;
	            double u = 0.0;
	            for (int k = l; k < h; k++)
	            {
	                if (Math.Abs(x) >= Math.Abs(y))
	                {
	                    t = -y / x;
	                    u = 1 / Math.Sqrt(t * t + 1.0);
	                    s = t * u;
	                }
	                else
	                {
	                    t = -x / y;
	                    s = 1 / Math.Sqrt(t * t + 1.0);
	                    if (t < 0)
	                        s = -s;
	                    u = t * s;
	                }
	                w = d[k] - d[k + 1];
	                t = (w * s + 2 * u * e[k + 1]) * s;
	                d[k    ] = d[k    ] - t;
	                d[k + 1] = d[k + 1] + t;
	                e[k    ] = u * e[k] - s * z;
	                e[k + 1] = e[k + 1] * (u * u - s * s) + w * s * u;

	                // 次の行は固有ベクトルを求めないなら不要
	                for (int i = 0; i < N; i++)
	                {
	                    x = a[k    , i];  
	                    y = a[k + 1, i];
	                    a[k    , i] = u * x - s * y;
	                    a[k + 1, i] = s * x + u * y;
	                }

	                if (k < N - 2)
	                {
	                    x = e[k + 1];  
	                    y = -s * e[k + 2];  
	                    z = y;
	                    e[k + 2] = u * e[k + 2];
	                }
	            }

            	Console.Write(string.Format("{0,3:D}\t", j));
				disp_vector(d);

		        // 収束判定
				if (Math.Abs(e[h]) < 0.00000000001) break;
	        }

	        e[0] = 1.0;  
	        while (Math.Abs(e[h]) < 0.00000000001) h--;
	    }

	    // 次の行は固有ベクトルを求めないなら不要
	    for (int k = 0; k < N - 1; k++)
	    {
	        int l = k;
	        for (int i = k + 1; i < N; i++) 
	            if (d[i] > d[l])
	                l = i;

	        double t = d[k];  
	        d[k] = d[l];  
	        d[l] = t;

			for (int i = 0; i < N; i++)
			{
		        t       = a[k, i];  
		        a[k, i] = a[l, i];  
		        a[l, i] = t;
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
        for (int row = 0; row < N; row++)
        {
        	for (int col = 0; col < N; col++)
            	Console.Write(string.Format("{0,14:F10}\t", matrix[row,col]));
	        Console.WriteLine();
        }
    }
}
