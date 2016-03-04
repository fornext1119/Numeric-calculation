#include <iostream>

using namespace std;

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
    cout << RisingFact(10, 5) << endl; 
    cout << (10 * 11 * 12 * 13 * 14) << endl; 
    return 0;
}
