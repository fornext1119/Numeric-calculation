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
        // ��� (a, b) �̒��_ c = (a + b) / 2
        c = (a + b) / 2;
        cout << setw(12) << fixed << setprecision(10) << c << "\t";
        cout << setw(13) << fixed << setprecision(10) << c - sqrt(2) << endl;

        double fc = f(c);
        if (fabs(fc) < 0.0000000001) break;

        if (fc < 0)
        {
            // f(c) < 0 �ł����, ���͋�� (c, b) �̒��ɑ���
            a = c;
        }
        else
        {
            // f(c) > 0 �ł����, ���͋�� (a, c) �̒��ɑ���
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
