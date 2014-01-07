#import <Foundation/Foundation.h>
#import <math.h>

double f(double x)
{
    return 4 / (1 + x * x); 
}

int main()
{
    const double a = 0;
    const double b = 1;

    // ‘äŒ`‘¥‚ÅÏ•ª
    int n = 2;
    int i, j;
    for (j = 1; j <= 10; j++)
    {
        double h = (b - a) / n;  
        double s = 0;
        double x = a;
        for (i = 1; i <= n - 1; i++)
        {
            x += h;
            s += f(x);
        }
        s = h * ((f(a) + f(b)) / 2 + s);
        n *= 2;

        // Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
        printf("%2d : %13.10f, %13.10f\n", j, s, s - M_PI);
    }

    return 0;
}
