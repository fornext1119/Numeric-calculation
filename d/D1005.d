import std.stdio;
import std.math;

const int N = 4;

// LU分解
void main(string[] args)
{
    double[N][N] a = [[-1,-2,7,-2],[1,-1,-2,6],[9,2,1,1],[2,8,-2,1]]; 
    double[N]    b = [8,17,20,16];

    // ピボット選択
    pivoting(a,b);

    writefln("pivoting");
    writefln("A");
	disp_matrix(a);
    writefln("B");
    disp_vector(b);
    writefln("");

    // 前進消去
    forward_elimination(a,b);

    writefln("LU");
	disp_matrix(a);

    // Ly=b から y を求める (前進代入)
    double y[N] = [0,0,0,0];
    forward_substitution(a,b,y);

    writefln("Y");
    disp_vector(y);

    // Ux=y から x を求める (後退代入)
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
        foreach (row; (pivot + 1)..N) 
		{
            double s = a[row][pivot] / a[pivot][pivot];
            foreach (col; pivot..N)
                a[row][col] -= a[pivot][col] * s; // これが 上三角行列
            a[row][pivot] = s;                    // これが 下三角行列
            // b[row]    -= b[pivot] * s;         // この値は変更しない
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
        y[row] = b[row];
    }
}
// 後退代入
void backward_substitution(double[N][N] a, double[N] y, ref double[N] x) 
{
    foreach_reverse (row; 0..N) 
    {
        foreach_reverse (col; (row+1)..N)
            y[row] -= a[row][col] * x[col];
        x[row] = y[row] / a[row][row];
    }
}
// ピボット選択
void pivoting(ref double[N][N] a, ref double[N] b) 
{
    foreach (pivot; 0..N) 
	{
        // 各列で 一番値が大きい行を 探す
        int     max_row =   pivot;
        double  max_val =   0;
        foreach (row; pivot..N) 
		{
            if (fabs(a[row][pivot]) > max_val) 
			{
                // 一番値が大きい行
                max_val =   fabs(a[row][pivot]);
                max_row =   row;
            }
        }

        // 一番値が大きい行と入れ替え
        if (max_row != pivot) 
		{
			double tmp;
            foreach (col; 0..N) 
            {
                tmp             =   a[max_row][col];
                a[max_row][col] =   a[pivot][col];
                a[pivot][col]   =   tmp;
            }
            tmp         =   b[max_row];
            b[max_row]  =   b[pivot];
            b[pivot]    =   tmp;
        }
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
