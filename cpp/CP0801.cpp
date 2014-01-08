#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;

int main(void)
{
    // 角度 
    double degree = 45;//70;//45; 
    double radian = degree * M_PI / 180.0;

    // 初速 150 km/h -> 秒速に変換
    double v = 150 * 1000 / 3600; 
    // 水平方向の速度
    double vx = v * cos(radian); 
    // 鉛直方向の速度
    double vy = v * sin(radian); 
    double vy0 = vy; 

    // 重力加速度
    double g = 9.8;

    // 時間間隔(秒)
    double dt = 0.1;
    // 経過秒数
    double t = 0.0;
    //位置
    double x = 0.0;
    double y = 0.0;

    // Euler法
    for (int i = 1; y >= 0.0; i++) 
    {
        t = i * dt;
        y = y + dt * vy;
        x = x + dt * vx;

        cout << setw(8) << fixed << setprecision(5) << t      << "\t";
        cout << setw(8) << fixed << setprecision(5) << x      << "\t";
        cout << setw(8) << fixed << setprecision(5) << vx * t << "\t";
        cout << setw(8) << fixed << setprecision(5) << y      << "\t";
        cout << setw(8) << fixed << setprecision(5) << vy0 * t - (g * t * t) / 2 << endl;

        // 鉛直方向の速度
        vy = vy - (dt * g);
    }
    return 0;
}
