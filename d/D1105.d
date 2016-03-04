import std.stdio;
import std.math;

const int N = 4;

// ヤコビ法で固有値を求める
void main(string[] args)
{
    double a[N][N] = [[5.0, 4.0, 1.0, 1.0], 
                      [4.0, 5.0, 1.0, 1.0], 
                      [1.0, 1.0, 4.0, 2.0],
                      [1.0, 1.0, 2.0, 4.0]];
	double v[N][N] = [[1.0 ,0.0 ,0.0 ,0.0],
	                  [0.0 ,1.0 ,0.0 ,0.0],
	                  [0.0 ,0.0 ,1.0 ,0.0],
	                  [0.0 ,0.0 ,0.0 ,1.0]];

    // ヤコビ法
    jacobi(a, v);

    writefln("\neigenvalue");
	disp_eigenvalue(a);

    writefln("\neigenvector");
	disp_eigenvector(v);
}

// ヤコビ法
void jacobi(ref double[N][N] a, ref double[N][N] v)
{
    foreach (k; 1..100)
    {
        // 最大値を探す
		int p = 0;
		int q = 0;
        double max_val = 0.0;
        foreach (i; 0..N)
        {
            foreach (j; i + 1..N)
            {
                if (max_val < fabs(a[i][j]))
                {
                    max_val = fabs(a[i][j]);
                    p = i;
                    q = j;
				}
			}
		}

        // θ を求める
        double t = 0.0;
        if (fabs(a[p][p] - a[q][q]) < 0.00000000001)
        {
            // a_{pp} ＝ a_{qq} のとき、回転角ｔをπ/4にする
            t = PI / 4.0;
            if (a[p][p] < 0)
                t = -t;
        }
        else
        {
            // a_{pp} ≠ a_{qq} のとき
            t = atan(2.0 * a[p][q] / (a[p][p] - a[q][q])) / 2.0;
        }

        // θ を使って 行列 U を作成し、A = U^t × A × U
        double c = cos(t);
        double s = sin(t);
        // U^t × A
        double t1 = 0.0;
        double t2 = 0.0;
        foreach (i; 0..N)
        {
            t1      =  a[p][i] * c + a[q][i] * s;
            t2      = -a[p][i] * s + a[q][i] * c;
            a[p][i] = t1;
            a[q][i] = t2;
            // 固有ベクトル
            t1      =  v[p][i] * c + v[q][i] * s;
            t2      = -v[p][i] * s + v[q][i] * c;
            v[p][i] = t1;
            v[q][i] = t2;
        }
        // A × U
        foreach (i; 0..N)
        {
            t1      =  a[i][p] * c + a[i][q] * s;
            t2      = -a[i][p] * s + a[i][q] * c;
            a[i][p] = t1;
            a[i][q] = t2;
        }

        // 対角要素を表示
		writef("%3d\t", k);
        disp_eigenvalue(a);

        // 収束判定
    	if (max_val < 0.00000000001) break;
    }
}

// 対角要素を表示
void disp_eigenvalue(double[N][N] a)
{
    foreach (i; 0..N)
		writef("%14.10f\t", a[i][i]);
    writefln("");
}
// 固有ベクトルを表示
void disp_eigenvector(double[N][N] matrix)
{
    foreach (i; 0..N)
    {
		double row[N];
        foreach (j; 0..N)
            row[j] = matrix[i][j] ;
        normarize(row);
        disp_vector(row);
	}
}
// １次元配列を表示
void disp_vector(double[N] row)
{
    foreach (i; 0..N)
		writef("%14.10f\t", row[i]);
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
