#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;

// 重力加速度
const double g = 9.8;

// 水平方向の速度
double fx(double t, double vx)
{
    // 水平方向の速度は, 初速のまま   
    return vx; 
}
// 鉛直方向の速度
double fy(double t, double vy)
{
    // 初速から落下速度を引く 
    return vy - (t * g);
}

int main(void)
{
    // 角度 
    double degree = 45;
    double radian = degree * M_PI / 180.0;
    // 初速 150 km/h -> 秒速に変換
    double v = 150 * 1000 / 3600; 
    // 水平方向の速度
    double vx = v * cos(radian); 
    // 鉛直方向の速度
    double vy = v * sin(radian); 
    // 時間間隔(秒)
    double dt = 0.01;
    // 経過秒数
    double t = 0.0;
    // 位置
    double x = 0.0;
    double y = 0.0;

    // Euler法
    for (int i = 1; y >= 0.0; i++) 
    {
        // 位置
        x = x + dt * fx(t, vx);
        y = y + dt * fy(t, vy);
        // 経過秒数
        t = i * dt;

        // 経過秒数
        cout << setw(8) << fixed << setprecision(5) << t      << "\t";
        // 位置 (Euler法)
        cout << setw(8) << fixed << setprecision(5) << x      << "\t";
        cout << setw(8) << fixed << setprecision(5) << y      << "\t";
        // 位置 (正解)
        cout << setw(8) << fixed << setprecision(5) << vx * t << "\t";
        cout << setw(8) << fixed << setprecision(5) << vy * t - (g * t * t) / 2 << endl;
    }
    return 0;
}
