#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;

// �f�[�^�_�̐�
const int N = 7; 

// ���̊֐�
double f(double x);

// Newton (�j���[�g��) ���
double newton(double d, double x[], double a[]);

int main()
{
    double x[N], y[N];

    // 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
    for (int i = 0; i < N; i++)
    {
        double d = i * 1.5 - 4.5;
        x[i] = d;
        y[i] = f(d);
    }

    // �������̕\�����
    double d[N][N];
    for (int j = 0; j < N; j++)
        d[0][j] = y[j];

    for (int i = 1; i < N; i++)
    {
        for (int j = 0; j < N - i; j++)
            d[i][j] = (d[i-1][j+1] - d[i-1][j]) / (x[j+i] - x[j]);
    }

    // ���K������
    double a[N]; 
    for (int j = 0; j < N; j++)
        a[j] = d[j][0];

    // 0.5���݂� �^�����Ă��Ȃ��l����
    for (int i = 0; i <= 18; i++)
    {
        double d  = i * 0.5 - 4.5;
        double d1 = f(d);
        double d2 = newton(d, x, a);

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

// Newton (�j���[�g��) ���
double newton(double d, double x[], double a[])
{
    double sum = a[0];
    for (int i = 1; i < N; i++)
    {
        double prod = a[i];
        for (int j = 0; j < i; j++)
            prod *= (d - x[j]);
        sum += prod;
    }

    return sum;
}
