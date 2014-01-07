#include <iostream>
#include <iomanip>
#include <math>
using namespace std;

double myExp(double x, int n, double numerator, double denominator, double y);

int main()
{
    for (int i = -10; i <= 10; i++)
    {
        double x  = i / 4.0;
        // 標準の指数関数
        double d1 = exp(x);
        // 自作の指数関数
        double d2 = myExp(x, 1, 1.0, 1.0, 1.0);
        // 標準関数との差異
        cout << setw(5)  << fixed << setprecision(2)  << x  << ":";
        cout << setw(14) << fixed << setprecision(10) << d1 << " - ";
        cout << setw(14) << fixed << setprecision(10) << d2 << " = ";
        cout << setw(14) << fixed << setprecision(10) << d1 - d2 << endl;
    }
    return 0;
}

// 自作の指数関数
double myExp(double x, int n, double numerator, double denominator, double y)
{
    denominator = denominator * n;
    numerator   = numerator   * x;
    double a    = numerator / denominator;
    // 十分な精度になったら処理を抜ける
    if (fabs(a) <= 0.00000000001)
        return y;
    else
        return y + myExp(x, ++n, numerator, denominator, a);
}
