#include <iostream>
#include <iomanip>
#include <math.h>

using namespace std;

double f(double x)
{
    return x * x - 2;
}

double bisection(double a, double b) 
{
    double c;
    while (true)
    {
        // 区間 (a, b) の中点 c = (a + b) / 2
        c = (a + b) / 2;
        cout << setw(12) << fixed << setprecision(10) << c << "\t";
        cout << setw(13) << fixed << setprecision(10) << c - sqrt(2) << endl;

        double fc = f(c);
        if (fabs(fc) < 0.0000000001) break;

        if (fc < 0)
        {
            // f(c) < 0 であれば, 解は区間 (c, b) の中に存在
            a = c;
        }
        else
        {
            // f(c) > 0 であれば, 解は区間 (a, c) の中に存在
            b = c;
        }
    }
    return c;
}

int main()
{
    double a = 1;
    double b = 2;
    cout << setw(12) << fixed << setprecision(10) << bisection(a, b) << endl;
    return 0;
}
