#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;

// 元の関数
double f(double x);
// 導関数
double fd(double x);
// Heun法
void heun(double x, double y, int n, double max);

int main(void)
{
    double x = 0.0;
    double y = f(x);
    double max = 4;

    for (int n = 4; n <= 128; n *= 2) {
        cout << "分割数 = ";
        cout << n << endl;
        euler(x, y, n, max);
    }
    return 0;
}

// 元の関数
double f(double x)
{
    return x - pow(x,3) / (3 * 2) + pow(x,5) / (5 * 4 * 3 * 2);
}
// 導関数
double fd(double x)
{
    return 1 - pow(x,2) / 2 + pow(x,4) / (4 * 3 * 2);
}
// Heun法
void heun(double x, double y, int n, double max)
{
    double h = max / n;

    for (int i = 1; i <= n; i++) {
        y = y + h * (fd(x) + fd(x + h)) / 2;
        x = x + h;
        double z = f(x);

        // 元の関数と比較
        cout << setw(8) << fixed << setprecision(5) << x     << "\t";
        cout << setw(8) << fixed << setprecision(5) << y     << "\t";
        cout << setw(8) << fixed << setprecision(5) << z     << "\t";
        cout << setw(8) << fixed << setprecision(5) << y - z << endl;
    }
}
