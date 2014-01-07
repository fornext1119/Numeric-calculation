#include <iostream>
using namespace std;

__int64 product(int m, int d, int n); 

int main()
{
    // ‰€ 5, Œö· 3, €” 10 ‚Ì”—ñ‚ÌÏ‚ğ•\¦‚·‚é
    cout << product(5, 3, 10) << endl; 
    return 0;
}

__int64 product(int m, int d, int n) 
{
    if (n == 0)
        return 1;
    else
        return m * product(m + d, d, n - 1);
}
