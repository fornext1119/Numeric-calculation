#import <Foundation/Foundation.h>
#import <math.h>

// �d�͉����x
const double g = -9.8;
// ��C��R�W��
const double k = -0.01;
// ���ԊԊu(�b)
const double h = 0.01;

// ��C��R�ɂ�鐅�������̌�����
double fx(double vx, double vy);
// �d�͂Ƌ�C��R�ɂ�鉔�������̌�����
double fy(double vx, double vy);

int main()
{
    // �p�x
    double degree = 45;
    double radian = degree * M_PI / 180.0;
    // ���� 250 km/h -> �b���ɕϊ�
    double v = 250 * 1000 / 3600;
    // ���������̑��x
    double vx[2]; 
    vx[0] = v * cos(radian); 
    // ���������̑��x
    double vy[2]; 
    vy[0] = v * sin(radian); 
    // �o�ߕb��
    double t = 0.0;
    // �ʒu
    double x = 0.0;
    double y = 0.0;

    // Euler�@
	int i;
    for (i = 1; y >= 0.0; i++)
    {
        // �o�ߕb��
        t = i * h;

        // �ʒu
        x += h * vx[0];
        y += h * vy[0];

        printf("%4.2f\t%8.5f\t%9.5f\t%9.5f\t%8.5f\n", t, vx[0], vy[0], x, y);

        // ���x
        vx[1] = vx[0] + h * fx(vx[0], vy[0]);
        vy[1] = vy[0] + h * fy(vx[0], vy[0]);
        vx[0] = vx[1];
        vy[0] = vy[1];
    }
    return 0;
}

// ��C��R�ɂ�鐅�������̌�����
double fx(double vx, double vy)
{
    return k * sqrt(vx * vx + vy * vy) * vx;
}
// �d�͂Ƌ�C��R�ɂ�鉔�������̌�����
double fy(double vx, double vy)
{
    return g + (k * sqrt(vx * vx + vy * vy) * vy);
}