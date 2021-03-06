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
        // 点 (a,f(a)) と 点 (b,f(b)) を結ぶ直線と x軸の交点
        c = (a * f(b) - b * f(a)) / (f(b) - f(a));
        printf("%12.10f\t%13.10f\n", c, c - sqrt(2));

        double fc = f(c);
        if (fabs(fc) < 0.0000000001) break;

        if (fc < 0)
        {
            // f(c) < 0 であれば, 解は区間 (c, b) の中に存在
            a = c;
        }
        else
        {
            // f(c) > 0 であれば, 解は区間 (a, c) の中に存在
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
