import std.stdio;
import std.math;

const int N = 4;

// コレスキー法
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

    writefln("LL^T");
	disp_matrix(a);

    // Ly=b から y を求める (前進代入)
    double y[N] = [0,0,0,0];
    forward_substitution(a,b,y);

    writefln("Y");
    disp_vector(y);

    // L^Tx=y から x を求める (後退代入)
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
        double s = 0;
        foreach (col; 0..pivot)
            s += a[pivot][col] * a[pivot][col];
        // ここで根号の中が負の値になると計算できない！
        a[pivot][pivot] = sqrt(a[pivot][pivot] - s);

        foreach (row; (pivot + 1)..N) 
		{
            s = a[row][pivot] / a[pivot][pivot];
			s = 0;
            foreach (col; 0..pivot)
                s += a[row][col] * a[pivot][col]; //
            a[row][pivot] =  (a[row][pivot] - s) / a[pivot][pivot];
            a[pivot][row] =  a[row][pivot];
        }
    }
}
// 前進代入
void forward_substitution(double[N][N] a, double[N] b, ref double[N] y) 
{
    foreach (row; 0..N) 
	{
        foreach (col; 0..row)
            b[row] -= a[row][col] * y[col];
        y[row] = b[row] / a[row][row];
    }
}
// 後退代入
void backward_substitution(double[N][N] a, double[N] y, ref double[N] x) 
{
    foreach_reverse (row; 0..N) 
    {
        foreach_reverse (col; (row+1)..N)
            y[row] -= a[col][row] * x[col];
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
