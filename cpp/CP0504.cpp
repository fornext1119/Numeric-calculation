#include <iostream>
#include <iomanip>
#include <math>
using namespace std;

double myExp(double x, int n, double numerator, double denominator, double y);

int main()
{
    for (int i = -10; i <= 10; i++)
    {
        double x  = i / 4.0;
        // �W���̎w���֐�
        double d1 = exp(x);
        // ����̎w���֐�
        double d2 = myExp(x, 1, 1.0, 1.0, 1.0);
        // �W���֐��Ƃ̍���
        cout << setw(5)  << fixed << setprecision(2)  << x  << ":";
        cout << setw(14) << fixed << setprecision(10) << d1 << " - ";
        cout << setw(14) << fixed << setprecision(10) << d2 << " = ";
        cout << setw(14) << fixed << setprecision(10) << d1 - d2 << endl;
    }
    return 0;
}

// ����̎w���֐�
double myExp(double x, int n, double numerator, double denominator, double y)
{
    denominator = denominator * n;
    numerator   = numerator   * x;
    double a    = numerator / denominator;
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (fabs(a) <= 0.00000000001)
        return y;
    else
        return y + myExp(x, ++n, numerator, denominator, a);
}
