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
    double x = 0.0;
    double y = 0.0;

    // å„ëﬁ Eulerñ@
    for (int i = 1; y >= 0.0; i++) 
    {
        // åoâﬂïbêî
        t = i * h;
        cout << setw(4) << fixed << setprecision(2) << t << "\t";

        // à íuÅEë¨ìx
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
