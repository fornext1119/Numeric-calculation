#include <iostream>
#include <iomanip>
#include <math>
using namespace std;

double myTan(double x, double x2, int n, double t);

int main()
{
    for (int degree = -90; degree <= 90; degree += 15)
    {
        if ((degree + 90) % 180 != 0)
        {
            double radian = degree * M_PI / 180.0;
            double x2     = radian * radian;
            // ����̐��ڊ֐�
            double d1     = myTan(radian, x2, 15, 0.0); // 15:�K�v�Ȑ��x��������\���傫�Ȋ
            // �W���̐��ڊ֐�
            double d2     = tan(radian);
            // �W���֐��Ƃ̍���
            cout << setw(3)  << degree << ":";
            cout << setw(14) << fixed << setprecision(10) << d1 << " - ";
            cout << setw(14) << fixed << setprecision(10) << d2 << " = ";
            cout << setw(14) << fixed << setprecision(10) << d1 - d2 << endl;
        }
    }
    return 0;
}

// ����̐��ڊ֐�
double myTan(double x, double x2, int n, double t)
{
    t = x2 / (n - t);
    n -= 2;  
    if (n <= 1) 
        return x / (1 - t);
    else
        return myTan(x, x2, n, t);
}
