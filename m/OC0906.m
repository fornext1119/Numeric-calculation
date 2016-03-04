#import <Foundation/Foundation.h>
#import <math.h>

double f(double x)
{
    return x * x - 2;  
}

double secant(double x0, double x1)
{
    double x2;
    while (YES)
    {
        x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0));
        printf("%12.10f\t%13.10f\n", x2, x2 - sqrt(2));

        if (fabs(x2 - x1) < 0.0000000001) break;
        x0 = x1;
        x1 = x2;
    }
    return x2;
}

int main()
{
    double x0 = 1;
    double x1 = 2;
    printf("%12.10f\n", secant(x0, x1));
    return 0;
}
