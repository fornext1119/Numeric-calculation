#import <Foundation/Foundation.h>
#import <math.h>

double g(double x)
{
    return (x / 2) + (1 / x);
}

double iterative(double x0)
{
    double x1;
    while (YES)
    {
        x1 = g(x0);
        printf("%12.10f\t%13.10f\n", x1, x1 - sqrt(2));

        if (fabs(x1 - x0) < 0.0000000001) break;
        x0 = x1;
    }
    return x1;
}

int main()
{
    double x = 1;
    printf("%12.10f\n", iterative(x));
    return 0;
}
