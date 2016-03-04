#import <Foundation/Foundation.h>
#import <math.h>

// �f�[�^�_�̐�
const int N = 7; 

// ���̊֐�
double f(double x);

// Newton (�j���[�g��) ���
double newton(double d, double x[], double a[]);

int main()
{
	int i, j;
    double x[N], y[N];

    // 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
    for (i = 0; i < N; i++)
    {
        double d = i * 1.5 - 4.5;
        x[i] = d;
        y[i] = f(d);
    }

    // �������̕\�����
    double d[N][N];
    for (j = 0; j < N; j++)
        d[0][j] = y[j];

    for (i = 1; i < N; i++)
    {
        for (j = 0; j < N - i; j++)
            d[i][j] = (d[i-1][j+1] - d[i-1][j]) / (x[j+i] - x[j]);
    }

    // ���K������
    double a[N]; 
    for (j = 0; j < N; j++)
        a[j] = d[j][0];

    // 0.5���݂� �^�����Ă��Ȃ��l����
    for (i = 0; i <= 18; i++)
    {
        double d  = i * 0.5 - 4.5;
        double d1 = f(d);
        double d2 = newton(d, x, a);

        // ���̊֐��Ɣ�r
        printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", d, d1, d2, d1 - d2);
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
	int i, j;
    double sum = a[0];
    for (i = 1; i < N; i++)
    {
        double prod = a[i];
        for (j = 0; j < i; j++)
            prod *= (d - x[j]);
        sum += prod;
    }

    return sum;
}
