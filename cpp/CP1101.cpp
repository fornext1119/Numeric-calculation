#include <iostream>
#include <iomanip>
#include <math.h>
#include <vector>

using namespace std;

const int N = 4;

// �x�L��@
double power(double a[N][N], double x0[N]);
// �P�����z���\��
void disp_vector(double row[N]);
// ���K�� (�x�N�g���̒������P�ɂ���)
void normarize(double x[N]);

// �x�L��@�ōő�ŗL�l�����߂�
int main()
{
    double a[N][N] = {{5.0, 4.0, 1.0, 1.0}, 
                      {4.0, 5.0, 1.0, 1.0}, 
                      {1.0, 1.0, 4.0, 2.0},
                      {1.0, 1.0, 2.0, 4.0}};
	double x[N]    =  {1.0 ,0.0 ,0.0 ,0.0};

    // �x�L��@
    double lambda = power(a, x);

    cout << endl << "eigenvalue" << endl;
    cout << setw(14) << fixed << setprecision(10) << lambda;

    cout << endl << "eigenvector" << endl;
    disp_vector(x);

    return 0;
}

// �x�L��@
double power(double a[N][N], double x0[N])
{
    double lambda = 0.0;

    // ���K�� (�x�N�g�� x0 �̒������P�ɂ���)
    normarize(x0);
	double e0 = 0.0;
    for (int i = 0; i < N; i++)
        e0 += x0[i];

    for (int k = 1; k <= 200; k++)
    {
        // �P�����z���\��
        cout << setw(3) << k << "\t";
        disp_vector(x0);

    	// �s��̐� x1 = A �~ x0 
        double x1[N] = {0.0 ,0.0 ,0.0 ,0.0};
        for (int i = 0; i < N; i++)
            for (int j = 0; j < N; j++)
                x1[i] += a[i][j] * x0[j];
        
        // ����
        double p0 = 0.0;
        double p1 = 0.0;
        for (int i = 0; i < N; i++)
        {
            p0 += x1[i] * x1[i];
            p1 += x1[i] * x0[i];
        }
        // �ŗL�l
        lambda = p0 / p1;

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
