#import <Foundation/Foundation.h>
#import <math.h>

const int N = 4;

// 前進消去
void forward_elimination(double a[N][N], double b[N]);
// 前進代入
void forward_substitution(double a[N][N], double b[N], double y[N]);
// 後退代入
void backward_substitution(double a[N][N], double y[N], double x[N]);
// １次元配列を表示
void disp_vector(double row[N]);
// ２次元配列を表示
void disp_matrix(double matrix[N][N]);

// 修正コレスキー法
int main()
{
    double a[4][4] = {{5,2,3,4},{2,10,6,7},{3,6,15,9},{4,7,9,20}}; 
    double b[4]    = {34,68,96,125};

    printf("A\n");
	disp_matrix(a);
    printf("B\n");
    disp_vector(b);
    printf("\n");

    // 前進消去
    forward_elimination(a,b);

    printf("LDL^T\n");
	disp_matrix(a);

    // Ly=b から y を求める (前進代入)
    double y[4] = {0,0,0,0};
    forward_substitution(a,b,y);

    printf("Y\n");
    disp_vector(y);

    // DL^Tx=y から x を求める (後退代入)
    double x[4] = {0,0,0,0};
    backward_substitution(a,y,x);

    printf("X\n");
    disp_vector(x);

    return 0;
}
// 前進消去
void forward_elimination(double a[N][N], double b[N])
{
    int pivot, col, k;
    for (pivot = 0; pivot < N; pivot++)
    {
        double s;

        // pivot < k の場合
        for (col = 0; col < pivot; col++)
        {
            s = a[pivot][col];
            for (k = 0; k < col; k++)
                s -= a[pivot][k] * a[col][k] * a[k][k];
            a[pivot][col] = s / a[col][col];
            a[col][pivot] = a[pivot][col];
        }
 
        // pivot == k の場合
        s = a[pivot][pivot];
        for (k = 0; k < pivot; k++)
            s -= a[pivot][k] * a[pivot][k] * a[k][k];
        a[pivot][pivot] = s;
    }
}
// 前進代入
void forward_substitution(double a[N][N], double b[N], double y[N])
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
void backward_substitution(double a[N][N], double y[N], double x[N])
{
	int row, col;
    for (row = N - 1; row >= 0; row--)
    {
        for (col = N - 1; col > row; col--)
            y[row] -= a[row][col] * a[row][row] * x[col];
        x[row] = y[row] / a[row][row];
    }
}
// １次元配列を表示
void disp_vector(double row[N])
{
	int i;
    for (i = 0; i < N; i++)
    {
        printf("%14.10f\t", row[i]);
    }
    printf("\n");
}
// ２次元配列を表示
void disp_matrix(double matrix[N][N])
{
    int i, j;
    for (i = 0; i < N; i++) 
    {
        for (j = 0; j < N; j++) 
            printf("%14.10f\t", matrix[i][j]);
        printf("\n");
    }
}
