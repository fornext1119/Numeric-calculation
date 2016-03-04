#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;

const int N = 4;

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

    for (int k = 1; k <= 200; k++)
    {
	    // QR����
	    decomp(a, q, r);
        // �s��̐�
        multiply(r, q, a);
        // �Ίp�v�f��\��
        cout << setw(3) << k << "\t";
        disp_eigenvalue(a);
        
        // ��������
    	double e = 0.0;
        for (int i = 1; i < N; i++)
            for (int j = 0; j < i; j++)
                e += fabs(a[i][j]);
        if (e < 0.00000000001) break;
	}

    cout << endl << "eigenvalue" << endl;
    disp_eigenvalue(a);

    return 0;
}
// QR����
void decomp(double a[N][N], double q[N][N], double r[N][N])
{
	double x[N] = {0.0 ,0.0 ,0.0 ,0.0};

    for (int k = 0; k < N; k++)
    {
        for (int i = 0; i < N; i++)
            x[i] = a[i][k];

        for (int j = 0; j < k; j++)
		{
			double t = 0.0;
	        for (int i = 0; i < N; i++)
                t += a[i][k] * q[i][j];
            r[j][k] = t;
            r[k][j] = 0.0;
	        for (int i = 0; i < N; i++)
        		x[i] -= t * q[i][j];
		}

		double s = 0.0;
        for (int i = 0; i < N; i++)
            s += x[i] * x[i];
		r[k][k] = sqrt(s);
        for (int i = 0; i < N; i++)
            q[i][k] = x[i] / r[k][k];
    }
}
// �s��̐�
void multiply(double a[N][N], double b[N][N], double c[N][N])
{
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < N; j++)
    	{
			double s = 0.0;
	        for (int k = 0; k < N; k++)
                s += a[i][k] * b[k][j];
            c[i][j] = s;
        }
    }
}
// �Ίp�v�f��\��
void disp_eigenvalue(double a[N][N])
{
    for (int i = 0; i < N; i++)
        cout << setw(14) << fixed << setprecision(10) << a[i][i] << "\t";
    cout << endl;
}
