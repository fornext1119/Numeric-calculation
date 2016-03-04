#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;

const int N = 4;

// ���R�r�@
void jacobi(double a[N][N], double v[N][N]);
// �Ίp�v�f��\��
void disp_eigenvalue(double a[N][N]);
// �ŗL�x�N�g����\��
void disp_eigenvector(double matrix[N][N]);
// �P�����z���\��
void disp_vector(double row[N]);
// ���K�� (�x�N�g���̒������P�ɂ���)
void normarize(double x[N]);

// ���R�r�@�ŌŗL�l�����߂�
int main()
{
    double a[N][N] = {{5.0, 4.0, 1.0, 1.0}, 
                      {4.0, 5.0, 1.0, 1.0}, 
                      {1.0, 1.0, 4.0, 2.0},
                      {1.0, 1.0, 2.0, 4.0}};
	double v[N][N] = {{1.0 ,0.0 ,0.0 ,0.0},
	                  {0.0 ,1.0 ,0.0 ,0.0},
	                  {0.0 ,0.0 ,1.0 ,0.0},
	                  {0.0 ,0.0 ,0.0 ,1.0}};

    // ���R�r�@
    jacobi(a, v);

    cout << endl << "eigenvalue" << endl;
	disp_eigenvalue(a);

    cout << endl << "eigenvector" << endl;
	disp_eigenvector(v);

    return 0;
}

// ���R�r�@
void jacobi(double a[N][N], double v[N][N])
{
    for (int k = 1; k <= 100; k++)
    {
        // �ő�l��T��
		int p = 0;
		int q = 0;
        double max_val = 0.0;
        for (int i = 0; i < N; i++)
        {
            for (int j = i + 1; j < N; j++)
            {
                if (max_val < fabs(a[i][j]))
                {
                    max_val = fabs(a[i][j]);
                    p = i;
                    q = j;
				}
			}
		}

        // �� �����߂�
        double t;
        if (fabs(a[p][p] - a[q][q]) < 0.00000000001)
        {
            // a_{pp} �� a_{qq} �̂Ƃ��A��]�p������/4�ɂ���
            t = M_PI / 4.0;
            if (a[p][p] < 0)
                t = -t;
        }
        else
        {
            // a_{pp} �� a_{qq} �̂Ƃ�
            t = atan(2.0 * a[p][q] / (a[p][p] - a[q][q])) / 2.0;
        }

        // �� ���g���� �s�� U ���쐬���AA = U^t �~ A �~ U
        double c = cos(t);
        double s = sin(t);
        // U^t �~ A
        double t1;
        double t2;
        for (int i = 0; i < N; i++)
        {
            t1      =  a[p][i] * c + a[q][i] * s;
            t2      = -a[p][i] * s + a[q][i] * c;
            a[p][i] = t1;
            a[q][i] = t2;
            // �ŗL�x�N�g��
            t1      =  v[p][i] * c + v[q][i] * s;
            t2      = -v[p][i] * s + v[q][i] * c;
            v[p][i] = t1;
            v[q][i] = t2;
        }
        // A �~ U
        for (int i = 0; i < N; i++)
        {
            t1      =  a[i][p] * c + a[i][q] * s;
            t2      = -a[i][p] * s + a[i][q] * c;
            a[i][p] = t1;
            a[i][q] = t2;
        }

        // �Ίp�v�f��\��
        cout << setw(3) << k << "\t";
        disp_eigenvalue(a);

        // ��������
    	if (max_val < 0.00000000001) break;
    }
}

// �Ίp�v�f��\��
void disp_eigenvalue(double a[N][N])
{
    for (int i = 0; i < N; i++)
        cout << setw(14) << fixed << setprecision(10) << a[i][i] << "\t";
    cout << endl;
}
// �ŗL�x�N�g����\��
void disp_eigenvector(double matrix[N][N])
{
    for (int i = 0; i < N; i++)
    {
		double row[N];
        for (int j = 0; j < N; j++)
            row[j] = matrix[i][j] ;
        normarize(row);
        disp_vector(row);
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
