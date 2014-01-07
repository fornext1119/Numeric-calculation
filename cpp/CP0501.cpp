#include <iostream>
#include <iomanip>
#include <math>
using namespace std;

double mySin(double x, int n, bool nega, double numerator, double denominator, double y);

int main()
{
    for (int degree = 0; degree <= 360; degree += 15)
    {
        if (degree % 30 == 0 || degree % 45 == 0)
        {
            double radian = degree * M_PI / 180.0;
            // ����̐����֐�
            double d1     = mySin(radian, 1, false, radian, 1.0, radian);
            // �W���̐����֐�
            double d2     = sin(radian);
            // �W���֐��Ƃ̍���
            cout << setw(3)  << degree << ":";
            cout << setw(14) << fixed << setprecision(10) << d1 << " - ";
            cout << setw(14) << fixed << setprecision(10) << d2 << " = ";
            cout << setw(14) << fixed << setprecision(10) << d1 - d2 << endl;
        }
    }
    return 0;
}

// ����̐����֐�
double mySin(double x, int n, bool nega, double numerator, double denominator, double y)
{
    int m       = 2 * n;
    denominator = denominator * (m + 1) * m;
    numerator   = numerator   * x * x;
    double a    = numerator / denominator;
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (a <= 0.00000000001) 
        return y;
    else
        return y + mySin(x, ++n, !nega, numerator, denominator, nega ? a : -a);
}
