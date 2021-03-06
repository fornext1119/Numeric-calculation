#import <Foundation/Foundation.h>
#import <math.h>

// データ点の数
const int N = 7; 

// 元の関数
double f(double x);

// Spline (スプライン) 補間
double spline(double d, double x[], double y[], double z[]);

int main()
{
	int i;
    double x[N], y[N];

    // 1.5刻みで -4.5〜4.5 まで, ７点だけ値をセット
    for (i = 0; i < N; i++)
    {
        double d = i * 1.5 - 4.5;
        x[i] = d;
        y[i] = f(d);
    }

    // ３項方程式の係数の表を作る
    double a[N], b[N], c[N], d[N];
    for (i = 1; i < N - 1; i++)
    {
        a[i] =         x[i]   - x[i-1]; 
        b[i] = 2.0 *  (x[i+1] - x[i-1]); 
        c[i] =         x[i+1] - x[i]; 
        d[i] = 6.0 * ((y[i+1] - y[i]) / (x[i+1] - x[i]) - (y[i] - y[i-1]) / (x[i] - x[i-1]));
    }
    // ３項方程式を解く (ト−マス法)
    double g[N], s[N];
    g[1] = b[1];
    s[1] = d[1];
    for (i = 2; i < N - 1; i++)
    {
        g[i] = b[i] - a[i] * c[i-1] / g[i-1];
        s[i] = d[i] - a[i] * s[i-1] / g[i-1];
    }
    double z[N];
    z[0]   = 0;
    z[N-1] = 0;
    z[N-2] = s[N-2] / g[N-2];
    for (i = N - 3; i >= 1; i--)
    {
        z[i] = (s[i] - c[i] * z[i+1]) / g[i];
    }

    // 0.5刻みで 与えられていない値を補間
    for (i = 0; i <= 18; i++)
    {
        double d  = i * 0.5 - 4.5;
        double d1 = f(d);
        double d2 = spline(d, x, y, z);

        // 元の関数と比較
        printf("%5.2f\t%8.5f\t%8.5f\t%8.5f\n", d, d1, d2, d1 - d2);
    }
   return 0;
}

// 元の関数
double f(double x)
{
    return x - pow(x,3) / (3 * 2) + pow(x,5) / (5 * 4 * 3 * 2);
}

// Spline (スプライン) 補間
double spline(double d, double x[], double y[], double z[])
{
    // 補間関数値がどの区間にあるか
    int i, k = -1;
    for (i = 1; i < N; i++)
    {
        if (d <= x[i])
        {
            k = i - 1;
            break;
        }
    }
    if (k < 0) k = N - 1;

    double d1 = x[k+1] - d;
    double d2 = d      - x[k];
    double d3 = x[k+1] - x[k];
    return      (z[k] * pow(d1,3) + z[k+1] * pow(d2,3)) / (6.0 * d3)
              + (y[k]   / d3 - z[k]   * d3 / 6.0) * d1  
              + (y[k+1] / d3 - z[k+1] * d3 / 6.0) * d2;
}
