#include <iostream>
#include <iomanip>
#include <math.h>

using namespace std;

double f(double x)
{
    return x * x - 2;  
}

double secant(double x0, double x1) 
{
    double x2;
    while (true)
    {
        x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0));
        cout << setw(12) << fixed << setprecision(10) << x2 << "\t";
        cout << setw(13) << fixed << setprecision(10) << x2 - sqrt(2) << endl;

        if (fabs(x2 - x1) < 0.0000000001) break;
        x0 = x1;
        x1 = x2;
    }
    return x2;
}

int main()
{
    double x0 = 1;
    double x1 = 2;
    cout << setw(12) << fixed << setprecision(10) << secant(x0, x1) << endl;
    return 0;
}
