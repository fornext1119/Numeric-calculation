#import <Foundation/Foundation.h>

int sn(int a, int lim);

int main (int argc, const char * argv[])
{
    // 3 �̔{���̍��v
    printf("%d\n", sn(3, 999));
    return 0;
}
// ����:a, ����:a ��, ���:lim �̐���̑��a��Ԃ��֐�
int sn(int a, int lim)
{
    int n = lim / a;        // ����:n  =  ���:lim / ����:a
    int l = n * a;          // ����:l  =  ����:n   * ����:a
    return (a + l) * n / 2; // ���a:sn = (����:a   + ����:l) * ����:n / 2
}
