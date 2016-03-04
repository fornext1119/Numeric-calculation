import std.stdio;
import std.math;

void main(string[] args)
{
    const double a = 0;
    const double b = 1;

    double t[7][7];

    // 台形則で積分
    int n = 2;
    for (int i = 1; i <= 6; i++)
    {
        double h = (b - a) / n;  
        double s = 0;
        double x = a;
        for (int j = 1; j <= n - 1; j++)
        {
            x += h;
            s += f(x);
        }
        // 結果を保存
        t[i][1] = h * ((f(a) + f(b)) / 2 + s);
        n *= 2;
    }

    // Richardsonの補外法
    n = 4;
    for (int j = 2; j <= 6; j++)
    {
        for (int i = j; i <= 6; i++)
        {
            t[i][j] = t[i][j - 1] + (t[i][j - 1] - t[i - 1][j - 1]) / (n - 1);
            if (i == j)
            {
                // 結果を π と比較
                writefln("%2d : %13.10f, %13.10f", j, t[i][j], t[i][j] - PI);
            }
        }
        n *= 4;
    }
}

double f(double x)
{
    return 4 / (1 + x * x); 
}
