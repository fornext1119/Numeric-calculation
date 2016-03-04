#include <iostream>
#include <iomanip>
#include <math>

using namespace std;

double f(double x)
{
    return 4 / (1 + x * x); 
}

int main()
{
    const double a = 0;
    const double b = 1;

    // Simpson‘¥‚ÅÏ•ª
    int n = 2;
    for (int j = 1; j <= 5; j++)
    {
        double h = (b - a) / n;  
        double s2 = 0;
        double s4 = 0;
        double x = a + h;
        for (int i = 1; i <= n / 2; i++)
        {
            s4 += f(x);
            x  += h;
            s2 += f(x);
            x  += h;
        }
        s2 = (s2 - f(b)) * 2 + f(a) + f(b);
        s4 *= 4;
        double s = (s2 + s4) * h / 3;
        n *= 2;

        // Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
        cout << setw(2)  << j << ":";
        cout << setw(13) << fixed << setprecision(10) << s        << ", ";
        cout << setw(13) << fixed << setprecision(10) << s - M_PI << endl;
    }

    return 0;
}
