#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;

const int N = 4;

// ピボット選択
void pivoting(double a[N][N], double b[N]);
// 前進消去
void forward_elimination(double a[N][N], double b[N]);
// 後退代入
void backward_substitution(double a[N][N], double b[N]);
// １次元配列を表示
void disp_vector(double row[N]);
// ２次元配列を表示
void disp_matrix(double matrix[N][N]);

// ガウスの消去法
int main()
{
    double a[N][N] = {{-1,-2,7,-2},{1,-1,-2,6},{9,2,1,1},{2,8,-2,1}}; 
    double b[N]    = {8,17,20,16};

    // ピボット選択
    pivoting(a,b);

    cout << "pivoting" << endl;
    cout << "A" << endl;
    disp_matrix(a);
    cout << "B" << endl;
    disp_vector(b);
    cout << endl;

    // 前進消去
    forward_elimination(a,b);

    cout << "forward elimination" << endl;
    cout << "A" << endl;
    disp_matrix(a);
    cout << "B" << endl;
    disp_vector(b);
    cout << endl;

    // 後退代入
    backward_substitution(a,b);

    cout << "X" << endl;
    disp_vector(b);
   
    return 0;
}
// 前進消去
void forward_elimination(double a[N][N], double b[N])
{
    for (int pivot = 0; pivot < N - 1; pivot++)
    {
        for (int row = pivot + 1; row < N; row++)
        {
            double  s   = a[row][pivot] / a[pivot][pivot];
            for (int col = pivot; col < N; col++)
                a[row][col] -= a[pivot][col]    * s;
            b[row]          -= b[pivot]         * s;
        }
    }
}
// 後退代入
void backward_substitution(double a[N][N], double b[N])
{
    for (int row = N - 1; row >= 0; row--)
    {
        for (int col = N - 1; col > row; col--)
            b[row] -= a[row][col] * b[col];
        b[row] /= a[row][row];
    }
}
// ピボット選択
void pivoting(double a[N][N], double b[N])
{
    for(int pivot = 0; pivot < N; pivot++)
    {
        // 各列で 一番値が大きい行を 探す
        int     max_row =   pivot;
        double  max_val =   0;
        for (int row = pivot; row < N; row++)
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
            for (int col = 0; col < N; col++)
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
void disp_vector(double row[N])
{
    for (int i = 0; i < N; i++)
        cout << setw(14) << fixed << setprecision(10) << row[i] << "\t";
    cout << endl;
}
// ２次元配列を表示
void disp_matrix(double matrix[N][N])
{
    for (int i = 0; i < N; i++) 
    {
        for (int j = 0; j < N; j++) 
            cout << setw(14) << fixed << setprecision(10) << matrix[i][j] << "\t";
        cout << endl;
    }
}
