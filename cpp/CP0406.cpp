#include <iostream>

using namespace std;

// 階乗
int Fact(int n)
{
    if (n <= 1)
        return 1;
    else
        return n * Fact(n - 1);
}

// 下降階乗冪
int FallingFact(int x, int n)
{
    if (n <= 1)
        return x;
    else
        return x * FallingFact(x - 1, n - 1);
}

int main()
{
    // 順列 (異なる 10 個のものから 5 個取ってできる順列の総数)
    int n = 10;
    int r = 5;
    cout << (Fact(n) / Fact(n - r)) << endl; 
    cout << FallingFact(n, r) << endl; 
    return 0;
}
