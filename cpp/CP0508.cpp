#include <iostream>
#include <iomanip>
#include <math>
using namespace std;

double mySinh(double x, int n, double numerator, double denominator, double y);

int main()
{
    for (int x = -10; x <= 10; x++)
    {
        // Ž©ì‚Ì‘o‹Èü³Œ·ŠÖ”
        double d1 = mySinh(x, 1, x, 1.0, x);
        // •W€‚Ì‘o‹Èü³Œ·ŠÖ”
        double d2 = sinh(x);
        // •W€ŠÖ”‚Æ‚Ì·ˆÙ
        cout << setw(3)  << x << ":";
        cout << setw(17) << fixed << setprecision(10) << d1 << " - ";
        cout << setw(17) << fixed << setprecision(10) << d2 << " = ";
        cout << setw(17) << fixed << setprecision(10) << d1 - d2 << endl;
    }
    return 0;
}

// Ž©ì‚Ì‘o‹Èü³Œ·ŠÖ”
double mySinh(double x, int n, double numerator, double denominator, double y)
{
    int m       = 2 * n;
    denominator = denominator * (m + 1) * m;
    numerator   = numerator   * x * x;
    double a    = numerator / denominator;
    // \•ª‚È¸“x‚É‚È‚Á‚½‚çˆ—‚ð”²‚¯‚é
    if (fabs(a) <= 0.00000000001) 
        return y;
    else
        return y + mySinh(x, ++n, numerator, denominator, a);
}
