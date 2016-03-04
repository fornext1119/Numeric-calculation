#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;

// �f�[�^�_�̐�
const int N   = 7; 
const int Nx2 = 14; 

// ���̊֐�
double f(double x);

// ���֐�
double fd(double x);

// Hermite (�G���~�[�g) ���
double hermite(double d, double z[], double a[]);

int main()
{
    double x[N], y[N], yd[N];

    // 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
    for (int i = 0; i < N; i++)
    {
        double d = i * 1.5 - 4.5;
        x[i]  = d;
        y[i]  = f(d);
        yd[i] = fd(d);
    }

    // �������̕\�����
    double z[Nx2];
    double d[Nx2][Nx2];
    for (int i = 0; i < Nx2; i++)
    {
        int j   = i / 2;
        z[i]    = x[j];
        d[0][i] = y[j];
    }

    for (int i = 1; i < Nx2; i++)
    {
        for (int j = 0; j < Nx2 - i; j++)
        {
            if (i == 1 && j % 2 == 0)
                d[i][j] = yd[j / 2];
            else
                d[i][j] = (d[i-1][j+1] - d[i-1][j]) / (z[j+i] - z[j]);
        }
    }

    // ���K������
    double a[Nx2]; 
    for (int j = 0; j < Nx2; j++)
        a[j] = d[j][0];

    // 0.5���݂� �^�����Ă��Ȃ��l����
    for (int i = 0; i <= 18; i++)
    {
        double d  = i * 0.5 - 4.5;
        double d1 = f(d);
        double d2 = hermite(d, z, a);

        // ���̊֐��Ɣ�r
        cout << setw(5) << fixed << setprecision(2) << d       << '\t'; 
        cout << setw(8) << fixed << setprecision(5) << d1      << '\t'; 
        cout << setw(8) << fixed << setprecision(5) << d2      << '\t'; 
        cout << setw(8) << fixed << setprecision(5) << d1 - d2 << endl; 
    }

   return 0;
}

// ���̊֐�
double f(double x)
{
    return x - pow(x,3) / (3 * 2) + pow(x,5) / (5 * 4 * 3 * 2);
}
// ���֐�
double fd(double x)
{
    return 1 - pow(x,2) / 2 + pow(x,4) / (4 * 3 * 2); 
}

// Hermite (�G���~�[�g) ���
double hermite(double d, double z[], double a[])
{
    double sum = a[0];
    for (int i = 1; i < Nx2; i++)
    {
        double prod = a[i];
        for (int j = 0; j < i; j++)
            prod *= (d - z[j]);
        sum += prod;
    }

    return sum;
}
