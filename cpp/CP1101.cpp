#include <iostream>
#include <iomanip>
#include <math.h>
#include <vector>

using namespace std;

const int N = 4;

// ベキ乗法
double power(double a[N][N], double x0[N]);
// １次元配列を表示
void disp_vector(double row[N]);
// 正規化 (ベクトルの長さを１にする)
void normarize(double x[N]);

// ベキ乗法で最大固有値を求める
int main()
{
    double a[N][N] = {{5.0, 4.0, 1.0, 1.0}, 
                      {4.0, 5.0, 1.0, 1.0}, 
                      {1.0, 1.0, 4.0, 2.0},
                      {1.0, 1.0, 2.0, 4.0}};
	double x[N]    =  {1.0 ,0.0 ,0.0 ,0.0};

    // ベキ乗法
    double lambda = power(a, x);

    cout << endl << "eigenvalue" << endl;
    cout << setw(14) << fixed << setprecision(10) << lambda;

    cout << endl << "eigenvector" << endl;
    disp_vector(x);

    return 0;
}

// ベキ乗法
double power(double a[N][N], double x0[N])
{
    double lambda = 0.0;

    // 正規化 (ベクトル x0 の長さを１にする)
    normarize(x0);
	double e0 = 0.0;
    for (int i = 0; i < N; i++)
        e0 += x0[i];

    for (int k = 1; k <= 200; k++)
    {
        // １次元配列を表示
        cout << setw(3) << k << "\t";
        disp_vector(x0);

    	// 行列の積 x1 = A × x0 
        double x1[N] = {0.0 ,0.0 ,0.0 ,0.0};
        for (int i = 0; i < N; i++)
            for (int j = 0; j < N; j++)
                x1[i] += a[i][j] * x0[j];
        
        // 内積
        double p0 = 0.0;
        double p1 = 0.0;
        for (int i = 0; i < N; i++)
        {
            p0 += x1[i] * x1[i];
            p1 += x1[i] * x0[i];
        }
        // 固有値
        lambda = p0 / p1;

	    // 正規化 (ベクトル x1 の長さを１にする)
	    normarize(x1);
        // 収束判定
		double e1 = 0.0;
	    for (int i = 0; i < N; i++)
	        e1 += x1[i];
        if (fabs(e0 - e1) < 0.00000000001) break;

        for (int i = 0; i < N; i++)
            x0[i] = x1[i];
        e0 = e1;
    }
	return lambda;
}
// １次元配列を表示
void disp_vector(double row[N])
{
    for (int i = 0; i < N; i++)
        cout << setw(14) << fixed << setprecision(10) << row[i] << "\t";
    cout << endl;
}
// 正規化 (ベクトルの長さを１にする)
void normarize(double x[N])
{
    double s = 0.0;

    for (int i = 0; i < N; i++)
        s += x[i] * x[i];
    s = sqrt(s);
    
    for (int i = 0; i < N; i++)
        x[i] /= s;
}
