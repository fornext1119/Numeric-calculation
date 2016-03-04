import std.stdio;
import std.math;

const int N = 4;

// QR分解で固有値を求める
void main(string[] args)
{
    double a[N][N] = [[5.0, 4.0, 1.0, 1.0], 
                      [4.0, 5.0, 1.0, 1.0], 
                      [1.0, 1.0, 4.0, 2.0],
                      [1.0, 1.0, 2.0, 4.0]];
	double q[N][N] = [[0.0 ,0.0 ,0.0 ,0.0],
	                  [0.0 ,0.0 ,0.0 ,0.0],
	                  [0.0 ,0.0 ,0.0 ,0.0],
	                  [0.0 ,0.0 ,0.0 ,0.0]];
	double r[N][N] = [[0.0 ,0.0 ,0.0 ,0.0],
	                  [0.0 ,0.0 ,0.0 ,0.0],
	                  [0.0 ,0.0 ,0.0 ,0.0],
	                  [0.0 ,0.0 ,0.0 ,0.0]];

    foreach (k; 1..200)
    {
	    // QR分解
	    decomp(a, q, r);
        // 行列の積
        multiply(r, q, a);
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
// QR分解
void decomp(double[N][N] a, ref double[N][N] q, ref double[N][N] r)
{
	double x[N] = [0.0 ,0.0 ,0.0 ,0.0];

    foreach (k; 0..N)
    {
        foreach (i; 0..N)
            x[i] = a[i][k];

        foreach (j; 0..k)
		{
			double t = 0.0;
	        foreach (i; 0..N)
                t += a[i][k] * q[i][j];
            r[j][k] = t;
            r[k][j] = 0.0;
	        foreach (i; 0..N)
        		x[i] -= t * q[i][j];
		}

		double s = 0.0;
        foreach (i; 0..N)
            s += x[i] * x[i];
		r[k][k] = sqrt(s);
        foreach (i; 0..N)
            q[i][k] = x[i] / r[k][k];
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
