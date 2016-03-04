import std.stdio;
import std.math;

void main(string[] args)
{
    const double a = 0;
    const double b = 1;

    // Simpson則で積分
    int n = 2;
    for (int j = 1; j <= 5; j++)
    {
        double h = (b - a) / n;  
        double s2 = 0;
        double s4 = 0;
        double x = a + h;
        for (int i = 1; i <= n / 2; i++)
        {
            s4 += f(x);
            x  += h;
            s2 += f(x);
            x  += h;
        }
        s2 = (s2 - f(b)) * 2 + f(a) + f(b);
        s4 *= 4;
        double s = (s2 + s4) * h / 3;
        n *= 2;

        // 結果を π と比較
        writefln("%2d : %13.10f, %13.10f", j, s, s - PI);
    }
}

double f(double x)
{
    return 4 / (1 + x * x); 
}
