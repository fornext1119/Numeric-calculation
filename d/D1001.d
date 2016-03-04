import std.stdio;
import std.math;

const int N = 4;

void main(string[] args)
{
    double[N][N] a = [[9,2,1,1],[2,8,-2,1],[-1,-2,7,-2],[1,-1,-2,6]]; 
    double[N]    b = [20,16,8,17];
    double[N]    c = [0,0,0,0];

    // ヤコビの反復法
    jacobi(a,b,c);

    writefln("X");
    disp_vector(c);
}
// ヤコビの反復法
void jacobi(double[N][N] a, double[N] b, ref double[N] x0)
{
    while (true)
    {
        double[N] x1;
        bool finish = true;
        foreach(i; 0..N)
        {
            x1[i] = b[i];
            foreach(j; 0..N)
                if (j != i)
                    x1[i] -= a[i][j] * x0[j];

            x1[i] /= a[i][i];
            if (fabs(x1[i] - x0[i]) > 0.0000000001) finish = false;
        }
        foreach(i; 0..N)
            x0[i] = x1[i];
        if (finish) return;

        disp_vector(x0);
    }
}
// １次元配列を表示
void disp_vector(double[] row)
{
    foreach(col; row)
        writef("%14.10f\t", col);
    writefln("");
}
