#import <Foundation/Foundation.h>

double myLog(double x, int n, double t);

int main()
{
    int i;
    for (i = 1; i <= 20; i++)
    {
        double x  = i / 5.0;
        // �W���̑ΐ��֐�
        double d1 = log(x);
        // ����̑ΐ��֐�
        double d2 = myLog(x - 1, 27, 0.0); // 27:�K�v�Ȑ��x��������\���傫�Ȋ
        // �W���֐��Ƃ̍���
        printf("%+04.2f : %+013.10f - %+013.10f = %+13.10f\n", x, d1, d2, d1 - d2);
    }
    return 0;
}

// ����̑ΐ��֐�
double myLog(double x, int n, double t)
{
    int    n2 = n;
    double x2 = x;
    if (n > 3)
    {
        if (n % 2 == 0)
            n2 = 2;
        x2 = x * (n / 2);
    }
    t = x2 / (n2 + t);

    if (n <= 2)
        return x / (1 + t);
    else
        return myLog(x, --n, t);
}
