#include <iostream>
#include <iomanip>
#include <math.h>

using namespace std;

double f0(double x)
{
    return x * x - 2;  
}
double f1(double x)
{
    return 2 * x;  
}
double f2(double x)
{
    return 2;  
}

double bailey(double x0) 
{
    double x1;
    while (true)
    {
        x1 = x0 - (f0(x0) / (f1(x0) - (f0(x0) * f2(x0) / (2 * f1(x0)))));
        cout << setw(12) << fixed << setprecision(10) << x1 << "\t";
        cout << setw(13) << fixed << setprecision(10) << x1 - sqrt(2) << endl;

        if (fabs(x1 - x0) < 0.0000000001) break;
        x0 = x1;
    }
    return x1;
}

int main()
{
    double x = 2.0;
    cout << setw(12) << fixed << setprecision(10) << bailey(x) << endl;
    return 0;
}
