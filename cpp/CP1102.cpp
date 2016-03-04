#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;

const int N = 4;

// �t�x�L��@
double inverse(double a[N][N], double x0[N]);
// LU����
void forward_elimination(double a[N][N]);
// �O�i���
void forward_substitution(double a[N][N], double y[N], double b[N]);
// ��ޑ��
void backward_substitution(double a[N][N], double x[N], double y[N]);
// �P�����z���\��
void disp_vector(double row[N]);
// ���K�� (�x�N�g���̒������P�ɂ���)
void normarize(double x[N]);

// �t�x�L��@�ōŏ��ŗL�l�����߂�
int main()
{
    double a[N][N] = {{5.0, 4.0, 1.0, 1.0}, 
                      {4.0, 5.0, 1.0, 1.0}, 
                      {1.0, 1.0, 4.0, 2.0},
                      {1.0, 1.0, 2.0, 4.0}};
	double x[N]    =  {1.0 ,0.0 ,0.0 ,0.0};

	// LU����
	forward_elimination(a);
	
    // �t�x�L��@
    double lambda = inverse(a, x);

    cout << endl << "eigenvalue" << endl;
    cout << setw(14) << fixed << setprecision(10) << lambda;

    cout << endl << "eigenvector" << endl;
    disp_vector(x);

    return 0;
}

// �t�x�L��@
double inverse(double a[N][N], double x0[N])
{
    double lambda = 0.0;

    // ���K�� (�x�N�g�� x0 �̒������P�ɂ���)
    normarize(x0);
	double e0 = 0.0;
    for (int i = 0; i < N; i++)
        e0 += x0[i];

    for (int k = 1; k <= 100; k++)
    {
        // �P�����z���\��
        cout << setw(3) << k << "\t";
        disp_vector(x0);

        // Ly = b ���� y �����߂� (�O�i���)
        double b[N] = {0.0 ,0.0 ,0.0 ,0.0};
        double y[N] = {0.0 ,0.0 ,0.0 ,0.0};
        for (int i = 0; i < N; i++)
            b[i] = x0[i];
        forward_substitution(a,y,b);
        // Ux = y ���� x �����߂� (��ޑ��)
        double x1[N] = {0.0 ,0.0 ,0.0 ,0.0};
        backward_substitution(a,x1,y);
        
        // ����
        double p0 = 0.0;
        double p1 = 0.0;
        for (int i = 0; i < N; i++)
        {
            p0 += x1[i] * x1[i];
            p1 += x1[i] * x0[i];
        }
        // �ŗL�l
        lambda = p1 / p0;

	    // ���K�� (�x�N�g�� x1 �̒������P�ɂ���)
	    normarize(x1);
        // ��������
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
// LU����
void forward_elimination(double a[N][N])
{
    for (int pivot = 0; pivot < N - 1; pivot++)
    {
        for (int row = pivot + 1; row < N; row++)
        {
            double s = a[row][pivot] / a[pivot][pivot];
            for (int col = pivot; col < N; col++)
                a[row][col] -= a[pivot][col] * s; // ���ꂪ ��O�p�s��
            a[row][pivot] = s;                    // ���ꂪ ���O�p�s��
        }
    }
}
// �O�i���
void forward_substitution(double a[N][N], double y[N], double b[N])
{
    for (int row = 0; row < N; row++)
    {
        for (int col = 0; col < row; col++)
            b[row] -= a[row][col] * y[col];
        y[row] = b[row];
    }
}
// ��ޑ��
void backward_substitution(double a[N][N], double x[N], double y[N])
{
    for (int row = N - 1; row >= 0; row--)
    {
        for (int col = N - 1; col > row; col--)
            y[row] -= a[row][col] * x[col];
        x[row] = y[row] / a[row][row];
    }
}
// �P�����z���\��
void disp_vector(double row[N])
{
    for (int i = 0; i < N; i++)
        cout << setw(14) << fixed << setprecision(10) << row[i] << "\t";
    cout << endl;
}
// ���K�� (�x�N�g���̒������P�ɂ���)
void normarize(double x[N])
{
    double s = 0.0;

    for (int i = 0; i < N; i++)
        s += x[i] * x[i];
    s = sqrt(s);
    
    for (int i = 0; i < N; i++)
        x[i] /= s;
}
