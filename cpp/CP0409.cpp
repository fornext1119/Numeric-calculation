#include <iostream>

using namespace std;

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
    // 重複組合せ (異なる 10 個のものから重複を許して 5 個とる組合せの総数)
    int n = 10;
    int r = 5;
    cout << Comb(n + r - 1, r) << endl; 

    return 0;
}
