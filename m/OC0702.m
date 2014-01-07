#import <Foundation/Foundation.h>
#import <math.h>

// �f�[�^�_�̐�
const int N = 7; 

// ���̊֐�
double f(double x);

// Neville (�l���B��) ���
double neville(double d, double x[], double y[]);

int main()
{
    double x[N], y[N];

    // 1.5���݂� -4.5�`4.5 �܂�, �V�_�����l���Z�b�g
	int i;
    for (i = 0; i < N; i++)
    {
        double d = i * 1.5 - 4.5;
        x[i] = d;
        y[i] = f(d);
    }

    // 0.5���݂� �^�����Ă��Ȃ��l����
    for (i = 0; i <= 18; i++)
    {
        double d  = i * 0.5 - 4.5;
        double d1 = f(d);
        double d2 = neville(d, x, y);

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

// Neville (�l���B��) ���
double neville(double d, double x[], double y[])
{
	int i, j;
    double w[N][N];
    for (i = 0; i < N; i++)
        w[0][i] = y[i];

    for (j = 1; j < N; j++)
    {
        for (i = 0; i < N - j; i++)
              w[j][i] = w[j-1][i+1] + (w[j-1][i+1] - w[j-1][i]) * (d - x[i+j]) / (x[i+j] - x[i]);
    }

    return w[N-1][0];
}
