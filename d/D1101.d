import std.stdio;
import std.math;

const int N = 4;

// ベキ乗法で最大固有値を求める
void main(string[] args)
{
    double a[N][N] = [[5.0, 4.0, 1.0, 1.0], 
                      [4.0, 5.0, 1.0, 1.0], 
                      [1.0, 1.0, 4.0, 2.0],
                      [1.0, 1.0, 2.0, 4.0]];
	double x[N]    =  [1.0 ,0.0 ,0.0 ,0.0];

    // ベキ乗法
    double lambda = power(a, x);

    writefln("\neigenvalue");
	writefln("%14.10f", lambda);

    writefln("eigenvector");
    disp_vector(x);
}

// ベキ乗法
double power(double[N][N] a, ref double[N] x0)
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

    	// 行列の積 x1 = A × x0 
        double[N] x1 = [0.0 ,0.0 ,0.0 ,0.0];
	    foreach (i; 0..N)
	    	foreach (j; 0..N)
                x1[i] += a[i][j] * x0[j];
        
        // 内積
        double p0 = 0.0;
        double p1 = 0.0;
	    foreach (i; 0..N)
        {
            p0 += x1[i] * x1[i];
            p1 += x1[i] * x0[i];
        }
        // 固有値
        lambda = p0 / p1;

	    // 正規化 (ベクトル x1 の長さを１にする)
	    normarize(x1);
		double e1 = 0.0;
        // 収束判定
	    foreach (i; 0..N)
        	e1 += x1[i];
        if (fabs(e0 - e1) < 0.00000000001) break;

	    foreach (i; 0..N)
            x0[i] = x1[i];
        e0 = e1;
    }
	return lambda;
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
