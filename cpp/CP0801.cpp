#include <stdio.h>
#include <math.h>

// 元の関数
double f(double x);
// 導関数
double fd(double x);
// Euler法
void euler(double x, double y, int n);  

int main(void)
{
    double x = 0.0;
    double y = f(x);

    for (int n = 4; n <= 128; n *= 2) {
    	printf("分割数 = %d\n", n);
		euler(x, y, n);
	}
	return 0;
}

// 元の関数
double f(double x)
{
    return x - pow(x,3) / (3 * 2) + pow(x,5) / (5 * 4 * 3 * 2);
}
// 導関数
double fd(double x)
{
    return 1 - pow(x,2) / 2 + pow(x,4) / (4 * 3 * 2); 
}

// Euler法
void euler(double x, double y, int n)  
{
    double h = 1.0 / n;

    for (int i = 1; i <= n; i++) {
    	y = y + h * fd(x);
        x = x + h;
        double z = f(x);
		printf("%8.5f \t %8.5f \t %8.5f \t %8.5f\n", x, y, z, y - z);
	}
}
