#include <iostream>

using namespace std;

// �㏸�K��p
int RisingFact(int x, int n)
{
    if (n <= 1)
        return x;
    else
        return x * RisingFact(x + 1, n - 1);
}

int main()
{
    // 10 ���� 14 �܂ł� ����
    cout << RisingFact(10, 5) << endl; 
    cout << (10 * 11 * 12 * 13 * 14) << endl; 
    return 0;
}
