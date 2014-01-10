#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;

// 重力加速度
const double g = 9.8;
// 空気抵抗
const double k = 0.01;
// 時間間隔(秒)
const double dt = 0.1;

// 水平方向の速度
double fx(double vx, double v)
{
    // 初速から空気抵抗による減速分を引く
    double ax = k * v * vx;
    return vx - ax * dt; 
}
// 鉛直方向の速度
double fy(double vy, double v)
{
    // 初速から落下速度と空気抵抗による減速分を引く
    double ay = k * v * vy;
    return vy - (g + ay) * dt;
}

int main(void)
{
    // 角度 
    double degree = 30;
    double radian = degree * M_PI / 180.0;
    // 初速 150 km/h -> 秒速に変換
    double v = 70;//150 * 1000 / 3600; 
    // 水平方向の速度
    double vx = v * cos(radian); 
    // 鉛直方向の速度
    double vy = v * sin(radian); 
    // 経過秒数
    double t = 0.0;
    // 位置
    double x = 0.0;
    double y = 0.0;

    // Heun法
    for (int i = 1; y >= 0.0; i++) 
    {
        // 経過秒数
        t = i * dt;
        cout << setw(8) << fixed << setprecision(5) << t      << "\t";

        // 速度
        vx = fx(vx, v);
        vy = fy(vy, v);
        v = sqrt(vx * vx + vy * vy);
        cout << setw(8) << fixed << setprecision(5) << vx      << "\t";
        cout << setw(8) << fixed << setprecision(5) << vy      << "\t";

        // 位置 (Euler法)
        x = x + dt * vx;
        y = y + dt * vy;                             

        // 位置
        cout << setw(9) << fixed << setprecision(5) << x      << "\t";
        cout << setw(9) << fixed << setprecision(5) << y      << "\t";
    }
    return 0;
}
