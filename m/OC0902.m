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
        // “_ (a,f(a)) ‚Æ “_ (b,f(b)) ‚ğŒ‹‚Ô’¼ü‚Æ x²‚ÌŒğ“_
        c = (a * f(b) - b * f(a)) / (f(b) - f(a));
        printf("%12.10f\t%13.10f\n", c, c - sqrt(2));

        double fc = f(c);
        if (fabs(fc) < 0.0000000001) break;

        if (fc < 0)
        {
            // f(c) < 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (c, b) ‚Ì’†‚É‘¶İ
            a = c;
        }
        else
        {
            // f(c) > 0 ‚Å‚ ‚ê‚Î, ‰ğ‚Í‹æŠÔ (a, c) ‚Ì’†‚É‘¶İ
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
