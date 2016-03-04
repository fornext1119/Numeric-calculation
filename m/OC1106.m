#import <Foundation/Foundation.h>
#import <math.h>

#define N 4

// �n�E�X�z���_�[�ϊ�
void tridiagonalize(double a[N][N], double d[N], double e[N]); 
// QR����
void decomp(double a[N][N], double d[N], double e[N]); 
// �P�����z���\��
void disp_vector(double row[N]); 
// �Q�����z���\��
void disp_matrix(double matrix[N][N]); 

// �n�E�X�z���_�[�ϊ���QR�����ŌŗL�l�����߂�
int main()
{
    double a[N][N] = {{5.0, 4.0, 1.0, 1.0}, 
                      {4.0, 5.0, 1.0, 1.0}, 
                      {1.0, 1.0, 4.0, 2.0},
                      {1.0, 1.0, 2.0, 4.0}};
    double d[N]; 
    double e[N]; 

    // �n�E�X�z���_�[�ϊ�
    tridiagonalize(a, d, e);

	// QR����
    printf("\nQR����\n");
	decomp(a, d, e);

    printf("\neigenvalue\n");
	disp_vector(d);

    printf("\neigenvector\n");
	disp_matrix(a);

    return 0;
}

// �n�E�X�z���_�[�ϊ�
void tridiagonalize(double a[N][N], double d[N], double e[N]) 
{
 	int i, j, k;
   	double v[N]; 

    for (k = 0; k < N - 2; k++) 
    {
	    double w[N] = {0.0 ,0.0 ,0.0 ,0.0};
        d[k] = a[k][k];

        double t = 0.0;
        for (i = k + 1; i < N; i++) 
        {
            w[i] =  a[i][k];
            t    += w[i] * w[i];
        }
        double s = sqrt(t);
        if (w[k + 1] < 0)
            s = -s;

        if (fabs(s) < 0.00000000001)
            e[k + 1] = 0.0;
        else 
        {
            e[k + 1]  = -s;
            w[k + 1] +=  s;
            s = 1 / sqrt(w[k + 1] * s);
        	for (i = k + 1; i < N; i++)
                w[i] *= s;

        	for (i = k + 1; i < N; i++) 
        	{
                s = 0.0;
	        	for (j = k + 1; j < N; j++) 
	        	{
                    if (j <= i)
                        s += a[i][j] * w[j];
                    else
                        s += a[j][i] * w[j];
                }
                v[i] = s;
            }

            s = 0.0;
        	for (i = k + 1; i < N; i++)
                s += w[i] * v[i];
            s /= 2.0;
        	for (i = k + 1; i < N; i++)
                v[i] -= s * w[i];
        	for (i = k + 1; i < N; i++)
	        	for (j = k + 1; j <= i; j++)
                    a[i][j] -= w[i] * v[j] + w[j] * v[i];
            // ���̍s�͌ŗL�x�N�g�������߂Ȃ��Ȃ�s�v
        	for (i = k + 1; i < N; i++)
                a[i][k] = w[i];
        } 
    }

    d[N - 2] = a[N - 2][N - 2];
    d[N - 1] = a[N - 1][N - 1];
    
    e[0]     = 0.0;  
    e[N - 1] = a[N - 1][N - 2];

    // ���̍s�͌ŗL�x�N�g�������߂Ȃ��Ȃ�s�v
	for (k = N - 1; k >= 0; k--) 
	{
	    double w[N] = {0.0 ,0.0 ,0.0 ,0.0};
        if (k < N - 2) 
        {
			for (i = k + 1; i < N; i++)
                w[i] = a[i][k];
			for (i = k + 1; i < N; i++) 
			{
                double s = 0.0;
    			for (j = k + 1; j < N; j++)
                    s += a[i][j] * w[j];
                v[i] = s;
            }
			for (i = k + 1; i < N; i++)
    			for (j = k + 1; j < N; j++)
                    a[i][j] -= v[i] * w[j];
        }
		for (i = 0; i < N; i++)
            a[i][k] = 0.0;
        a[k][k] = 1.0;
    }
}

// QR����
void decomp(double a[N][N], double d[N], double e[N]) 
{
	int i, j, k;

    e[0] = 1.0;
    int h = N - 1;
    while (fabs(e[h]) < 0.00000000001) h--;

    while (h > 0) 
    {
        e[0] = 0.0;
        int l = h - 1;
        while (fabs(e[l]) >= 0.00000000001) l--;

        for (j = 1; j <= 100; j++) 
        {
            double w = (d[h - 1] - d[h]) / 2.0;
            double s = sqrt(w * w + e[h] * e[h]);
            if (w < 0.0)
                s = -s;

            double x = d[l] - d[h] + e[h] * e[h] / (w + s);
            double y = e[l + 1];
            double z = 0.0;
            double t = 0.0;
            double u = 0.0;
            for (k = l; k < h; k++) 
            {
                if (fabs(x) >= fabs(y)) 
                {
                    t = -y / x;
                    u = 1 / sqrt(t * t + 1.0);
                    s = t * u;
                }
                else 
                {
                    t = -x / y;
                    s = 1 / sqrt(t * t + 1.0);
                    if (t < 0)
                        s = -s;
                    u = t * s;
                }
                w = d[k] - d[k + 1];
                t = (w * s + 2 * u * e[k + 1]) * s;
                d[k    ] = d[k    ] - t;
                d[k + 1] = d[k + 1] + t;
                e[k    ] = u * e[k] - s * z;
                e[k + 1] = e[k + 1] * (u * u - s * s) + w * s * u;

                // ���̍s�͌ŗL�x�N�g�������߂Ȃ��Ȃ�s�v
                for (i = 0; i < N; i++) 
                {
                    x = a[k    ][i];  
                    y = a[k + 1][i];
                    a[k    ][i] = u * x - s * y;
                    a[k + 1][i] = s * x + u * y;
                }

                if (k < N - 2) 
                {
                    x = e[k + 1];  
                    y = -s * e[k + 2];  
                    z = y;
                    e[k + 2] = u * e[k + 2];
                }
            }

			printf("%3d\t", j);
			disp_vector(d);

	        // ��������
			if (fabs(e[h]) < 0.00000000001) break;
        }

        e[0] = 1.0;  
        while (fabs(e[h]) < 0.00000000001) h--;
    }

    // ���̍s�͌ŗL�x�N�g�������߂Ȃ��Ȃ�s�v
    for (k = 0; k < N - 1; k++) 
    {
        int l = k;
        for (i = k + 1; i < N; i++) 
            if (d[i] > d[l])
                l = i;

        double t = d[k];  
        d[k] = d[l];  
        d[l] = t;

		for (i = 0; i < N; i++) 
		{
	        t       = a[k][i];  
	        a[k][i] = a[l][i];  
	        a[l][i] = t;
        }
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
// �Q�����z���\��
void disp_matrix(double matrix[N][N]) 
{
	int col, row;
    for (row = 0; row < N; row++) 
    {
    	for (col = 0; col < N; col++)
			printf("%14.10f\t", matrix[row][col]);
	    printf("\n");
    }
}
