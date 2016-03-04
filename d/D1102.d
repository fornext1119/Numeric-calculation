import std.stdio;
import std.math;

const int N = 4;

// 逆ベキ乗法で最小固有値を求める
void main(string[] args)
{
    double a[N][N] = [[5.0, 4.0, 1.0, 1.0], 
                      [4.0, 5.0, 1.0, 1.0], 
                      [1.0, 1.0, 4.0, 2.0],
                      [1.0, 1.0, 2.0, 4.0]];
	double x[N]    =  [1.0 ,0.0 ,0.0 ,0.0];

	// LU分解
	forward_elimination(a);
	
    // 逆ベキ乗法
    double lambda = inverse(a, x);

    writefln("\neigenvalue");
	writefln("%14.10f", lambda);

    writefln("eigenvector");
    disp_vector(x);
}

// 逆ベキ乗法
double inverse(double[N][N] a, ref double[N] x0)
{
    double lambda = 0.0;

    // 正規化 (ベクトル x0 の長さを１にする)
    normarize(x0);
	double e0 = 0.0;
    foreach (i; 0..N)
        e0 += x0[i];

    foreach (k; 1..200)
    {
        // １次元配列を表示
		writef("%3d\t", k);
        disp_vector(x0);

        // Ly = b から y を求める (前進代入)
        double[N] b = [0.0 ,0.0 ,0.0 ,0.0];
        double[N] y = [0.0 ,0.0 ,0.0 ,0.0];
	    foreach (i; 0..N)
            b[i] = x0[i];
        forward_substitution(a,y,b);
        // Ux = y から x を求める (後退代入)
        double[N] x1 = [0.0 ,0.0 ,0.0 ,0.0];
        backward_substitution(a,x1,y);
        
        // 内積
        double p0 = 0.0;
        double p1 = 0.0;
	    foreach (i; 0..N)
        {
            p0 += x1[i] * x1[i];
            p1 += x1[i] * x0[i];
        }
        // 固有値
        lambda = p1 / p0;

	    // 正規化 (ベクトル x1 の長さを１にする)
	    normarize(x1);
        // 収束判定
		double e1 = 0.0;
	    foreach (i; 0..N)
	        e1 += x1[i];
        if (fabs(e0 - e1) < 0.00000000001) break;

	    foreach (i; 0..N)
            x0[i] = x1[i];
        e0 = e1;
    }
	return lambda;
}
// LU分解
void forward_elimination(ref double[N][N] a)
{
    foreach (pivot; 0..N)
    {
        foreach (row; (pivot + 1)..N)
        {
            double s = a[row][pivot] / a[pivot][pivot];
            foreach (col; pivot..N)
                a[row][col] -= a[pivot][col] * s; // これが 上三角行列
            a[row][pivot] = s;                    // これが 下三角行列
        }
    }
}
// 前進代入
void forward_substitution(double[N][N] a, ref double[N] y, ref double[N] b)
{
    foreach (row; 0..N)
    {
        foreach (col; 0..row)
            b[row] -= a[row][col] * y[col];
        y[row] = b[row];
    }
}
// 後退代入
void backward_substitution(double[N][N] a, ref double[N] x, ref double[N] y)
{
    foreach_reverse (row; 0..N)
    {
        foreach_reverse (col; (row+1)..N)
            y[row] -= a[row][col] * x[col];
        x[row] = y[row] / a[row][row];
    }
}
// １次元配列を表示
void disp_vector(double[N] row)
{
    foreach(col; row)
        writef("%14.10f\t", col);
    writefln("");
}
// 正規化 (ベクトルの長さを１にする)
void normarize(ref double[N] x)
{
    double s = 0.0;

    foreach (i; 0..N)
        s += x[i] * x[i];
    s = sqrt(s);
    
    foreach (i; 0..N)
        x[i] /= s;
}
