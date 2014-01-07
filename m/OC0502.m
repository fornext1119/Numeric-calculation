#import <Foundation/Foundation.h>

double myCos(double x, int n, bool nega, double numerator, double denominator, double y);

int main()
{
    int degree;
    for (degree = 0; degree <= 360; degree += 15)
    {
        if (degree % 30 == 0 || degree % 45 == 0)
        {
            double radian = degree * M_PI / 180.0;
            // 自作の余弦関数
            double d1     = myCos(radian, 1, false, 1.0, 1.0, 1.0);
            // 標準の余弦関数
            double d2     = cos(radian);
            // 標準関数との差異
            printf("%03d : %+13.10f - %+13.10f = %+13.10f\n", degree, d1, d2, d1 - d2);
        }
    }
    return 0;
}

// 自作の余弦関数
double myCos(double x, int n, bool nega, double numerator, double denominator, double y)
{
    int m       = 2 * n;
    denominator = denominator * m * (m - 1);
    numerator   = numerator   * x * x;
    double a    = numerator / denominator;
    // 十分な精度になったら処理を抜ける
    if (a <= 0.00000000001) 
        return y;
    else
        return y + myCos(x, ++n, !nega, numerator, denominator, nega ? a : -a);
}
