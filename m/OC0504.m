#import <Foundation/Foundation.h>

double myExp(double x, int n, double numerator, double denominator, double y);

int main()
{
    int i;
    for (i = -10; i <= 10; i++)
    {
        double x   = i / 4.0;
        // �W���̎w���֐�
        double d1  = exp(x);
        // ����̎w���֐�
        double d2  = myExp(x, 1, 1.0, 1.0, 1.0);
        // �W���֐��Ƃ̍���
        printf("%+04.2f : %+014.10f - %+014.10f = %+13.10f\n", x, d1, d2, d1 - d2);
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
