#include <iostream>
#include <iomanip>
#include <math>
using namespace std;

double myLog(double x2, double numerator, double denominator, double y);

int main()
{
    for (int i = 1; i <= 20; i++)
    {
        double x  = i / 5.0;
        // 標準の対数関数
        double d1 = log(x);
        // 自作の対数関数
        double x2 = (x - 1) / (x + 1);  
        double d2 = 2 * myLog(x2, x2, 1.0, x2);
        // 標準関数との差異
        cout << setw(5)  << fixed << setprecision(2)  << x  << ":";
        cout << setw(14) << fixed << setprecision(10) << d1 << " - ";
        cout << setw(14) << fixed << setprecision(10) << d2 << " = ";
        cout << setw(14) << fixed << setprecision(10) << d1 - d2 << endl;
    }
    return 0;
}

// 自作の対数関数
double myLog(double x2, double numerator, double denominator, double y)
{
    denominator = denominator + 2;
    numerator   = numerator   * x2 * x2;
    double a    = numerator / denominator;
    // 十分な精度になったら処理を抜ける
    if (fabs(a) <= 0.00000000001)
        return y;
    else
        return y + myLog(x2, numerator, denominator, a);
}
