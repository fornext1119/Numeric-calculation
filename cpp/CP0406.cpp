#include <iostream>

using namespace std;

// �K��
int Fact(int n)
{
    if (n <= 1)
        return 1;
    else
        return n * Fact(n - 1);
}

// ���~�K��p
int FallingFact(int x, int n)
{
    if (n <= 1)
        return x;
    else
        return x * FallingFact(x - 1, n - 1);
}

int main()
{
    // ���� (�قȂ� 10 �̂��̂��� 5 ����Ăł��鏇��̑���)
    int n = 10;
    int r = 5;
    cout << (Fact(n) / Fact(n - r)) << endl; 
    cout << FallingFact(n, r) << endl; 
    return 0;
}
