#import <Foundation/Foundation.h>

long product(int m, int d, int n); 

int main (int argc, const char * argv[])
{
    // ‰€ 5, Œö· 3, €” 10 ‚Ì”—ñ‚ÌÏ‚ğ•\¦‚·‚é
    printf("%ld\n", product(5, 3, 10));
    return 0;
}
long product(int m, int d, int n) 
{
    if (n == 0)
        return 1;
    else
        return m * product(m + d, d, n - 1);
}
