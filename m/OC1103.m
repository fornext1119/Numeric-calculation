#import <Foundation/Foundation.h>
#import <math.h>

#define N 4

// LUªð
void decomp(double a[N][N], double l[N][N], double u[N][N]);
// sñÌÏ
void multiply(double a[N][N], double b[N][N], double c[N][N]);
// Îpvfð\¦
void disp_eigenvalue(double a[N][N]);

// LRªðÅÅLlðßé
int main()
{
    double a[N][N] = {{5.0, 4.0, 1.0, 1.0}, 
                      {4.0, 5.0, 1.0, 1.0}, 
                      {1.0, 1.0, 4.0, 2.0},
                      {1.0, 1.0, 2.0, 4.0}};
	double l[N][N] = {{0.0 ,0.0 ,0.0 ,0.0},
	                  {0.0 ,0.0 ,0.0 ,0.0},
	                  {0.0 ,0.0 ,0.0 ,0.0},
	                  {0.0 ,0.0 ,0.0 ,0.0}};
	double u[N][N] = {{0.0 ,0.0 ,0.0 ,0.0},
	                  {0.0 ,0.0 ,0.0 ,0.0},
	                  {0.0 ,0.0 ,0.0 ,0.0},
	                  {0.0 ,0.0 ,0.0 ,0.0}};

	int k;
    for (k = 1; k <= 200; k++)
    {
	    // LUªð
	    decomp(a, l, u);
        // sñÌÏ
        multiply(u, l, a);
        // Îpvfð\¦
		printf("%3d\t", k);
        disp_eigenvalue(a);
        
        // û©»è
		int i, j;
    	double e = 0.0;
        for (i = 1; i < N; i++)
            for (j = 0; j < i; j++)
                e += fabs(a[i][j]);
        if (e < 0.00000000001) break;
	}

    printf("\neigenvalue\n");
    disp_eigenvalue(a);

    return 0;
}
// LUªð
void decomp(double a[N][N], double l[N][N], double u[N][N])
{
	int i, j, k;
    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
		{
            l[i][j] = 0.0;
            u[i][j] = 0.0;
		}
	}
	
    l[0][0] = 1.0;
    for (j = 0; j < N; j++)
        u[0][j] = a[0][j];

    for (i = 1; i < N; i++)
    {
        u[i][0] = 0.0;
        l[0][i] = 0.0;
        l[i][0] = a[i][0] / u[0][0];
    }
    for (i = 1; i < N; i++)
    {
        l[i][i] = 1.0;
        double t = a[i][i];
        for (k = 0; k <= i; k++)
            t -= l[i][k] * u[k][i];
        u[i][i] = t;
        for (j = i + 1; j < N; j++)
        {
            u[j][i] = 0.0;
            l[i][j] = 0.0;
            t       = a[j][i];
	        for (k = 0; k <= i; k++)
                t -= l[j][k] * u[k][i];
            l[j][i] = t / u[i][i];
            t       = a[i][j];
	        for (k = 0; k <= i; k++)
                t -= l[i][k] * u[k][j];
            u[i][j] = t;
        }
    }
}
// sñÌÏ
void multiply(double a[N][N], double b[N][N], double c[N][N])
{
	int i, j, k;
    for (i = 0; i < N; i++)
    {
        for (j = 0; j < N; j++)
    	{
			double s = 0.0;
	        for (k = 0; k < N; k++)
                s += a[i][k] * b[k][j];
            c[i][j] = s;
        }
    }
}
// Îpvfð\¦
void disp_eigenvalue(double a[N][N])
{
	int i;
    for (i = 0; i < N; i++)
		printf("%14.10f\t", a[i][i]);
    printf("\n");
}
