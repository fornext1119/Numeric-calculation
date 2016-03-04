import std.stdio;
import std.math;

void main(string[] args)
{
    double x = 2;
    writefln("%12.10f", newton(x));
}

double newton(double x0)
{
    double x1;
    while (true)
    {
        x1 = x0 - (f0(x0) / f1(x0));
        writefln("%12.10f\t%13.10f", x1, x1 - sqrt(2.0));

        if (fabs(x1 - x0) < 0.0000000001) break;
    	x0 = x1;
    }
    return x1;
}

double f0(double x)
{
    return x * x - 2;  
}
double f1(double x)
{
    return 2 * x;  
}
