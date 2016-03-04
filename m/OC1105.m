#import <Foundation/Foundation.h>
#import <math.h>

#define N 4

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

    printf("\neigenvalue\n");
	disp_eigenvalue(a);

    printf("\neigenvector\n");
	disp_eigenvector(v);

    return 0;
}

// ���R�r�@
void jacobi(double a[N][N], double v[N][N])
{
	int i, j, k;
    for (k = 1; k <= 100; k++)
    {
        // �ő�l��T��
		int p = 0;
		int q = 0;
        double max_val = 0.0;
        for (i = 0; i < N; i++)
        {
            for (j = i + 1; j < N; j++)
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
        double t = 0.0;
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
        double t1 = 0.0;
        double t2 = 0.0;
        for (i = 0; i < N; i++)
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
        for (i = 0; i < N; i++)
        {
            t1      =  a[i][p] * c + a[i][q] * s;
            t2      = -a[i][p] * s + a[i][q] * c;
            a[i][p] = t1;
            a[i][q] = t2;
        }

        // �Ίp�v�f��\��
		printf("%3d\t", k);
        disp_eigenvalue(a);

        // ��������
    	if (max_val < 0.00000000001) break;
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
// �ŗL�x�N�g����\��
void disp_eigenvector(double matrix[N][N])
{
	int i, j;
    for (i = 0; i < N; i++)
    {
		double row[N];
        for (j = 0; j < N; j++)
            row[j] = matrix[i][j] ;
        normarize(row);
        disp_vector(row);
	}
}
// �P�����z���\��
void disp_vector(double row[N])
{
	int i;
    for (i = 0; i < N; i++)
		printf("%14.10f\t", row[i]);
    printf("\n");
}
// ���K�� (�x�N�g���̒������P�ɂ���)
void normarize(double x[N])
{
	int i;
    double s = 0.0;

    for (i = 0; i < N; i++)
        s += x[i] * x[i];
    s = sqrt(s);
    
    for (i = 0; i < N; i++)
        x[i] /= s;
}
