#import <Foundation/Foundation.h>
#import <math.h>

#define N 4

// 逆ベキ乗法
double inverse(double a[N][N], double x0[N]);
// LU分解
void forward_elimination(double a[N][N]);
// 前進代入
void forward_substitution(double a[N][N], double y[N], double b[N]);
// 後退代入
void backward_substitution(double a[N][N], double x[N], double y[N]);
// １次元配列を表示
void disp_vector(double row[N]);
// 正規化 (ベクトルの長さを１にする)
void normarize(double x[N]);

// 逆ベキ乗法で最小固有値を求める
int main()
{
    double a[N][N] = {{5.0, 4.0, 1.0, 1.0}, 
                      {4.0, 5.0, 1.0, 1.0}, 
                      {1.0, 1.0, 4.0, 2.0},
                      {1.0, 1.0, 2.0, 4.0}};
	double x[N]    =  {1.0 ,0.0 ,0.0 ,0.0};

	// LU分解
	forward_elimination(a);
	
    // 逆ベキ乗法 Inverse iteration
    double lambda = inverse(a, x);

    printf("\neigenvalue\n");
	printf("%14.10f\n", lambda);

    printf("eigenvector\n");
    disp_vector(x);

    return 0;
}

// 逆ベキ乗法
double inverse(double a[N][N], double x0[N])
{
	int i, j, k;
    double lambda = 0.0;

    // 正規化 (ベクトル x0 の長さを１にする)
    normarize(x0);
	double e0 = 0.0;
    for (i = 0; i < N; i++)
        e0 += x0[i];

    for (k = 1; k <= 200; k++)
    {
        // １次元配列を表示
		printf("%3d\t", k);
        disp_vector(x0);

        // Ly = b から y を求める (前進代入)
        double b[N] = {0.0 ,0.0 ,0.0 ,0.0};
        double y[N] = {0.0 ,0.0 ,0.0 ,0.0};
        for (i = 0; i < N; i++)
            b[i] = x0[i];
        forward_substitution(a,y,b);
        // Ux = y から x を求める (後退代入)
        double x1[N] = {0.0 ,0.0 ,0.0 ,0.0};
        backward_substitution(a,x1,y);
        
        // 内積
        double p0 = 0.0;
        double p1 = 0.0;
        for (i = 0; i < N; i++)
        {
            p0 += x1[i] * x1[i];
            p1 += x1[i] * x0[i];
        }
        // 固有値
        lambda = p1 / p0;

	    // 正規化 (ベクトル x1 の長さを１にする)
	    normarize(x1);
		double e1 = 0.0;
        // 収束判定
	    for (i = 0; i < N; i++)
        	e1 += x1[i];
        if (fabs(e0 - e1) < 0.00000000001) break;

        for (i = 0; i < N; i++)
            x0[i] = x1[i];
        e0 = e1;
    }
	return lambda;
}
// LU分解
void forward_elimination(double a[N][N])
{
	int pivot, row, col;
    for (pivot = 0; pivot < N - 1; pivot++)
    {
        for (row = pivot + 1; row < N; row++)
        {
            double s = a[row][pivot] / a[pivot][pivot];
            for (col = pivot; col < N; col++)
                a[row][col] -= a[pivot][col] * s; // これが 上三角行列
            a[row][pivot] = s;                    // これが 下三角行列
        }
    }
}
// 前進代入
void forward_substitution(double a[N][N], double y[N], double b[N])
{
	int row, col;
    for (row = 0; row < N; row++)
    {
        for (col = 0; col < row; col++)
            b[row] -= a[row][col] * y[col];
        y[row] = b[row];
    }
}
// 後退代入
void backward_substitution(double a[N][N], double x[N], double y[N])
{
	int row, col;
    for (row = N - 1; row >= 0; row--)
    {
        for (col = N - 1; col > row; col--)
            y[row] -= a[row][col] * x[col];
        x[row] = y[row] / a[row][row];
    }
}
// １次元配列を表示
void disp_vector(double row[N])
{
	int i;
    for (i = 0; i < N; i++)
		printf("%14.10f\t", row[i]);
    printf("\n");
}
// 正規化 (ベクトルの長さを１にする)
void normarize(double x[N])
{
	int i;
    double s = 0.0;

    for (i = 0; i < N; i++)
        s += x[i] * x[i];
    s = sqrt(s);
    
    for (i = 0; i < N; i++)
        x[i] /= s;
}
