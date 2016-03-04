#include <iostream>
#include <iomanip>
#include <math.h>

using namespace std;

double g(double x)
{
    return (x / 2) + (1 / x);
}

double iterative(double x0) 
{
    double x1;
    while (true)
    {
        x1 = g(x0);
        cout << setw(12) << fixed << setprecision(10) << x1 << "\t";
        cout << setw(13) << fixed << setprecision(10) << x1 - sqrt(2) << endl;

        if (fabs(x1 - x0) < 0.0000000001) break;
        x0 = x1;
    }
    return x1;
}

int main()
{
    double x = 1.0;
    cout << setw(12) << fixed << setprecision(10) << iterative(x) << endl;
    return 0;
}
