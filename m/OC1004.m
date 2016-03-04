#import <Foundation/Foundation.h>
#import <math.h>

const int N = 4;

// ピボット選択
void pivoting(double a[N][N], double b[N]);
// 前進消去
void forward_elimination(double a[N][N], double b[N]);
// 後退代入
void backward_substitution(double a[N][N], double b[N]);
// １次元配列を表示
void disp_vector(double row[N]);
// ２次元配列を表示
void disp_matrix(double matrix[N][N]);

// ガウス・ジョルダン法
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

    printf("forward elimination\n");
    printf("A\n");
	disp_matrix(a);
    printf("B\n");
    disp_vector(b);
    printf("\n");

    // 後退代入
    backward_substitution(a,b);

    printf("X\n");
    disp_vector(b);
   
    return 0;
}
// 前進消去
void forward_elimination(double a[N][N], double b[N])
{
    int pivot, row, col;
    for (pivot = 0; pivot < N; pivot++)
    {
        for (row = 0; row < N; row++)
        {
            if (row == pivot) continue;

            double  s   = a[row][pivot] / a[pivot][pivot];
            for (col = pivot; col < N; col++)
                a[row][col] -= a[pivot][col]    * s;
            b[row]          -= b[pivot]         * s;
        }
    }
}
// 後退代入
void backward_substitution(double a[N][N], double b[N])
{
    int pivot;
    for (pivot = 0; pivot < N; pivot++)
        b[pivot]  /= a[pivot][pivot];
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
