import std.stdio;
import std.math;

void main(string[] args)
{
    const double a = 0;
    const double b = 1;

    // 台形則で積分
    int n = 2;
    for (int j = 1; j <= 10; j++)
    {
        double h = (b - a) / n;  
        double s = 0;
        double x = a;
        for (int i = 1; i <= n - 1; i++)
        {
            x += h;
            s += f(x);
        }
        s = h * ((f(a) + f(b)) / 2 + s);
        n *= 2;

        // 結果を π と比較
        writefln("%2d : %13.10f, %13.10f", j, s, s - PI);
    }
}

double f(double x)
{
    return 4 / (1 + x * x); 
}
