#import <Foundation/Foundation.h>
#import <math.h>

const int N = 4;

// ヤコビの反復法
void jacobi(double a[N][N], double b[N], double c[N]);
// １次元配列を表示
void disp_vector(double row[N]);

int main()
{
    double a[4][4] = {{9,2,1,1},{2,8,-2,1},{-1,-2,7,-2},{1,-1,-2,6}}; 
    double b[4]    = {20,16,8,17};
    double c[4]    = {0,0,0,0};

    // ヤコビの反復法
    jacobi(a,b,c);

    printf("X\n");
	disp_vector(c);
   
    return 0;
}

// ヤコビの反復法
void jacobi(double a[N][N], double b[N], double x0[N])
{
    while (YES)
    {
        double x1[N];
        BOOL finish = YES;
        int i, j;
        for (i = 0; i < N; i++)
        {
            x1[i] = 0;
            for (j = 0; j < N; j++)
                if (j != i)
                    x1[i] += a[i][j] * x0[j];

            x1[i] = (b[i] - x1[i]) / a[i][i];
            if (fabs(x1[i] - x0[i]) > 0.0000000001) finish = NO;
        }
        for (i = 0; i < N; i++)
        {
            x0[i] = x1[i];
        }
        if (finish) return;

		disp_vector(x0);
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
