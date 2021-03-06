#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;

// 重力加速度
const double g = -9.8;
// 空気抵抗係数
const double k = -0.01;
// 時間間隔(秒)
const double h = 0.01;

// 空気抵抗による水平方向の減速分
double fx(double vx, double vy);
// 重力と空気抵抗による鉛直方向の減速分
double fy(double vx, double vy);

int main()
{
    // 角度 
    double degree = 45;
    double radian = degree * M_PI / 180.0;
    // 初速 250 km/h -> 秒速に変換
    double v = 250 * 1000 / 3600; 
    // 水平方向の速度
    double vx[3]; 
    vx[0] = v * cos(radian); 
    // 鉛直方向の速度
    double vy[3]; 
    vy[0] = v * sin(radian); 
    // 経過秒数
    double t = 0.0;
    // 位置
    double x = 0.0;
    double y = 0.0;

    // 後退 Euler法
    for (int i = 1; y >= 0.0; i++) 
    {
        // 経過秒数
        t = i * h;
        cout << setw(4) << fixed << setprecision(2) << t << "\t";

        // 位置・速度
        vx[1] = vx[0] + h * fx(vx[0], vy[0]);
        vy[1] = vy[0] + h * fy(vx[0], vy[0]);
        for (int j = 0; j <= 10; j++)
        {
            vx[2] = vx[0] + h * fx(vx[1], vy[1]);
	        vy[2] = vy[0] + h * fy(vx[1], vy[1]);
            if ((fabs(vx[1] - vx[2]) < 0.00001) && (fabs(vy[1] - vy[2]) < 0.00001)) break;
            vx[1] = vx[2];
            vy[1] = vy[2];
         }
        vx[0] = vx[1];
        vy[0] = vy[1];
        x += h * vx[0];
        y += h * vy[0];

        cout << setw(8) << fixed << setprecision(5) << vx[0] << "\t";
        cout << setw(9) << fixed << setprecision(5) << vy[0] << "\t";
        cout << setw(9) << fixed << setprecision(5) <<  x    << "\t";
        cout << setw(8) << fixed << setprecision(5) <<  y    << endl;
    }
    return 0;
}

// 空気抵抗による水平方向の減速分
double fx(double vx, double vy)
{
    return k * sqrt(vx * vx + vy * vy) * vx;
}
// 重力と空気抵抗による鉛直方向の減速分
double fy(double vx, double vy)
{
    return g + (k * sqrt(vx * vx + vy * vy) * vy);
}
