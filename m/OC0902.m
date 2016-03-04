#import <Foundation/Foundation.h>
#import <math.h>

double f(double x)
{
    return x * x - 2;
}

double falseposition(double a, double b)
{
    double c;
    while (YES)
    {
        // �_ (a,f(a)) �� �_ (b,f(b)) �����Ԓ����� x���̌�_
        c = (a * f(b) - b * f(a)) / (f(b) - f(a));
        printf("%12.10f\t%13.10f\n", c, c - sqrt(2));

        double fc = f(c);
        if (fabs(fc) < 0.0000000001) break;

        if (fc < 0)
        {
            // f(c) < 0 �ł����, ���͋�� (c, b) �̒��ɑ���
            a = c;
        }
        else
        {
            // f(c) > 0 �ł����, ���͋�� (a, c) �̒��ɑ���
            b = c;
        }
    }
    return c;
}

int main()
{
    double a = 1;
    double b = 2;
    printf("%12.10f\n", falseposition(a, b));
    return 0;
}
