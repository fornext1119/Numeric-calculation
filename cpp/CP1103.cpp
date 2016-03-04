#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;

const int N = 4;

// LU分解
void decomp(double a[N][N], double l[N][N], double u[N][N]);
// 行列の積
void multiply(double a[N][N], double b[N][N], double c[N][N]);
// 対角要素を表示
void disp_eigenvalue(double a[N][N]);

// LR分解で固有値を求める
int main()
{
    double a[N][N] = {{5.0, 4.0, 1.0, 1.0}, 
                      {4.0, 5.0, 1.0, 1.0}, 
                      {1.0, 1.0, 4.0, 2.0},
                      {1.0, 1.0, 2.0, 4.0}};
    double l[N][N] = {{0.0 ,0.0 ,0.0 ,0.0},
                      {0.0 ,0.0 ,0.0 ,0.0},
                      {0.0 ,0.0 ,0.0 ,0.0},
                      {0.0 ,0.0 ,0.0 ,0.0}};
    double u[N][N] = {{0.0 ,0.0 ,0.0 ,0.0},
                      {0.0 ,0.0 ,0.0 ,0.0},
                      {0.0 ,0.0 ,0.0 ,0.0},
                      {0.0 ,0.0 ,0.0 ,0.0}};

    for (int k = 1; k <= 200; k++)
    {
        // LU分解
        decomp(a, l, u);
        // 行列の積
        multiply(u, l, a);
        // 対角要素を表示
        cout << setw(3) << k << "\t";
        disp_eigenvalue(a);
        
        // 収束判定
        double e = 0.0;
        for (int i = 1; i < N; i++)
            for (int j = 0; j < i; j++)
                e += fabs(a[i][j]);
        if (e < 0.00000000001) break;
    }

    cout << endl << "eigenvalue" << endl;
    disp_eigenvalue(a);

    return 0;
}
// LU分解
void decomp(double a[N][N], double l[N][N], double u[N][N])
{
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < N; j++)
        {
            l[i][j] = 0.0;
            u[i][j] = 0.0;
        }
    }
    
    l[0][0] = 1.0;
    for (int j = 0; j < N; j++)
        u[0][j] = a[0][j];

    for (int i = 1; i < N; i++)
    {
        u[i][0] = 0.0;
        l[0][i] = 0.0;
        l[i][0] = a[i][0] / u[0][0];
    }
    for (int i = 1; i < N; i++)
    {
        l[i][i] = 1.0;
        double t = a[i][i];
        for (int k = 0; k <= i; k++)
            t -= l[i][k] * u[k][i];
        u[i][i] = t;
        for (int j = i + 1; j < N; j++)
        {
            u[j][i] = 0.0;
            l[i][j] = 0.0;
            t       = a[j][i];
            for (int k = 0; k <= i; k++)
                t -= l[j][k] * u[k][i];
            l[j][i] = t / u[i][i];
            t       = a[i][j];
            for (int k = 0; k <= i; k++)
                t -= l[i][k] * u[k][j];
            u[i][j] = t;
        }
    }
}
// 行列の積
void multiply(double a[N][N], double b[N][N], double c[N][N])
{
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < N; j++)
        {
            double s = 0.0;
            for (int k = 0; k < N; k++)
                s += a[i][k] * b[k][j];
            c[i][j] = s;
        }
    }
}
// 対角要素を表示
void disp_eigenvalue(double a[N][N])
{
    for (int i = 0; i < N; i++)
        cout << setw(14) << fixed << setprecision(10) << a[i][i] << "\t";
    cout << endl;
}
