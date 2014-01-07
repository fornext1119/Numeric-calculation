#import <Foundation/Foundation.h>

int main (int argc, const char * argv[])
{
    int a = 5;  // ‰€ 5
    int d = 3;  // Œö· 3
    int n = 10; // €” 10
    long p = 1; // Ï

    int i;
    for (i = 1; i <= n; i++)
    {
        int m = a + (d * (i - 1));
        p *= m;
    }    
    printf("%ld\n", p);

    return 0;
}
