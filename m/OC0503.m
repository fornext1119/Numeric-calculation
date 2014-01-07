#import <Foundation/Foundation.h>

double myTan(double x, double x2, int n, double t);

int main()
{
    int degree;
    for (degree = -90; degree <= 90; degree += 15)
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
            printf("%+03d : %+13.10f - %+13.10f = %+13.10f\n", degree, d1, d2, d1 - d2);
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
