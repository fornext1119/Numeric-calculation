#import <Foundation/Foundation.h>

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
    printf("%d\n", Fact(10));
    printf("%d\n", 10 * 9 * 8 * 7 * 6 * 5 * 4 * 3 * 2 * 1);
    return 0;
}
