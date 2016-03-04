#import <Foundation/Foundation.h>
#import <math.h>

double f0(double x)
{
    return x * x - 2;  
}
double f1(double x)
{
    return 2 * x;  
}
double f2(double x)
{
    return 2;  
}

double bailey(double x0)
{
    double x1;
    while (YES)
    {
        x1 = x0 - (f0(x0) / (f1(x0) - (f0(x0) * f2(x0) / (2 * f1(x0)))));
        printf("%12.10f\t%13.10f\n", x1, x1 - sqrt(2));

        if (fabs(x1 - x0) < 0.0000000001) break;
        x0 = x1;
    }
    return x1;
}

int main()
{
    double x = 2;
    printf("%12.10f\n", bailey(x));
    return 0;
}
