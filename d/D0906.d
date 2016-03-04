import std.stdio;
import std.math;

void main(string[] args) {
    double x0 = 1;
    double x1 = 2;
    writefln("%12.10f", secant(x0, x1));
}

double secant(double x0, double x1)
{
    double x2;
    while (true)
    {
        x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0));
        writefln("%12.10f\t%13.10f", x1, x1 - sqrt(2.0));

        if (fabs(x2 - x1) < 0.0000000001) break;
        x0 = x1;
        x1 = x2;
    }
    return x2;
}

double f(double x)
{
    return x * x - 2;  
}
