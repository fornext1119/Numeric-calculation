#include <iostream>
using namespace std;

int sn(int a, int lim);

int main()
{
    // 3 �̔{���̍��v
    cout << sn(3, 999) << endl;
    return 0;
}
// ����:a, ����:a ��, ���:lim �̐���̑��a��Ԃ��֐�
int sn(int a, int lim)
{
    int n = lim / a;         // ����:n  =  ���:lim / ����:a
    int l = n * a;           // ����:l  =  ����:n   * ����:a
    return (a + l) * n / 2;  // ���a:sn = (����:a   + ����:l) * ����:n / 2
}
