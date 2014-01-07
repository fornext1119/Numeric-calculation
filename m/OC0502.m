#import <Foundation/Foundation.h>

double myCos(double x, int n, bool nega, double numerator, double denominator, double y);

int main()
{
    int degree;
    for (degree = 0; degree <= 360; degree += 15)
    {
        if (degree % 30 == 0 || degree % 45 == 0)
        {
            double radian = degree * M_PI / 180.0;
            // ����̗]���֐�
            double d1     = myCos(radian, 1, false, 1.0, 1.0, 1.0);
            // �W���̗]���֐�
            double d2     = cos(radian);
            // �W���֐��Ƃ̍���
            printf("%03d : %+13.10f - %+13.10f = %+13.10f\n", degree, d1, d2, d1 - d2);
        }
    }
    return 0;
}

// ����̗]���֐�
double myCos(double x, int n, bool nega, double numerator, double denominator, double y)
{
    int m       = 2 * n;
    denominator = denominator * m * (m - 1);
    numerator   = numerator   * x * x;
    double a    = numerator / denominator;
    // �\���Ȑ��x�ɂȂ����珈���𔲂���
    if (a <= 0.00000000001) 
        return y;
    else
        return y + myCos(x, ++n, !nega, numerator, denominator, nega ? a : -a);
}
