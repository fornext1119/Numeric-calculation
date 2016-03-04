#include <iostream>
#include <iomanip>
#include <math>
using namespace std;

double myExp(double x, double x2, int n, double t);

int main()
{
    for (int i = -10; i <= 10; i++)
    {
        double x  = i / 4.0;
        // 標準の指数関数
        double d1 = exp(x);
        // 自作の指数関数
        double x2 = x * x;
        double d2 = myExp(x, x2, 30, 0.0); // 30:必要な精度が得られるよう, 6から始めて4ずつ増加させる
        // 標準関数との差異
        cout << setw(5)  << fixed << setprecision(2)  << x  << ":";
        cout << setw(14) << fixed << setprecision(10) << d1 << " - ";
        cout << setw(14) << fixed << setprecision(10) << d2 << " = ";
        cout << setw(14) << fixed << setprecision(10) << d1 - d2 << endl;
    }
    return 0;
}

// 自作の指数関数
double myExp(double x, double x2, int n, double t)
{
    t = x2 / (n + t);
    n -= 4;  

    if (n < 6)
        return 1 + ((2 * x) / (2 - x + t));
    else
        return myExp(x, x2, n, t);
}
