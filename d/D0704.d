import std.stdio;
import std.math;

// データ点の数
const int N = 7; 
const int Nx2 = 14; 

void main(string[] args)
{
	double x[N];
	double y[N];
	double yd[N];

    // 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
    for (int i = 0; i < N; i++)
    {
        double d = i * 1.5 - 4.5;
        x[i]  = d;
        y[i]  = f(d);
        yd[i] = fd(d);
    }

    // 差分商の表を作る
    double z[Nx2];
    double d[Nx2][Nx2];
    for (int i = 0; i < Nx2; i++)
    {
        int j   = i / 2;
        z[i]    = x[j];
        d[0][i] = y[j];
    }

    for (int i = 1; i < Nx2; i++)
    {
        for (int j = 0; j < Nx2 - i; j++)
        {
            if (i == 1 && j % 2 == 0)
                d[i][j] = yd[j / 2];
            else
                d[i][j] = (d[i-1][j+1] - d[i-1][j]) / (z[j+i] - z[j]);
        }
    }

    // ｎ階差分商
    double a[Nx2]; 
    for (int j = 0; j < Nx2; j++)
        a[j] = d[j][0];

    // 0.5刻みで 与えられていない値を補間
    for (int i = 0; i <= 18; i++)
    {
        double d1 = i * 0.5 - 4.5;
        double d2 = f(d1);
        double d3 = hermite(d1, z, a);

        // 元の関数と比較
        writefln("%5.2f\t%8.5f\t%8.5f\t%8.5f", d1, d2, d3, d2 - d3);
    }
}

// 元の関数
double f(double x)
{
    return x - pow(x,3) / (3 * 2) + pow(x,5) / (5 * 4 * 3 * 2);
}

// 導関数
double fd(double x)
{
    return 1 - pow(x,2) / 2 + pow(x,4) / (4 * 3 * 2); 
}

// Hermite (エルミート) 補間
double hermite(double d, double z[], double a[])
{
    double sum = a[0];
    for (int i = 1; i < Nx2; i++)
    {
        double prod = a[i];
        for (int j = 0; j < i; j++)
            prod *= (d - z[j]);
        sum += prod;
    }

    return sum;
}
