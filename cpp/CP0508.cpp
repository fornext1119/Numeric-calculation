#include <iostream>
#include <iomanip>
#include <math>
using namespace std;

double mySinh(double x, int n, double numerator, double denominator, double y);

int main()
{
    for (int x = -10; x <= 10; x++)
    {
        // ����̑o�Ȑ������֐�
        double d1 = mySinh(x, 1, x, 1.0, x);
        // �W���̑o�Ȑ������֐�
        double d2 = sinh(x);
        // �W���֐��Ƃ̍���
        cout << setw(3)  << x << ":";
        cout << setw(17) << fixed << setprecision(10) << d1 << " - ";
        cout << setw(17) << fixed << setprecision(10) << d2 << " = ";
        cout << setw(17) << fixed << setprecision(10) << d1 - d2 << endl;
    }
    return 0;
}

// ����̑o�Ȑ������֐�
double mySinh(double x, int n, double numerator, double denominator, double y)
{
    int m       = 2 * n;
    denominator = denominator * (m + 1) * m;
    numerator   = numerator   * x * x;
    double a    = numerator / denominator;
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (fabs(a) <= 0.00000000001) 
        return y;
    else
        return y + mySinh(x, ++n, numerator, denominator, a);
}
