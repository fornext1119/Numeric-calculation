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
    double vx[3]; 
    vx[0] = v * cos(radian); 
    // âîíºï˚å¸ÇÃë¨ìx
    double vy[3]; 
    vy[0] = v * sin(radian); 
    // åoâﬂïbêî
    double t = 0.0;
    // à íu
    double x[3];
    x[0] = 0.0;
    double y[3];
    y[0] = 0.0;

    // Heunñ@
    for (int i = 1; y[0] >= 0.0; i++) 
    {
        // åoâﬂïbêî
        t = i * h;
        cout << setw(4) << fixed << setprecision(2) << t << "\t";

        // à íuÅEë¨ìx
        x[1]  =  x[0] + h *    vx[0];
        y[1]  =  y[0] + h *    vy[0];
        vx[1] = vx[0] + h * fx(vx[0], vy[0]);
        vy[1] = vy[0] + h * fy(vx[0], vy[0]);

        x[2]  =  x[0] + h * (  vx[0]          +    vx[1]        ) / 2;
        y[2]  =  y[0] + h * (  vy[0]          +    vy[1]        ) / 2;
        vx[2] = vx[0] + h * (fx(vx[0], vy[0]) + fx(vx[1], vy[1])) / 2;
        vy[2] = vy[0] + h * (fy(vx[0], vy[0]) + fy(vx[1], vy[1])) / 2;

        x[0]  =  x[2];
        y[0]  =  y[2];
        vx[0] = vx[2];
        vy[0] = vy[2];

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
