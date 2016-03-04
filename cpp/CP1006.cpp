#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;

const int N = 4;

// 前進消去
void forward_elimination(double a[N][N]);
// 前進代入
void forward_substitution(double a[N][N], double b[N], double y[N]);
// 後退代入
void backward_substitution(double a[N][N], double y[N], double x[N]);
// １次元配列を表示
void disp_vector(double row[N]);
// ２次元配列を表示
void disp_matrix(double matrix[N][N]);

// コレスキー法
int main()
{
    double a[N][N] = {{5,2,3,4},{2,10,6,7},{3,6,15,9},{4,7,9,20}}; 
    double b[N]    = {34,68,96,125};

    cout << "A" << endl;
    disp_matrix(a);
    cout << "B" << endl;
    disp_vector(b);
    cout << endl;

    // 前進消去
    forward_elimination(a);

    cout << "LL^T" << endl;
    disp_matrix(a);

    // Ly=b から y を求める (前進代入)
    double y[N] = {0,0,0,0};
    forward_substitution(a, b, y);

    cout << "Y" << endl;
    disp_vector(y);

    // L^Tx=y から x を求める (後退代入)
    double x[N] = {0,0,0,0};
    backward_substitution(a, y, x);
    
    cout << "X" << endl;
    disp_vector(x);

    return 0;
}
// 前進消去
void forward_elimination(double a[N][N])
{
    for (int pivot = 0; pivot < N; pivot++)
    {
        double s = 0;
        for (int col = 0; col < pivot; col++)
            s += a[pivot][col] * a[pivot][col];
        // ここで根号の中が負の値になると計算できない！
        a[pivot][pivot] = sqrt(a[pivot][pivot] - s);

        for (int row = pivot + 1; row < N; row++)
        {
            s = 0;
            for (int col = 0; col < pivot; col++)
                s += a[row][col] * a[pivot][col];
            a[row][pivot] =  (a[row][pivot] - s) / a[pivot][pivot];
            a[pivot][row] =  a[row][pivot];
        } 
    }
}
// 前進代入
void forward_substitution(double a[N][N], double b[N], double y[N])
{
    for (int row = 0; row < N; row++)
    {
        for (int col = 0; col < row; col++)
            b[row] -= a[row][col] * y[col];
        y[row] = b[row] / a[row][row];
    }
}
// 後退代入
void backward_substitution(double a[N][N], double y[N], double x[N])
{
    for (int row = N - 1; row >= 0; row--)
    {
        for (int col = N - 1; col > row; col--)
            y[row] -= a[row][col] * x[col];
        x[row] = y[row] / a[row][row];
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
