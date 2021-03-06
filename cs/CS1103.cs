using System;

public class CS1103
{
    private const int N = 4;

    // LRªðÅÅLlðßé
    public static void Main()
    {
        double[,] a = {{5.0, 4.0, 1.0, 1.0}, 
                       {4.0, 5.0, 1.0, 1.0}, 
                       {1.0, 1.0, 4.0, 2.0},
                       {1.0, 1.0, 2.0, 4.0}};
        double[,] l = new double[N,N];
        double[,] u = new double[N,N];

        for (int k = 1; k <= 200; k++)
        {
            // LUªð
            decomp(a, l, u);
            // sñÌÏ
            multiply(u, l, a);
            // Îpvfð\¦
            Console.Write(string.Format("{0,3:D}\t", k));
            disp_eigenvalue(a);
            
            // û©»è
            double e = 0.0;
            for (int i = 1; i < N; i++)
                for (int j = 0; j < i; j++)
                    e += Math.Abs(a[i, j]);
            if (e < 0.00000000001) break;
        }

        Console.WriteLine();
        Console.WriteLine("eigenvalue");
        disp_eigenvalue(a);
    }

    // LUªð
    private static void decomp(double[,] a, double[,] l, double[,] u)
    {
        for (int i = 0; i < N; i++)
        {
            for (int j = 0; j < N; j++)
            {
                l[i, j] = 0.0;
                u[i, j] = 0.0;
            }
        }
        
        l[0, 0] = 1.0;
        for (int j = 0; j < N; j++)
            u[0, j] = a[0, j];

        for (int i = 1; i < N; i++)
        {
            u[i, 0] = 0.0;
            l[0, i] = 0.0;
            l[i, 0] = a[i, 0] / u[0, 0];
        }
        for (int i = 1; i < N; i++)
        {
            l[i, i] = 1.0;
            double t = a[i, i];
            for (int k = 0; k <= i; k++)
                t -= l[i, k] * u[k, i];
            u[i, i] = t;
            for (int j = i + 1; j < N; j++)
            {
                u[j, i] = 0.0;
                l[i, j] = 0.0;
                t       = a[j, i];
                for (int k = 0; k <= i; k++)
                    t -= l[j, k] * u[k, i];
                l[j, i] = t / u[i, i];
                t       = a[i, j];
                for (int k = 0; k <= i; k++)
                    t -= l[i, k] * u[k, j];
                u[i, j] = t;
            }
        }
    }
    // sñÌÏ
    private static void multiply(double[,] a, double[,] b, double[,] c)
    {
        for (int i = 0; i < N; i++)
        {
            for (int j = 0; j < N; j++)
            {
                double s = 0.0;
                for (int k = 0; k < N; k++)
                    s += a[i, k] * b[k, j];
                c[i,j] = s;
            }
        }
    }
    
    // Îpvfð\¦
    private static void disp_eigenvalue(double[,] a)
    {
        for (int i = 0; i < N; i++)
            Console.Write(string.Format("{0,14:F10}\t", a[i,i]));
        Console.WriteLine();
    }
}
