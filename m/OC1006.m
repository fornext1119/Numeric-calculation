#import <Foundation/Foundation.h>
#import <math.h>

const int N = 4;

// �O�i����
void forward_elimination(double a[N][N], double b[N]);
// �O�i���
void forward_substitution(double a[N][N], double b[N], double y[N]);
// ��ޑ��
void backward_substitution(double a[N][N], double y[N], double x[N]);
// �P�����z���\��
void disp_vector(double row[N]);
// �Q�����z���\��
void disp_matrix(double matrix[N][N]);

// �R���X�L�[�@
int main()
{
    double a[4][4] = {{5,2,3,4},{2,10,6,7},{3,6,15,9},{4,7,9,20}}; 
    double b[4]    = {34,68,96,125};

    printf("A\n");
	disp_matrix(a);
    printf("B\n");
    disp_vector(b);
    printf("\n");

    // �O�i����
    forward_elimination(a,b);

    printf("LL^T\n");
	disp_matrix(a);

    // Ly=b ���� y �����߂� (�O�i���)
    double y[4] = {0,0,0,0};
    forward_substitution(a,b,y);

    printf("Y\n");
    disp_vector(y);

    // L^Tx=y ���� x �����߂� (��ޑ��)
    double x[4] = {0,0,0,0};
    backward_substitution(a,y,x);

    printf("X\n");
    disp_vector(x);

    return 0;
}
// �O�i����
void forward_elimination(double a[N][N], double b[N])
{
    int pivot, row, col;
    for (pivot = 0; pivot < N; pivot++)
    {
        double s = 0;
        for (col = 0; col < pivot; col++)
            s += a[pivot][col] * a[pivot][col];
        // �����ō����̒������̒l�ɂȂ�ƌv�Z�ł��Ȃ��I
        a[pivot][pivot] = sqrt(a[pivot][pivot] - s);

        for (row = pivot + 1; row < N; row++)
        {
            s = 0;
            for (col = 0; col < pivot; col++)
                s += a[row][col] * a[pivot][col];
            a[row][pivot] =  (a[row][pivot] - s) / a[pivot][pivot];
            a[pivot][row] =  a[row][pivot];
        } 
    }
}
// �O�i���
void forward_substitution(double a[N][N], double b[N], double y[N])
{
    int row, col;
    for (row = 0; row < N; row++)
    {
        for (col = 0; col < row; col++)
            b[row] -= a[row][col] * y[col];
        y[row] = b[row] / a[row][row];
    }
}
// ��ޑ��
void backward_substitution(double a[N][N], double y[N], double x[N])
{
	int row, col;
    for (row = N - 1; row >= 0; row--)
    {
        for (col = N - 1; col > row; col--)
            y[row] -= a[row][col] * x[col];
        x[row] = y[row] / a[row][row];
    }
}
// �P�����z���\��
void disp_vector(double row[N])
{
	int i;
    for (i = 0; i < N; i++)
    {
        printf("%14.10f\t", row[i]);
    }
    printf("\n");
}
// �Q�����z���\��
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
