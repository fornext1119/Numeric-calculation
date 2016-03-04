#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;

const int N = 4;

// �s�{�b�g�I��
void pivoting(double a[N][N], double b[N]);
// �O�i����
void forward_elimination(double a[N][N], double b[N]);
// ��ޑ��
void backward_substitution(double a[N][N], double b[N]);
// �P�����z���\��
void disp_vector(double row[N]);
// �Q�����z���\��
void disp_matrix(double matrix[N][N]);

// �K�E�X�̏����@
int main()
{
    double a[N][N] = {{-1,-2,7,-2},{1,-1,-2,6},{9,2,1,1},{2,8,-2,1}}; 
    double b[N]    = {8,17,20,16};

    // �s�{�b�g�I��
    pivoting(a,b);

    cout << "pivoting" << endl;
    cout << "A" << endl;
    disp_matrix(a);
    cout << "B" << endl;
    disp_vector(b);
    cout << endl;

    // �O�i����
    forward_elimination(a,b);

    cout << "forward elimination" << endl;
    cout << "A" << endl;
    disp_matrix(a);
    cout << "B" << endl;
    disp_vector(b);
    cout << endl;

    // ��ޑ��
    backward_substitution(a,b);

    cout << "X" << endl;
    disp_vector(b);
   
    return 0;
}
// �O�i����
void forward_elimination(double a[N][N], double b[N])
{
    for (int pivot = 0; pivot < N - 1; pivot++)
    {
        for (int row = pivot + 1; row < N; row++)
        {
            double  s   = a[row][pivot] / a[pivot][pivot];
            for (int col = pivot; col < N; col++)
                a[row][col] -= a[pivot][col]    * s;
            b[row]          -= b[pivot]         * s;
        }
    }
}
// ��ޑ��
void backward_substitution(double a[N][N], double b[N])
{
    for (int row = N - 1; row >= 0; row--)
    {
        for (int col = N - 1; col > row; col--)
            b[row] -= a[row][col] * b[col];
        b[row] /= a[row][row];
    }
}
// �s�{�b�g�I��
void pivoting(double a[N][N], double b[N])
{
    for(int pivot = 0; pivot < N; pivot++)
    {
        // �e��� ��Ԓl���傫���s�� �T��
        int     max_row =   pivot;
        double  max_val =   0;
        for (int row = pivot; row < N; row++)
        {
            if (fabs(a[row][pivot]) > max_val)
            {
                // ��Ԓl���傫���s
                max_val =   fabs(a[row][pivot]);
                max_row =   row;
            }
        }

        // ��Ԓl���傫���s�Ɠ���ւ�
        if (max_row != pivot)
        {
            double tmp;
            for (int col = 0; col < N; col++)
            {
                tmp             =   a[max_row][col];
                a[max_row][col] =   a[pivot][col];
                a[pivot][col]   =   tmp;
            }
            tmp         =   b[max_row];
            b[max_row]  =   b[pivot];
            b[pivot]    =   tmp;
        }
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
