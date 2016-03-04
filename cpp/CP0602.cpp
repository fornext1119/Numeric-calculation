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

    // ’†“_‘¥‚ÅÏ•ª
    int n = 2;
    for (int j = 1; j <= 10; j++)
    {
        double h = (b - a) / n;  
        double s = 0;
        double x = a + (h / 2);
        for (int i = 1; i <= n; i++)
        {
            s += f(x);
            x += h;
        }
        s *= h;
        n *= 2;

        // Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
        cout << setw(2)  << j << ":";
        cout << setw(13) << fixed << setprecision(10) << s        << ", ";
        cout << setw(13) << fixed << setprecision(10) << s - M_PI << endl;
    }

    return 0;
}
