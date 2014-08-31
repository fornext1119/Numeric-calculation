#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;

const int N = 4;

// ヤコビの反復法
void jacobi(double a[N][N], double b[N], double c[N]);

int main()
{
    double a[N][N] = {{9,2,1,1},{2,8,-2,1},{-1,-2,7,-2},{1,-1,-2,6}}; 
    double b[N]    = {20,16,8,17};
    double c[N]    = {0,0,0,0};

    // ヤコビの反復法
    jacobi(a,b,c);

    cout << "解" << endl;
    for (int i = 0; i < N; i++)
        cout << setw(14) << fixed << setprecision(10) << c[i] << "\t";
    cout << endl;
   
    return 0;
}

// ヤコビの反復法
void jacobi(double a[N][N], double b[N], double x0[N])
{
    while (true)
    {
        double x1[N];
        bool finish = true;
        for (int i = 0; i < N; i++)
        {
            x1[i] = 0;
            for (int j = 0; j < N; j++)
                if (j != i)
                    x1[i] += a[i][j] * x0[j];

            x1[i] = (b[i] - x1[i]) / a[i][i];
            if (fabs(x1[i] - x0[i]) > 0.0000000001) finish = false;
        }

        for (int i = 0; i < N; i++)
        {
            x0[i] = x1[i];
            cout << setw(14) << fixed << setprecision(10) << x0[i] << "\t";
        }
        cout << endl;
        if (finish) return;
    }
}
