#include <iostream>
#include <iomanip>
#include <math.h>

using namespace std;

double f(double x)
{
    return x * x - 2;
}

double falseposition(double a, double b) 
{
    double c;
    while (true)
    {
        // “_ (a,f(a)) ‚Æ “_ (b,f(b)) ‚ğŒ‹‚Ô’¼ü‚Æ x²‚ÌŒğ“_
        c = (a * f(b) - b * f(a)) / (f(b) - f(a));
        cout << setw(12) << fixed << setprecision(10) << c << "\t";
        cout << setw(13) << fixed << setprecision(10) << c - sqrt(2) << endl;

        double fc = f(c);
        if (fabs(fc) < 0.0000000001) break;

        if (fc < 0)
        {
            // f(c) < 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (c, b) ‚Ì’†‚É‘¶İ
            a = c;
        }
        else
        {
            // f(c) > 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (a, c) ‚Ì’†‚É‘¶İ
            b = c;
        }
    }
    return c;
}

int main()
{
    double a = 1;
    double b = 2;
    cout << setw(12) << fixed << setprecision(10) << falseposition(a, b) << endl;
    return 0;
}
