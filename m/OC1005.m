#import <Foundation/Foundation.h>
#import <math.h>

const int N = 4;

// ピボット選択
void pivoting(double a[N][N], double b[N]);
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

// LU分解
int main()
{
    double a[4][4] = {{-1,-2,7,-2},{1,-1,-2,6},{9,2,1,1},{2,8,-2,1}}; 
    double b[4]    = {8,17,20,16};

    // ピボット選択
    pivoting(a,b);

    printf("pivoting\n");
    printf("A\n");
	disp_matrix(a);
    printf("B\n");
    disp_vector(b);
    printf("\n");

    // 前進消去
    forward_elimination(a,b);

    printf("LU\n");
	disp_matrix(a);

    // Ly=b から y を求める (前進代入)
    double y[4] = {0,0,0,0};
    forward_substitution(a,b,y);

    printf("Y\n");
    disp_vector(y);

    // Ux=y から x を求める (後退代入)
    double x[4] = {0,0,0,0};
    backward_substitution(a,y,x);

    printf("X\n");
    disp_vector(x);

    return 0;
}
// 前進消去
void forward_elimination(double a[N][N], double b[N])
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
            // b[row]    -= b[pivot] * s;         // この値は変更しない
        }
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
            y[row] -= a[row][col] * x[col];
        x[row] = y[row] / a[row][row];
    }
}
// ピボット選択
void pivoting(double a[N][N], double b[N])
{
    int pivot, row, col;
    for(pivot = 0; pivot < N; pivot++)
    {
        // 各列で 一番値が大きい行を 探す
        int     max_row =   pivot;
        double  max_val =   0;
        for (row = pivot; row < N; row++)
        {
            if (fabs(a[row][pivot]) > max_val)
            {
                // 一番値が大きい行
                max_val =   fabs(a[row][pivot]);
                max_row =   row;
            }
        }

        // 一番値が大きい行と入れ替え
        if (max_row != pivot)
        {
            double tmp;
            for (col = 0; col < N; col++)
            {
                tmp             =   a[max_row][col];
                a[max_row][col] =   a[pivot][col];
                a[pivot][col]   =   tmp;
            }
            tmp         =   b[max_row];
            b[max_row]  =   b[pivot];
            b[pivot]    =   tmp;
        }
    }
}
// 状態を確認
void disp_progress(double a[N][N], double b[N])
{
    int i, j;
    for (i = 0; i < N; i++) 
    {
        for (j = 0; j < N; j++) 
            printf("%14.10f\t", a[i][j]);
        printf("%14.10f\n", b[i]);
    }
    printf("\n");
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
