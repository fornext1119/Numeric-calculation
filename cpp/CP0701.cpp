#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;

// データ点の数
const int N = 7; 

// 元の関数
double f(double x);

// Lagrange (ラグランジュ) 補間
double lagrange(double d, double x[], double y[]);

int main()
{
    double x[N], y[N];

    // 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
    for (int i = 0; i < N; i++)
    {
        double d = i * 1.5 - 4.5;
        x[i] = d;
        y[i] = f(d);
    }

    // 0.5刻みで 与えられていない値を補間
    for (int i = 0; i <= 18; i++)
    {
        double d  = i * 0.5 - 4.5;
        double d1 = f(d);
        double d2 = lagrange(d, x, y);

        // 元の関数と比較
        cout << setw(5) << fixed << setprecision(2) << d       << '\t'; 
        cout << setw(8) << fixed << setprecision(5) << d1      << '\t'; 
        cout << setw(8) << fixed << setprecision(5) << d2      << '\t'; 
        cout << setw(8) << fixed << setprecision(5) << d1 - d2 << endl; 
    }

   return 0;
}

// 元の関数
double f(double x)
{
    return x - pow(x,3) / (3 * 2) + pow(x,5) / (5 * 4 * 3 * 2);
}

// Lagrange (ラグランジュ) 補間
double lagrange(double d, double x[], double y[])
{
    double sum = 0;
    for (int i = 0; i < N; i++)
    {
        double prod = y[i];
        for (int j = 0; j < N; j++)
        {
            if (j != i)
                prod *= (d - x[j]) / (x[i] - x[j]);
        }
        sum += prod;
    }
    return sum;
}
