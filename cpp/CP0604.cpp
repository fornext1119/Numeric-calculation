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

    double t[7][7];

    // ��`���Őϕ�
    int n = 2;
    for (int i = 1; i <= 6; i++)
    {
        double h = (b - a) / n;  
        double s = 0;
        double x = a;
        for (int j = 1; j <= n - 1; j++)
        {
            x += h;
            s += f(x);
        }
        // ���ʂ�ۑ�
        t[i][1] = h * ((f(a) + f(b)) / 2 + s);
        n *= 2;
    }

    // Richardson�̕�O�@
    n = 4;
    for (int j = 2; j <= 6; j++)
    {
        for (int i = j; i <= 6; i++)
        {
            t[i][j] = t[i][j - 1] + (t[i][j - 1] - t[i - 1][j - 1]) / (n - 1);
            if (i == j)
            {
                // ���ʂ� �� �Ɣ�r
                cout << setw(2)  << j << ":";
                cout << setw(13) << fixed << setprecision(10) << t[i][j]        << ", ";
                cout << setw(13) << fixed << setprecision(10) << t[i][j] - M_PI << endl;
            }
        }
        n *= 4;
    }

    return 0;
}
