#import <Foundation/Foundation.h>

// ŠKæ
int Fact(int n)
{
    if (n <= 1)
        return 1;
    else
        return n * Fact(n - 1);
}

// ‰º~ŠKæ™p
int FallingFact(int x, int n)
{
    if (n <= 1)
        return x;
    else
        return x * FallingFact(x - 1, n - 1);
}

int main()
{
    // ‡—ñ (ˆÙ‚È‚é 10 ŒÂ‚Ì‚à‚Ì‚©‚ç 5 ŒÂæ‚Á‚Ä‚Å‚«‚é‡—ñ‚Ì‘”)
    int n = 10;
    int r = 5;
    printf("%d\n", (Fact(n) / Fact(n - r)));
    printf("%d\n", FallingFact(n, r));
    return 0;
}
