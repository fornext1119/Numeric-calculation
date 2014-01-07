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

    double t[7][7];

    // ‘äŒ`‘¥‚ÅÏ•ª
    int n = 2;
    int i, j;
    for (i = 1; i <= 6; i++)
    {
        double h = (b - a) / n;  
        double s = 0;
        double x = a;
        for (j = 1; j <= n - 1; j++)
        {
            x += h;
            s += f(x);
        }
        // Œ‹‰Ê‚ğ•Û‘¶
        t[i][1] = h * ((f(a) + f(b)) / 2 + s);
        n *= 2;
    }

    // Richardson‚Ì•âŠO–@
    n = 4;
    for (j = 2; j <= 6; j++)
    {
        for (i = j; i <= 6; i++)
        {
            t[i][j] = t[i][j - 1] + (t[i][j - 1] - t[i - 1][j - 1]) / (n - 1);
            if (i == j)
            {
                // Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
                printf("%2d : %13.10f, %13.10f\n", j, t[i][j], t[i][j] - M_PI);
            }
        }
        n *= 4;
    }

    return 0;
}
