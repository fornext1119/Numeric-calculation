import std.stdio;
import std.math;

const int N = 4;

// LR分解で固有値を求める
void main(string[] args)
{
    double a[N][N] = [[5.0, 4.0, 1.0, 1.0], 
                      [4.0, 5.0, 1.0, 1.0], 
                      [1.0, 1.0, 4.0, 2.0],
                      [1.0, 1.0, 2.0, 4.0]];
	double l[N][N] = [[0.0 ,0.0 ,0.0 ,0.0],
	                  [0.0 ,0.0 ,0.0 ,0.0],
	                  [0.0 ,0.0 ,0.0 ,0.0],
	                  [0.0 ,0.0 ,0.0 ,0.0]];
	double u[N][N] = [[0.0 ,0.0 ,0.0 ,0.0],
	                  [0.0 ,0.0 ,0.0 ,0.0],
	                  [0.0 ,0.0 ,0.0 ,0.0],
	                  [0.0 ,0.0 ,0.0 ,0.0]];

    foreach (k; 1..200)
    {
	    // LU分解
	    decomp(a, l, u);
        // 行列の積
        multiply(u, l, a);
        // 対角要素を表示
		writef("%3d\t", k);
        disp_eigenvalue(a);
        
        // 収束判定
    	double e = 0.0;
	    foreach (i; 1..N)
		    foreach (j; 0..i)
                e += fabs(a[i][j]);
        if (e < 0.00000000001) break;
	}

    writefln("\neigenvalue");
    disp_eigenvalue(a);
}
// LU分解
void decomp(double[N][N] a, ref double[N][N] l, ref double[N][N] u)
{
    foreach (i; 0..N)
    {
	    foreach (j; 0..N)
		{
            l[i][j] = 0.0;
            u[i][j] = 0.0;
		}
	}
	
    l[0][0] = 1.0;
    foreach (j; 0..N)
        u[0][j] = a[0][j];

    foreach (i; 1..N)
    {
        u[i][0] = 0.0;
        l[0][i] = 0.0;
        l[i][0] = a[i][0] / u[0][0];
    }
    foreach (i; 1..N)
    {
        l[i][i] = 1.0;
        double t = a[i][i];
	    foreach (k; 0..i + 1)
            t -= l[i][k] * u[k][i];
        u[i][i] = t;
	    foreach (j; i + 1..N)
        {
            u[j][i] = 0.0;
            l[i][j] = 0.0;
            t       = a[j][i];
		    foreach (k; 0..i + 1)
                t -= l[j][k] * u[k][i];
            l[j][i] = t / u[i][i];
            t       = a[i][j];
		    foreach (k; 0..i + 1)
                t -= l[i][k] * u[k][j];
            u[i][j] = t;
        }
    }
}
// 行列の積
void multiply(double[N][N] a, double[N][N] b, ref double[N][N] c)
{
    foreach (i; 0..N)
    {
        foreach (j; 0..N)
    	{
			double s = 0.0;
	        foreach (k; 0..N)
                s += a[i][k] * b[k][j];
            c[i][j] = s;
        }
    }
}
// 対角要素を表示
void disp_eigenvalue(double[N][N] a)
{
    foreach (i; 0..N)
		writef("%14.10f\t", a[i][i]);
    writefln("");
}
