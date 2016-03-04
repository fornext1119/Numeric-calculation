import std.stdio;
import std.math;

// データ点の数
const int N = 7; 

void main(string[] args)
{
	double x[N];
	double y[N];

    // 1.5刻みで -4.5～4.5 まで, ７点だけ値をセット
    for (int i = 0; i < N; i++)
    {
        double d = i * 1.5 - 4.5;
        x[i] = d;
        y[i] = f(d);
    }

    // 差分商の表を作る
    double d[N][N];
    for (int j = 0; j < N; j++)
        d[0][j] = y[j];

    for (int i = 1; i < N; i++)
    {
        for (int j = 0; j < N - i; j++)
            d[i][j] = (d[i-1][j+1] - d[i-1][j]) / (x[j+i] - x[j]);
    }

    // ｎ階差分商
    double a[N]; 
    for (int j = 0; j < N; j++)
        a[j] = d[j][0];

    // 0.5刻みで 与えられていない値を補間
    for (int i = 0; i <= 18; i++)
    {
        double d1 = i * 0.5 - 4.5;
        double d2 = f(d1);
        double d3 = newton(d1, x, a);

        // 元の関数と比較
        writefln("%5.2f\t%8.5f\t%8.5f\t%8.5f", d1, d2, d3, d2 - d3);
    }
}

// 元の関数
double f(double x)
{
    return x - pow(x,3) / (3 * 2) + pow(x,5) / (5 * 4 * 3 * 2);
}

// Newton (ニュートン) 補間
double newton(double d, double x[], double a[])
{
    double sum = a[0];
    for (int i = 1; i < N; i++)
    {
        double prod = a[i];
        for (int j = 0; j < i; j++)
            prod *= (d - x[j]);
        sum += prod;
    }

    return sum;
}
