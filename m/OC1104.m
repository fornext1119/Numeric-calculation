#import <Foundation/Foundation.h>
#import <math.h>

#define N 4

// QR����
void decomp(double a[N][N], double q[N][N], double r[N][N]);
// �s��̐�
void multiply(double a[N][N], double b[N][N], double c[N][N]);
// �Ίp�v�f��\��
void disp_eigenvalue(double a[N][N]);

// QR�����ŌŗL�l�����߂�
int main()
{
    double a[N][N] = {{5.0, 4.0, 1.0, 1.0}, 
                      {4.0, 5.0, 1.0, 1.0}, 
                      {1.0, 1.0, 4.0, 2.0},
                      {1.0, 1.0, 2.0, 4.0}};
	double q[N][N] = {{0.0 ,0.0 ,0.0 ,0.0},
	                  {0.0 ,0.0 ,0.0 ,0.0},
	                  {0.0 ,0.0 ,0.0 ,0.0},
	                  {0.0 ,0.0 ,0.0 ,0.0}};
	double r[N][N] = {{0.0 ,0.0 ,0.0 ,0.0},
	                  {0.0 ,0.0 ,0.0 ,0.0},
	                  {0.0 ,0.0 ,0.0 ,0.0},
	                  {0.0 ,0.0 ,0.0 ,0.0}};

	int k;
    for (k = 1; k <= 200; k++)
    {
	    // QR����
	    decomp(a, q, r);
        // �s��̐�
        multiply(r, q, a);
        // �Ίp�v�f��\��
		printf("%3d\t", k);
        disp_eigenvalue(a);
        
        // ��������
		int i, j;
    	double e = 0.0;
        for (i = 0; i < N; i++)
            for (j = 0; j < i; j++)
                e += fabs(a[i][j]);
        if (e < 0.00000000001) break;
	}

    printf("\neigenvalue\n");
    disp_eigenvalue(a);

    return 0;
}
// QR����
void decomp(double a[N][N], double q[N][N], double r[N][N])
{
	int i, j, k;
	double x[N] = {0.0 ,0.0 ,0.0 ,0.0};

    for (k = 0; k < N; k++)
    {
        for (i = 0; i < N; i++)
            x[i] = a[i][k];

        for (j = 0; j < k; j++)
		{
			double t = 0.0;
	        for (i = 0; i < N; i++)
                t += a[i][k] * q[i][j];
            r[j][k] = t;
            r[k][j] = 0.0;
	        for (i = 0; i < N; i++)
        		x[i] -= t * q[i][j];
		}

		double s = 0.0;
        for (i = 0; i < N; i++)
            s += x[i] * x[i];
		r[k][k] = sqrt(s);
        for (i = 0; i < N; i++)
            q[i][k] = x[i] / r[k][k];
    }
}
// �s��̐�
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
// �Ίp�v�f��\��
void disp_eigenvalue(double a[N][N])
{
	int i;
    for (i = 0; i < N; i++)
		printf("%14.10f\t", a[i][i]);
    printf("\n");
}
