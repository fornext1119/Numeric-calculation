#include <iostream>
#include <math.h>

using namespace std;

int main()
{
    // ‰€ 2, Œö”ä 3, €” 10 ‚Ì“™”ä”—ñ‚Ì˜a
    int n = 10;
    int a = 2;
    int r = 3;
    cout << ( (a * (pow(r, n) - 1)) / (r - 1) ) << endl; 
    return 0;
}
