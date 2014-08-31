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
// 状態を確認
void disp_progress(double a[N][N], double b[N]);

// ガウス・ジョルダン法
int main()
{
    double a[N][N] = {{-1,-2,7,-2},{1,-1,-2,6},{9,2,1,1},{2,8,-2,1}}; 
    double b[N]    = {8,17,20,16};
    
    // ピボット選択
    pivoting(a,b);
    cout << "ピボット選択後" << endl;
    disp_progress(a,b);

    // 前進消去
    forward_elimination(a,b);
    cout << "前進消去後" << endl;
    disp_progress(a,b);
    
    // 後退代入
    backward_substitution(a,b);
    cout << "解" << endl;
    for (int i = 0; i < N; i++)
        cout << setw(14) << fixed << setprecision(10) << b[i] << "\t";
    cout << endl;
   
    return 0;
}
// 前進消去
void forward_elimination(double a[N][N], double b[N])
{
    // 対角線上の係数を 1 にする
    for (int pivot = 0; pivot < N; pivot++)
    {
        double s  = a[pivot][pivot];
        for (int col = 0; col < N; col++)
            a[pivot][col] /= s;
         b[pivot] /= s;
    }
    cout << "対角線上の係数を 1 にする" << endl;
    disp_progress(a,b);

    // 対角行列にする
    for (int pivot = 0; pivot < N; pivot++)
    {
        for (int row = 0; row < N; row++)
        {
            if (row == pivot) continue;

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
    for (int pivot = 0; pivot < N; pivot++)
        b[pivot]  /= a[pivot][pivot];
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
// 状態を確認
void disp_progress(double a[N][N], double b[N])
{
    for (int i = 0; i < N; i++) 
    {
        for (int j = 0; j < N; j++) 
            cout << setw(14) << fixed << setprecision(10) << a[i][j] << "\t";
        cout << setw(14) << fixed << setprecision(10) << b[i] << endl;
    }
    cout << endl;
}
