#include <iostream>
#include <iomanip>
#include <math.h>
using namespace std;

// èdóÕâ¡ë¨ìx
const double g = -9.8;
// ãÛãCíÔçRåWêî
const double k = -0.01;
// éûä‘ä‘äu(ïb)
const double h = 0.01;

// ãÛãCíÔçRÇ…ÇÊÇÈêÖïΩï˚å¸ÇÃå∏ë¨ï™
double fx(double vx, double vy);
// èdóÕÇ∆ãÛãCíÔçRÇ…ÇÊÇÈâîíºï˚å¸ÇÃå∏ë¨ï™
double fy(double vx, double vy);

int main()
{
    // äpìx 
    double degree = 45;
    double radian = degree * M_PI / 180.0;
    // èâë¨ 250 km/h -> ïbë¨Ç…ïœä∑
    double v = 250 * 1000 / 3600; 
    // êÖïΩï˚å¸ÇÃë¨ìx
    double vx[5]; 
    vx[0] = v * cos(radian); 
    // âîíºï˚å¸ÇÃë¨ìx
    double vy[5]; 
    vy[0] = v * sin(radian); 
    // åoâﬂïbêî
    double t = 0.0;
    // à íu
    double x[5];
    x[0] = 0.0;
    double y[5];
    y[0] = 0.0;

    // Runge-Kuttañ@
    for (int i = 1; y[0] >= 0.0; i++) 
    {
        // åoâﬂïbêî
        t = i * h;
        cout << setw(4) << fixed << setprecision(2) << t << "\t";

        // à íuÅEë¨ìx
        x[1]  = h *    vx[0];
        y[1]  = h *    vy[0];
        vx[1] = h * fx(vx[0], vy[0]);
        vy[1] = h * fy(vx[0], vy[0]);

        double wx = vx[0] + vx[1] / 2;
        double wy = vy[0] + vy[1] / 2;
        x[2]  = h *    wx;
        y[2]  = h *    wy;
        vx[2] = h * fx(wx, wy);
        vy[2] = h * fy(wx, wy);

        wx    = vx[0] + vx[2] / 2;
        wy    = vy[0] + vy[2] / 2;
        x[3]  = h *    wx;
        y[3]  = h *    wy;
        vx[3] = h * fx(wx, wy);
        vy[3] = h * fy(wx, wy);

        wx    = vx[0] + vx[3];
        wy    = vy[0] + vy[3];
        x[4]  = h *    wx;
        y[4]  = h *    wy;
        vx[4] = h * fx(wx, wy);
        vy[4] = h * fy(wx, wy);

        x[0]  += ( x[1] +  x[2] * 2 +  x[3] * 2 +  x[4]) / 6;
        y[0]  += ( y[1] +  y[2] * 2 +  y[3] * 2 +  y[4]) / 6;
        vx[0] += (vx[1] + vx[2] * 2 + vx[3] * 2 + vx[4]) / 6;
        vy[0] += (vy[1] + vy[2] * 2 + vy[3] * 2 + vy[4]) / 6;

        cout << setw(8) << fixed << setprecision(5) << vx[0] << "\t";
        cout << setw(9) << fixed << setprecision(5) << vy[0] << "\t";
        cout << setw(9) << fixed << setprecision(5) <<  x[0] << "\t";
        cout << setw(8) << fixed << setprecision(5) <<  y[0] << endl;
    }
    return 0;
}

// ãÛãCíÔçRÇ…ÇÊÇÈêÖïΩï˚å¸ÇÃå∏ë¨ï™
double fx(double vx, double vy)
{
    return k * sqrt(vx * vx + vy * vy) * vx;
}
// èdóÕÇ∆ãÛãCíÔçRÇ…ÇÊÇÈâîíºï˚å¸ÇÃå∏ë¨ï™
double fy(double vx, double vy)
{
    return g + (k * sqrt(vx * vx + vy * vy) * vy);
}
