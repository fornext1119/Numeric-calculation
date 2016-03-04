#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;

const int N = 4;

// �O�i����
void forward_elimination(double a[N][N]);
// �O�i���
void forward_substitution(double a[N][N], double b[N], double y[N]);
// ��ޑ��
void backward_substitution(double a[N][N], double y[N], double x[N]);
// �P�����z���\��
void disp_vector(double row[N]);
// �Q�����z���\��
void disp_matrix(double matrix[N][N]);

// �C���R���X�L�[�@
int main()
{
    double a[N][N] = {{5,2,3,4},{2,10,6,7},{3,6,15,9},{4,7,9,20}}; 
    double b[N]    = {34,68,96,125};

    cout << "A" << endl;
    disp_matrix(a);
    cout << "B" << endl;
    disp_vector(b);
    cout << endl;

    // �O�i����
    forward_elimination(a);

    cout << "LDL^T" << endl;
    disp_matrix(a);

    // Ly=b ���� y �����߂� (�O�i���)
    double y[N] = {0,0,0,0};
    forward_substitution(a, b, y);

    cout << "Y" << endl;
    disp_vector(y);

    // DL^Tx=y ���� x �����߂� (��ޑ��)
    double x[N] = {0,0,0,0};
    backward_substitution(a, y, x);
    
    cout << "X" << endl;
    disp_vector(x);

    return 0;
}
// �O�i����
void forward_elimination(double a[N][N])
{
    for (int pivot = 0; pivot < N; pivot++)
    {
        double s;

        // pivot < k �̏ꍇ
        for (int col = 0; col < pivot; col++)
        {
            s = a[pivot][col];
            for (int k = 0; k < col; k++)
                s -= a[pivot][k] * a[col][k] * a[k][k];
            a[pivot][col] = s / a[col][col];
            a[col][pivot] = a[pivot][col];
        }
 
        // pivot == k �̏ꍇ
        s = a[pivot][pivot];
        for (int k = 0; k < pivot; k++)
            s -= a[pivot][k] * a[pivot][k] * a[k][k];
        a[pivot][pivot] = s;
    }
}
// �O�i���
void forward_substitution(double a[N][N], double b[N], double y[N])
{
    for (int row = 0; row < N; row++)
    {
        for (int col = 0; col < row; col++)
            b[row] -= a[row][col] * y[col];
        y[row] = b[row];
    }
}
// ��ޑ��
void backward_substitution(double a[N][N], double y[N], double x[N])
{
    for (int row = N - 1; row >= 0; row--)
    {
        for (int col = N - 1; col > row; col--)
            y[row] -= a[row][col] * a[row][row] * x[col];
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
// �Q�����z���\��
void disp_matrix(double matrix[N][N])
{
    for (int i = 0; i < N; i++) 
    {
        for (int j = 0; j < N; j++) 
            cout << setw(14) << fixed << setprecision(10) << matrix[i][j] << "\t";
        cout << endl;
    }
}
