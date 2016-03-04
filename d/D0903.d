import std.stdio;
import std.math;

void main(string[] args)
{
    double x = 1;
    writefln("%12.10f", iterative(x));
}

double iterative(double x0)
{
    double x1;
    while (true)
    {
        x1 = g(x0);
        writefln("%12.10f\t%13.10f", x1, x1 - sqrt(2.0));

        if (fabs(x1 - x0) < 0.0000000001) break;
    	x0 = x1;
    }
    return x1;
}

double g(double x)
{
    return (x / 2) + (1 / x);
}
