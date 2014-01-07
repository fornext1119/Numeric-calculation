#import <Foundation/Foundation.h>

// 組合せ
int Comb(int n, int r)
{
    if (r == 0 || r == n)
        return 1;
    else if (r == 1)
        return n;
    else
        return Comb(n - 1, r - 1) + Comb(n - 1, r);
}

int main()
{
    // 組合せ (異なる 10 個のものから 5 個取ってできる組合せの総数)
    printf("%d\n", Comb(n, r));
    return 0;
}
