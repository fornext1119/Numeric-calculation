using System;

public class CS1101
{
    private const int N = 4;

    // ベキ乗法で最大固有値を求める
    public static void Main()
    {
        double[,] a = {{5.0, 4.0, 1.0, 1.0}, 
                       {4.0, 5.0, 1.0, 1.0}, 
                       {1.0, 1.0, 4.0, 2.0},
                       {1.0, 1.0, 2.0, 4.0}};
        double[]  x  = {1.0 ,0.0 ,0.0 ,0.0};

        // ベキ乗法
        double lambda = power(a, x);

        Console.WriteLine();
        Console.WriteLine("eigenvalue");
        Console.WriteLine(string.Format("{0,14:F10}", lambda));

        Console.WriteLine("eigenvector");
        disp_vector(x);
    }

    // ベキ乗法
    private static double power(double[,] a, double[] x0)
    {
        double lambda = 0.0;
        
        // 正規化 (ベクトル x0 の長さを１にする)
        normarize(x0);
        double e0 = 0.0;
        for (int i = 0; i < N; i++)
            e0 += x0[i];

        for (int k = 1; k <= 200; k++)
        {
            // １次元配列を表示
            Console.Write(string.Format("{0,3:D}\t", k));
            disp_vector(x0);

            // 行列の積 x1 = A × x0 
            double[] x1 = new double[N];
            for (int i = 0; i < N; i++)
                for (int j = 0; j < N; j++)
                    x1[i] += a[i, j] * x0[j];
            
            // 内積
            double p0 = 0.0;
            double p1 = 0.0;
            for (int i = 0; i < N; i++)
            {
                p0 += x1[i] * x1[i];
                p1 += x1[i] * x0[i];
            }
            // 固有値
            lambda = p0 / p1;

            // 正規化 (ベクトル x1 の長さを１にする)
            normarize(x1);
            // 収束判定
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
