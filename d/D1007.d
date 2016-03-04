import std.stdio;
import std.math;

const int N = 4;

// 修正コレスキー法
void main(string[] args)
{
    double[N][N] a = [[5,2,3,4],[2,10,6,7],[3,6,15,9],[4,7,9,20]]; 
    double[N]    b = [34,68,96,125];

    writefln("A");
	disp_matrix(a);
    writefln("B");
    disp_vector(b);
    writefln("");

    // 前進消去
    forward_elimination(a,b);

    writefln("LDL^T");
	disp_matrix(a);

    // Ly=b から y を求める (前進代入)
    double y[N] = [0,0,0,0];
    forward_substitution(a,b,y);

    writefln("Y");
    disp_vector(y);

    // DL^Tx=y から x を求める (後退代入)
    double x[N] = [0,0,0,0];
    backward_substitution(a,y,x);

    writefln("X");
    disp_vector(x);
}
// 前進消去
void forward_elimination(ref double[N][N] a, double[N] b) 
{
    foreach (pivot; 0..N) 
	{
        double s;

        // pivot < k の場合
        foreach (col; 0..pivot)
		{
            s = a[pivot][col];
            foreach (k; 0..col)
                s -= a[pivot][k] * a[col][k] * a[k][k];
            a[pivot][col] = s / a[col][col];
            a[col][pivot] = a[pivot][col];
        }
 
        // pivot == k の場合
        s = a[pivot][pivot];
        foreach (k; 0..pivot)
            s -= a[pivot][k] * a[pivot][k] * a[k][k];
        a[pivot][pivot] = s;
    }
}
// 前進代入
void forward_substitution(double[N][N] a, double[N] b, ref double[N] y) 
{
    foreach (row; 0..N) 
	{
        foreach (col; 0..row)
            b[row] -= a[row][col] * y[col];
        y[row] = b[row];
    }
}
// 後退代入
void backward_substitution(double[N][N] a, double[N] y, ref double[N] x) 
{
    foreach_reverse (row; 0..N) 
    {
        foreach_reverse (col; (row+1)..N)
            y[row] -= a[col][row] * a[row][row] * x[col];
        x[row] = y[row] / a[row][row];
    }
}
// １次元配列を表示
void disp_vector(double[] row)
{
	foreach(col; row)
        writef("%14.10f\t", col);
    writefln("");
}
// ２次元配列を表示
void disp_matrix(double[N][N] matrix)
{
	foreach(row; matrix)
	{
		foreach(col; row)
	        writef("%14.10f\t", col);
	    writefln("");
	}
}
