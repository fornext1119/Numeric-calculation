#include <iostream>
using namespace std;

int main()
{
    int a = 5;     // ‰€ 5
    int d = 3;     // Œö· 3
    int n = 10;    // €” 10
    __int64 p = 1; // Ï
    
    for (int i = 1; i <= n; i++)
    {
        int m = a + (d * (i - 1));
        p *= m;
    }    
   cout << p << endl; 

   return 0;
}
