#include <iostream>

using namespace std;

// �K������߂�֐�
int Fact(int n)
{
    if (n <= 1)
        return 1;
    else
        return n * Fact(n - 1);
}

int main()
{
    // 10�̊K��
    cout << Fact(10) << endl; 
    cout << (10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1) << endl; 
    return 0;
}
