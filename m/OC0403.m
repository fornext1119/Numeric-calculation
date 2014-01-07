#import <Foundation/Foundation.h>

// ŠKæ‚ğ‹‚ß‚éŠÖ”
int Fact(int n)
{
    if (n <= 1)
        return 1;
    else
        return n * Fact(n - 1);
}

int main()
{
    // 10‚ÌŠKæ
    printf("%d\n", Fact(10));
    printf("%d\n", 10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1);
    return 0;
}
