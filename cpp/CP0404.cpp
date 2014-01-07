#include <iostream>

using namespace std;

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
    // 10 ‚©‚ç 6 ‚Ü‚Å‚Ì ‘æ
    cout << FallingFact(10, 5) << endl; 
    cout << (10 * 9 * 8 * 7 * 6) << endl; 
    return 0;
}
