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
    double v = 150 * 1000 / 3600; 
    // 水平方向の速度
    double vx = v * cos(radian); 
    // 鉛直方向の速度
    double vy = v * sin(radian); 
    // 経過秒数
    double t = 0.0;
    // 位置
    double x = 0.0;
    double y = 0.0;

    // 速度
    double vxs = fx(vx, v);
    double vys = fy(vy, v);
    v = sqrt(vxs * vxs + vys * vys);

    // Heun法
    for (int i = 1; y >= 0.0; i++) 
    {
        // 速度
        vx = fx(vxs, v);
        vy = fy(vys, v);
        v = sqrt(vx * vx + vy * vy);

        // 位置 (Heun法)
        x = x + dt * (vxs + vx) / 2; 
        y = y + dt * (vys + vy) / 2; 

        // 経過秒数
        t = i * dt;
        cout << setw(8) << fixed << setprecision(5) << t << "\t";

        // 速度
        cout << setw(8) << fixed << setprecision(5) << (vxs + vx) / 2 << "\t";
        cout << setw(9) << fixed << setprecision(5) << (vys + vy) / 2 << "\t";

        // 位置
        cout << setw(9) << fixed << setprecision(5) << x << "\t";
        cout << setw(8) << fixed << setprecision(5) << y << endl;

        vxs = vx;
        vys = vy;
    }
    return 0;
}
