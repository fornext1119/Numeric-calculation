import std.stdio;
import std.math;

void main(string[] args)
{
    writefln("%d",     3 + 5);
    writefln("%d",     3 - 5);
    writefln("%d",     3 * 5);
    writefln("%d",     pow(3, 5));
    writefln("%d",     5 / 3);
    writefln("%f",     5.0 / 3);
    writefln("%f",     5 / 3.0);
    writefln("%d",     5 % 3);

    writef("%d\n",     5 * 3);

    writefln("%3d",     3 * 5);
    writefln("%23.20f", 5 / 3.0);
}
