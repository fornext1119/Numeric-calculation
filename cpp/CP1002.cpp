#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;

const int N = 4;

// ガウス・ザイデル法
void gauss(double a[N][N], double b[N], double c[N]);
// １次元配列を表示
void disp_vector(double row[N]);

int main()
{
    double a[N][N] = {{9,2,1,1},{2,8,-2,1},{-1,-2,7,-2},{1,-1,-2,6}}; 
    double b[N]    = {20,16,8,17};
    double c[N]    = {0,0,0,0};

	// ガウス・ザイデル法
    gauss(a,b,c);

    cout << "X" << endl;
    disp_vector(c);

    return 0;
}

// ガウス・ザイデル法
void gauss(double a[N][N], double b[N], double x0[N])
{
    while (true)
    {
        bool finish = true;
        for (int i = 0; i < N; i++)
        {
            double x1 = 0;
            for (int j = 0; j < N; j++)
                if (j != i)
                    x1 += a[i][j] * x0[j];

            x1 = (b[i] - x1) / a[i][i];
            if (fabs(x1 - x0[i]) > 0.0000000001) finish = false;
            x0[i] = x1;
        }
        if (finish) return;

	    disp_vector(x0);
    }
}

// １次元配列を表示
void disp_vector(double row[N])
{
    for (int i = 0; i < N; i++)
        cout << setw(14) << fixed << setprecision(10) << row[i] << "\t";
    cout << endl;
}
