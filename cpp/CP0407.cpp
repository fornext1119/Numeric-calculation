#include <iostream>
#include <math.h>

using namespace std;

int main()
{
    // 重複順列 (異なる 10 個のものから重複を許して 5 個取ってできる順列の総数)
    int n = 10;
    int r = 5;
    cout << pow(n, r) << endl; 
    return 0;
}
