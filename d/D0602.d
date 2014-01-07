import std.stdio;
import std.math;

void main(string[] args)
{
    const double a = 0;
    const double b = 1;

    // ’†“_‘¥‚ÅÏ•ª
    int n = 2;
    for (int j = 1; j <= 10; j++)
    {
        double h = (b - a) / n;  
        double s = 0;
        double x = a + (h / 2);
        for (int i = 1; i <= n; i++)
        {
            s += f(x);
            x += h;
        }
        s *= h;
        n *= 2;

        // Œ‹‰Ê‚ğ ƒÎ ‚Æ”äŠr
        writefln("%2d : %13.10f, %13.10f", j, s, s - PI);
    }
}

double f(double x)
{
    return 4 / (1 + x * x); 
}
