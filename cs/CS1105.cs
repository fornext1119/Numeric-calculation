using System;

public class CS1105
{
    private const int N = 4;

	// ヤコビ法で固有値を求める
    public static void Main()
    {
        double[,] a = {{5.0, 4.0, 1.0, 1.0}, 
                       {4.0, 5.0, 1.0, 1.0}, 
                       {1.0, 1.0, 4.0, 2.0},
                       {1.0, 1.0, 2.0, 4.0}};
        double[,] v = {{1.0, 0.0, 0.0, 0.0}, 
                       {0.0, 1.0, 0.0, 0.0}, 
                       {0.0, 0.0, 1.0, 0.0},
                       {0.0, 0.0, 0.0, 1.0}};

        // ヤコビ法
        jacobi(a, v);

        Console.WriteLine();
        Console.WriteLine("eigenvalue");
		disp_eigenvalue(a);

        Console.WriteLine();
        Console.WriteLine("eigenvector");
		disp_eigenvector(v);
    }

    // ヤコビ法
    private static void jacobi(double[,] a, double[,] v)
    {
        for (int k = 1; k <= 100; k++)
        {
	        // 最大値を探す
			int p = 0;
			int q = 0;
	        double max_val = 0.0;
            for (int i = 0; i < N; i++)
            {
                for (int j = i + 1; j < N; j++)
                {
	                if (max_val < Math.Abs(a[i, j]))
	                {
	                    max_val = Math.Abs(a[i, j]);
	                    p = i;
	                    q = j;
					}
				}
			}

	        // θ を求める
	        double t = 0.0;
	        if (Math.Abs(a[p, p] - a[q, q]) < 0.00000000001)
	        {
	            // a_{pp} ＝ a_{qq} のとき、回転角ｔをπ/4にする
	            t = Math.PI / 4.0;
	            if (a[p, p] < 0)
	                t = -t;
	        }
	        else
	        {
	            // a_{pp} ≠ a_{qq} のとき
	            t = Math.Atan(2.0 * a[p, q] / (a[p, p] - a[q, q])) / 2.0;
	        }

	        // θ を使って 行列 U を作成し、A = U^t × A × U
	        double c = Math.Cos(t);
	        double s = Math.Sin(t);
	        // U^t × A
	        double t1 = 0.0;
	        double t2 = 0.0;
            for (int i = 0; i < N; i++)
            {
	            t1      =  a[p, i] * c + a[q, i] * s;
	            t2      = -a[p, i] * s + a[q, i] * c;
	            a[p, i] = t1;
	            a[q, i] = t2;
	            // 固有ベクトル
	            t1      =  v[p, i] * c + v[q, i] * s;
	            t2      = -v[p, i] * s + v[q, i] * c;
	            v[p, i] = t1;
	            v[q, i] = t2;
	        }
	        // A × U
            for (int i = 0; i < N; i++)
            {
	            t1      =  a[i, p] * c + a[i, q] * s;
	            t2      = -a[i, p] * s + a[i, q] * c;
	            a[i, p] = t1;
	            a[i, q] = t2;
	        }

	        // 対角要素を表示
	        Console.Write(string.Format("{0,3:D}\t", k));
	        disp_eigenvalue(a);

	        // 収束判定
        	if (max_val < 0.00000000001) break;
	    }
	}

    // 対角要素を表示
    private static void disp_eigenvalue(double[,] a)
    {
        for (int i = 0; i < N; i++)
            Console.Write(string.Format("{0,14:F10}\t", a[i,i]));
        Console.WriteLine();
    }
    // 固有ベクトルを表示
    private static void disp_eigenvector(double[,] matrix)
    {
        for (int i = 0; i < N; i++)
        {
			double[] row = new double[N];
            for (int j = 0; j < N; j++)
                row[j] = matrix[i, j] ;
	        normarize(row);
	        disp_vector(row);
		}
    }
    // １次元配列を表示
    private static void disp_vector(double[] row)
    {
        foreach (double col in row)
            Console.Write(string.Format("{0,14:F10}\t", col));
        Console.WriteLine();
    }
	// 正規化 (ベクトルの長さを１にする)
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
