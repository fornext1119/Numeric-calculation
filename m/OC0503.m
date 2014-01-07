#import <Foundation/Foundation.h>

double myTan(double x, double x2, int n, double t);

int main()
{
    int degree;
    for (degree = -90; degree <= 90; degree += 15)
    {
        if ((degree + 90) % 180 != 0)
        {
            double radian = degree * M_PI / 180.0;
            double x2     = radian * radian;
            // 自作の正接関数
            double d1     = myTan(radian, x2, 15, 0.0); // 15:必要な精度が得られる十分大きな奇数
            // 標準の正接関数
            double d2     = tan(radian);
            // 標準関数との差異
            printf("%+03d : %+13.10f - %+13.10f = %+13.10f\n", degree, d1, d2, d1 - d2);
        }
    }
    return 0;
}

// 自作の正接関数
double myTan(double x, double x2, int n, double t)
{
    t = x2 / (n - t);
    n -= 2;  
    if (n <= 1) 
        return x / (1 - t);
    else
        return myTan(x, x2, n, t);
}
