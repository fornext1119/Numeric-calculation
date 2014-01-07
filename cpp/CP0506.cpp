#include <iostream>
#include <iomanip>
#include <math>
using namespace std;

double myLog(double x2, double numerator, double denominator, double y);

int main()
{
    for (int i = 1; i <= 20; i++)
    {
        double x  = i / 5.0;
        // �W���̑ΐ��֐�
        double d1 = log(x);
        // ����̑ΐ��֐�
        double x2 = (x - 1) / (x + 1);  
        double d2 = 2 * myLog(x2, x2, 1.0, x2);
        // �W���֐��Ƃ̍���
        cout << setw(5)  << fixed << setprecision(2)  << x  << ":";
        cout << setw(14) << fixed << setprecision(10) << d1 << " - ";
        cout << setw(14) << fixed << setprecision(10) << d2 << " = ";
        cout << setw(14) << fixed << setprecision(10) << d1 - d2 << endl;
    }
    return 0;
}

// ����̑ΐ��֐�
double myLog(double x2, double numerator, double denominator, double y)
{
    denominator = denominator + 2;
    numerator   = numerator   * x2 * x2;
    double a    = numerator / denominator;
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (fabs(a) <= 0.00000000001)
        return y;
    else
        return y + myLog(x2, numerator, denominator, a);
}
