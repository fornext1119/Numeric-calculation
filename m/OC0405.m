#import <Foundation/Foundation.h>

// ã¸ŠKæ™p
int RisingFact(int x, int n)
{
    if (n <= 1)
        return x;
    else
        return x * RisingFact(x + 1, n - 1);
}

int main()
{
    // 10 ‚©‚ç 14 ‚Ü‚Å‚Ì ‘æ
    printf("%d\n", RisingFact(10, 5));
    printf("%d\n", 10 * 11 * 12 * 13 * 14);
    return 0;
}
